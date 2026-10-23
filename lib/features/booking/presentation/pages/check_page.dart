import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trim_app/features/home/presentation/widgets/navigation_page.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/booking/presentation/pages/show_check_page.dart';

import 'package:trim_app/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:trim_app/features/booking/presentation/bloc/booking_event.dart';
import 'package:trim_app/features/booking/presentation/bloc/booking_state.dart';
import 'package:trim_app/features/salon/data/models/subscription_model.dart';
import 'package:trim_app/features/booking/data/repositories/booking_repository.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

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
  final String paymentMethod;

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
          child: GlassContainer(
            width: 340.w,
            height: 531.h,
            borderRadius: BorderRadius.circular(48.r),
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
                    color: context.theme.textPrimary,
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
          backgroundColor: context.theme.background,
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
                        color: context.theme.textPrimary,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    Text(
                      'Корзина',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: context.theme.textPrimary,
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
                    color: context.theme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: context.theme.glassShadow,
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
                GlassContainer(
                  width: 380.w,
                  height: 72.h,
                  borderRadius: BorderRadius.circular(16.r),
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
                            color: context.theme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 233.h),

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
              color: context.theme.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.theme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
