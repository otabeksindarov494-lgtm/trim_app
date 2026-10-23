import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:trim_app/core/services/salon_service.dart';

import '../../../../theme/app_theme.dart';
import '../../../../widgets/common/glass.dart';

class MapSalon {
  final String id;
  final String name;
  final String address;
  final double rating;
  final String image;
  final Point point;
  double? distanceInKm;

  MapSalon({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.image,
    required this.point,
    this.distanceInKm,
  });

  String get formattedDistance {
    if (distanceInKm == null) return "Noma'lum uzoqlik";
    if (distanceInKm! < 1.0) {
      return "${(distanceInKm! * 1000).round()} m uzoqlikda";
    }
    return "${distanceInKm!.toStringAsFixed(1)} km uzoqlikda";
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  YandexMapController? _mapController;
  Position? _userPosition;

  bool _isLoadingLocation = true;
  bool _hasLocationPermission = false;
  String? _statusMessage;

  MapSalon? _selectedSalon;
  List<MapSalon> _salons = [];
  List<MapSalon> _filteredSalons = [];

  double _currentZoom = 13.5;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  static const Point _defaultCenter = Point(
    latitude: 41.311081,
    longitude: 69.240562,
  );

  @override
  void initState() {
    super.initState();
    _loadInitialSalons();
    _checkLocationPermissionAndFetch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadInitialSalons() async {
    try {
      final subscriptionSalons = await SalonService().getSalons();
      final mapSalons = subscriptionSalons.map((s) {
        return MapSalon(
          id: s.id,
          name: s.title,
          address: s.podcastCount,
          rating: s.rating,
          image: s.image.isNotEmpty ? s.image : 'assets/images/img_23.png',
          point: Point(
            latitude: s.latitude ?? 41.311081,
            longitude: s.longitude ?? 69.240562,
          ),
        );
      }).toList();

      if (mounted) {
        setState(() {
          _salons = mapSalons;
          _filteredSalons = List.from(mapSalons);
          if (_salons.isNotEmpty) {
            _selectedSalon = _salons.first;
          }
        });
      }
    } catch (e) {
      // Fallback
    }
  }

  Future<void> _checkLocationPermissionAndFetch() async {
    setState(() {
      _isLoadingLocation = true;
      _statusMessage = "Joylashuvingiz aniqlanmoqda...";
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
          _statusMessage = "GPS xizmati o'chirilgan";
        });
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            _isLoadingLocation = false;
            _hasLocationPermission = false;
            _statusMessage = "Joylashuvga ruxsat berilmadi";
          });
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
          _hasLocationPermission = false;
          _statusMessage = "Sozlamalardan joylashuvga ruxsat bering";
        });
      }
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      if (mounted) {
        setState(() {
          _userPosition = position;
          _hasLocationPermission = true;
          _isLoadingLocation = false;
          _statusMessage = "Joylashuvingiz aniqlandi";
        });

        _recalculateDistancesAndSort();

        if (_mapController != null) {
          await _moveToUserPosition();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
          _statusMessage = "Joylashuvni aniqlash imkoni bo'lmadi";
        });
      }
    }
  }

  void _recalculateDistancesAndSort() {
    if (_userPosition == null) return;

    for (var salon in _salons) {
      double distanceInMeters = Geolocator.distanceBetween(
        _userPosition!.latitude,
        _userPosition!.longitude,
        salon.point.latitude,
        salon.point.longitude,
      );
      salon.distanceInKm = distanceInMeters / 1000.0;
    }

    _salons.sort((a, b) => (a.distanceInKm ?? 999).compareTo(b.distanceInKm ?? 999));

    _applySearchFilter(_searchController.text);
  }

  void _applySearchFilter(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredSalons = List.from(_salons);
      } else {
        _filteredSalons = _salons.where((s) {
          return s.name.toLowerCase().contains(query.toLowerCase()) ||
              s.address.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }

      if (_filteredSalons.isNotEmpty &&
          (_selectedSalon == null || !_filteredSalons.contains(_selectedSalon))) {
        _selectedSalon = _filteredSalons.first;
      }
    });
  }

  Future<void> _moveToUserPosition() async {
    if (_userPosition == null || _mapController == null) return;

    await _mapController?.toggleUserLayer(
      visible: true,
      autoZoomEnabled: false,
    );

    await _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: _userPosition!.latitude,
            longitude: _userPosition!.longitude,
          ),
          zoom: 14.5,
        ),
      ),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1.0),
    );
  }

  Future<void> _moveToSalon(MapSalon salon) async {
    setState(() {
      _selectedSalon = salon;
    });

    if (_mapController != null) {
      await _mapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: salon.point,
            zoom: 15.0,
          ),
        ),
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 0.8),
      );
    }
  }

  Future<void> _changeZoom(double delta) async {
    if (_mapController == null) return;
    _currentZoom = (_currentZoom + delta).clamp(3.0, 19.0);
    await _mapController?.moveCamera(
      CameraUpdate.zoomTo(_currentZoom),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 0.3),
    );
  }

  List<MapObject> _getMapObjects() {
    List<MapObject> mapObjects = [];

    for (var salon in _filteredSalons) {
      final isSelected = _selectedSalon?.id == salon.id;

      mapObjects.add(
        PlacemarkMapObject(
          mapId: MapObjectId('salon_${salon.id}'),
          point: salon.point,
          opacity: 1.0,
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/images/img_19.png'),
              scale: isSelected ? 1.3 : 0.85,
            ),
          ),
          onTap: (PlacemarkMapObject self, Point point) {
            _moveToSalon(salon);
          },
        ),
      );
    }

    return mapObjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (YandexMapController controller) async {
              _mapController = controller;
              if (_userPosition != null) {
                await _moveToUserPosition();
              } else {
                await controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    const CameraPosition(
                      target: _defaultCenter,
                      zoom: 13.0,
                    ),
                  ),
                );
              }
            },
            onCameraPositionChanged: (CameraPosition position, CameraUpdateReason reason, bool finished) {
              if (finished) {
                _currentZoom = position.zoom;
              }
            },
            mapObjects: _getMapObjects(),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: context.theme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 14.w),
                        Image.asset(
                          'assets/images/img_19.png',
                          width: 22.w,
                          height: 22.h,
                          color: const Color(0xffFA9400),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            onChanged: _applySearchFilter,
                            decoration: InputDecoration(
                              hintText: "Salon yoki manzil qidirish...",
                              hintStyle: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey.shade500,
                              ),
                              border: InputBorder.none,
                              fillColor: Colors.transparent,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear, size: 20, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              _applySearchFilter('');
                            },
                          ),
                        IconButton(
                          icon: const Icon(Icons.format_list_bulleted, color: Color(0xffFA9400)),
                          onPressed: () => _showNearbySalonsBottomSheet(context),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: _checkLocationPermissionAndFetch,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(20),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isLoadingLocation)
                              SizedBox(
                                width: 14.w,
                                height: 14.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFA9400)),
                                ),
                              )
                            else
                              Icon(
                                _hasLocationPermission
                                    ? Icons.my_location
                                    : Icons.location_off,
                                size: 16.sp,
                                color: _hasLocationPermission
                                    ? const Color(0xffFA9400)
                                    : Colors.redAccent,
                              ),
                            SizedBox(width: 6.w),
                            Text(
                              _statusMessage ?? "Joylashuv xizmati",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 16.w,
            top: 150.h,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: "btn_my_location",
                  backgroundColor: Colors.white,
                  elevation: 4,
                  onPressed: () {
                    if (_userPosition != null) {
                      _moveToUserPosition();
                    } else {
                      _checkLocationPermissionAndFetch();
                    }
                  },
                  child: Icon(
                    Icons.my_location,
                    color: _userPosition != null ? const Color(0xffFA9400) : Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h),
                FloatingActionButton.small(
                  heroTag: "btn_zoom_in",
                  backgroundColor: Colors.white,
                  elevation: 4,
                  onPressed: () => _changeZoom(1.0),
                  child: const Icon(Icons.add, color: Colors.black87),
                ),
                SizedBox(height: 8.h),
                FloatingActionButton.small(
                  heroTag: "btn_zoom_out",
                  backgroundColor: Colors.white,
                  elevation: 4,
                  onPressed: () => _changeZoom(-1.0),
                  child: const Icon(Icons.remove, color: Colors.black87),
                ),
              ],
            ),
          ),

          if (_selectedSalon != null)
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 120.h,
              child: _buildSalonCard(_selectedSalon!),
            ),
        ],
      ),
    );
  }

  Widget _buildSalonCard(MapSalon salon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.theme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(35),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.asset(
                  salon.image,
                  width: 75.w,
                  height: 75.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 75.w,
                      height: 75.h,
                      color: Colors.grey.shade200,
                      child: Icon(Icons.store, size: 30.sp, color: Colors.grey),
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            salon.name,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: context.theme.surface,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, size: 14.sp, color: Colors.amber),
                              SizedBox(width: 3.w),
                              Text(
                                salon.rating.toString(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      salon.address,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.near_me,
                          size: 14.sp,
                          color: const Color(0xffFA9400),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          salon.formattedDistance,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffFA9400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _moveToSalon(salon),
                  icon: Icon(Icons.directions, size: 16.sp, color: const Color(0xffFA9400)),
                  label: Text(
                    "Xaritada ko'rish",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFA9400),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xffFA9400)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${salon.name} tanlandi"),
                        backgroundColor: const Color(0xffFA9400),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.calendar_month, size: 16.sp, color: Colors.white),
                  label: Text(
                    "Bron qilish",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFA9400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showNearbySalonsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            color: context.theme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Yaqin atrofdagi salonlar (${_filteredSalons.length})",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: _filteredSalons.isEmpty
                    ? Center(
                        child: Text(
                          "Salonlar topilmadi",
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        itemCount: _filteredSalons.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final salon = _filteredSalons[index];
                          final isSelected = _selectedSalon?.id == salon.id;

                          return InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              _moveToSalon(salon);
                            },
                            child: GlassContainer(
                              padding: EdgeInsets.all(10.w),
                                borderRadius: BorderRadius.circular(14.r),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.asset(
                                      salon.image,
                                      width: 55.w,
                                      height: 55.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 55.w,
                                        height: 55.h,
                                        color: Colors.grey.shade300,
                                        child: const Icon(Icons.store),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          salon.name,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          salon.address,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey.shade600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          salon.formattedDistance,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xffFA9400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star, size: 14.sp, color: Colors.amber),
                                          SizedBox(width: 2.w),
                                          Text(
                                            salon.rating.toString(),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
