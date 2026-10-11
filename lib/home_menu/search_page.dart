import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:trim_app/bloc/salon_bloc/salon_state.dart';

import '../bloc/salon_bloc/salon_bloc.dart';
import '../bloc/salon_bloc/salon_event.dart';

class Subscriptions {
  final String image;
  final String title;
  final String podcastCount;
  bool isEnabled;

  Subscriptions({
    required this.image,
    required this.title,
    required this.podcastCount,
    this.isEnabled = false,
  });
}

final List<Subscriptions> subscriptions = [
  Subscriptions(
    image: "assets/images/img_23.png",
    title: 'Uncle Chill',
    podcastCount: 'ТЦ Зарафшан, Матбуотчилар, 17',
  ),
  Subscriptions(
    image: "assets/images/img_27.png",
    title: 'Genesis',
    podcastCount: 'Массив Буюк Ипак Йули, 45а',
  ),
  Subscriptions(
    image: "assets/images/img_28.png",
    title: 'Santander',
    podcastCount: 'Улица Фурката, 2а',
  ),
];

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool hasText = false;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  final List<String> recentSearches = [
    'Beauty Unleashed',
    'Addictive Beauty',
    'Metamorphisis salon',
    'Big Hare We Care',
    'Fade Factory',
    'Genesis',
    'Santander',
    'Uncle Chill',
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  double dragOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            setState(() {
              dragOffset += details.delta.dy;

              if (dragOffset > MediaQuery.of(context).size.height) {
                dragOffset = MediaQuery.of(context).size.height;
              }
            });
          }
        },
        onVerticalDragEnd: (details) {
          if (dragOffset > 150 || (details.primaryVelocity ?? 0) > 700) {
            Navigator.pop(context);
          } else {
            setState(() {
              dragOffset = 0;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(top: 68.h),
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),

                Container(
                  width: 380.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: hasText ? Color(0xffFFAB38) : Colors.transparent,
                    ),
                    color: hasText
                        ? Color(0xffFFAB38).withOpacity(0.1)
                        : Color(0xffF5F5F5),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocus,
                        onChanged: (value) {
                          setState(() {
                            hasText = value.isNotEmpty;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 12.h),
                          border: InputBorder.none,
                          hintText: 'Поиск',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffBDBDBD),
                          ),
                          icon: Image.asset(
                            'assets/images/img_36.png',
                            width: 17.w,
                            height: 18.h,
                            color: hasText
                                ? Color(0xffFFAB38)
                                : Color(0xffBDBDBD),
                          ),
                          suffixIcon: Image.asset(
                            'assets/images/img_37.png',
                            width: 14.w,
                            height: 14.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                if (searchController.text.isEmpty)
                  _recentSearches()
                else
                  _searchResults(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _recentSearches() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Недавние поиски',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    recentSearches.clear();
                  });
                },
                child: Text(
                  'Очистить',
                  style: TextStyle(
                    color: Color(0xffFD9301),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 46.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        recentSearches[index],
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xff777777),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            recentSearches.removeAt(index);
                          });
                        },
                        child: Container(
                          width: 22.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchResults() {
    return Expanded(
      child: BlocBuilder<SalonBloc, SalonState>(
        builder: (context, state) {
          if (state is SalonLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SalonError) {
            return Center(child: Text(state.message));
          }

          if (state is SalonLoaded) {
            if (subscriptions.isEmpty) {
              return const Center(child: Text('Ничего не найдено'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Результаты "${searchController.text}"',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${subscriptions.length} Найдено',
                      style: TextStyle(
                        color: Color(0xffFD9301),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: subscriptions.length,
                    itemBuilder: (context, index) {
                      final salon = subscriptions[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffEEEEEE),
                              blurRadius: 24.r,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 12.w),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.network(
                                salon.image,
                                width: 70.w,
                                height: 70.h,
                                fit: BoxFit.cover,
                              ),
                            ),

                            SizedBox(width: 14.w),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        salon.title,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 16.w,
                                        ),
                                        child: Image.asset(
                                          'assets/images/img_26.png',
                                          width: 22.w,
                                          height: 22.h,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5.h),

                                  Text(
                                    salon.podcastCount,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  SizedBox(height: 5.h),

                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/img_24.png',
                                        width: 15.w,
                                        height: 15.h,
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        '4.3 km',
                                        style: TextStyle(fontSize: 12.sp),
                                      ),

                                      SizedBox(width: 12.w),

                                      Image.asset(
                                        'assets/images/img_25.png',
                                        width: 15.w,
                                        height: 15.h,
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        '4.9',
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

