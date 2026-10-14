import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trim_app/home_menu/home_menu.dart';
import 'package:trim_app/home_menu/navigation_page.dart';
import 'package:trim_app/profile/action_page.dart';
import 'package:trim_app/profile/show_check_page.dart';

import '../bloc/booking_bloc/booking_bloc.dart';
import '../bloc/booking_bloc/booking_event.dart';
import '../bloc/booking_bloc/booking_state.dart';
import '../bloc/model/subscription_model.dart';
import '../bloc/provider/repository/booking_repository.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({
    super.key,
    required this.check,
    required this.listImage,
    required this.bookingDate,
    required this.bookingTime,
    required this.masterId,
    required this.masterName,
    required this.paymentMethod,
  });

  final List<ListImage> listImage;
  final Subscriptions check;
  final DateTime bookingDate;
  final String bookingTime;
  final String masterId;
  final String masterName;
  final String paymentMethod; // 'cash' yoki 'card'

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  String userName = '';
  String userPhone = '';
  bool isLoadingProfile = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userId)
          .get();

      if (doc.exists && doc.data() != null) {
        final response = doc.data()!;
        setState(() {
          userName = response['name'] ?? '';
          userPhone = response['phone'] ?? '';
          isLoadingProfile = false;
        });
      } else {
        setState(() => isLoadingProfile = false);
      }
    } catch (e) {
      setState(() => isLoadingProfile = false);
    }
  }

  String get formattedDate {
    const months = [
      'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
      'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь',
    ];
    return '${widget.bookingDate.day} ${months[widget.bookingDate.month - 1]} ${widget.bookingDate.year}';
  }

  void _onBookPressed(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foydalanuvchi topilmadi')),
      );
      return;
    }

    context.read<BookingBloc>().add(
      BookingSubmitted(
        salonId: widget.check.id,
        masterId: widget.masterId,
        bookingDate: widget.bookingDate,
        bookingTime: widget.bookingTime,
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 340.w,
            height: 531.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(48.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 40.h),
                Image.asset(
                  'assets/images/img_8.png',
                  width: 185.w,
                  height: 180.h,
                ),
                SizedBox(height: 25.h),
                Text(
                  "Забронировано!",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffFEA328),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  "Ваше бронирование успешно \nвыполнено",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    height: 1.5.h,
                  ),
                ),
                SizedBox(height: 33.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowCheckPage(
                          showCheck: widget.check,
                          listImage: widget.listImage,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 276.w,
                    height: 58.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      gradient: const LinearGradient(
                        colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Посмотреть чек',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NavigationPage(listImage: widget.listImage),
                      ),
                    );
                  },
                  child: Container(
                    width: 276.w,
                    height: 58.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xffFFAB38).withOpacity(0.1),
                          const Color(0xffFB9400).withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'На главную',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffFD9301),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(repository: BookingRepository()),
      child: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            _showSuccessDialog(context);
          } else if (state is BookingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(top: 77.h),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 24.w),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/images/img_5.png',
                        width: 28.w,
                        height: 28.h,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    Text(
                      'Корзина',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 33.h),
                Container(
                  width: 380.w,
                  height: 344.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffE9E9E9),
                        blurRadius: 24.r,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: isLoadingProfile
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                    children: [
                      _infoRow('Барбер/Салон', widget.check.title),
                      _infoRow('Адресс', widget.check.podcastCount),
                      _infoRow(
                          'Имя', userName.isEmpty ? '—' : userName),
                      _infoRow(
                          'Номер', userPhone.isEmpty ? '—' : userPhone),
                      _infoRow('Дата заказа', formattedDate),
                      _infoRow('Время заказа', widget.bookingTime),
                      _infoRow('Исполнитель', widget.masterName),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: 380.w,
                  height: 72.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffE9E9E9),
                        blurRadius: 24.r,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 24.w),
                        Image.asset(
                          'assets/images/img_76.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          widget.paymentMethod == 'card'
                              ? 'Оплата картой'
                              : 'Оплата наличными',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 233.h),

                // === Bron tugmasi — endi Bloc bilan ishlaydi ===
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    final isLoading = state is BookingLoading;

                    return GestureDetector(
                      onTap: isLoading ? null : () => _onBookPressed(context),
                      child: Container(
                        width: 380.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                          ),
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            'Забронировать',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff616161),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
