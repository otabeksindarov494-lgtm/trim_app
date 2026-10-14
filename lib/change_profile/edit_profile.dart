import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trim_app/bloc/provider/profile_bloc.dart';
import 'package:trim_app/bloc/provider/profile_state.dart';
import 'package:trim_app/l10n/app_localizations.dart';

import '../bloc/provider/profile_event.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final birthController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String? profileId;
  String? selectedGender;

  Future<String> getOrCreateProfileId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Foydalanuvchi tizimga kirmagan');
    }
    return user.uid;
  }

  Future<void> saveProfile() async {
    if (profileId == null) return;

    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.tr('your_name'))));
      return;
    }

    context.read<ProfileBloc>().add(
      UpdateProfile(
        profileId: profileId!,
        name: nameController.text.trim(),
        nickName: nickNameController.text.trim(),
        birthday: birthController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        gender: selectedGender,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          nameController.text = state.profile.name;
          nickNameController.text = state.profile.nickName;
          birthController.text = state.profile.birthday;
          emailController.text = state.profile.email;
          phoneController.text = state.profile.phone;
          selectedGender = state.profile.gender;
        }

        if (state is ProfileUpdateSuccess) {
          Navigator.pop(context);
        }

        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: 84.h),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 28.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/img_5.png',
                      width: 28.w,
                      height: 28.h,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    context.tr('change_profile'),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Container(
                width: 380.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xffFAFAFA),
                  border: Border.all(color: const Color(0xffEEEEEE)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 3.h),
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: context.tr('your_name'),
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff677294),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: 380.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xffFAFAFA),
                  border: Border.all(color: const Color(0xffEEEEEE)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 3.h),
                  child: TextField(
                    controller: nickNameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: context.tr('your_surname'),
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff677294),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: 380.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xffFAFAFA),
                  border: Border.all(color: const Color(0xffEEEEEE)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 0.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000, 1, 1),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              birthController.text =
                                  '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                            }
                          },
                          child: TextField(
                            controller: birthController,
                            readOnly: true,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('birth_date'),
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff677294),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.r),
                        child: Image.asset(
                          'assets/images/img_86.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: 380.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xffFAFAFA),
                  border: Border.all(color: const Color(0xffEEEEEE)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 3.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final result = await showModalBottomSheet<String>(
                              context: context,
                              builder: (_) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text(context.tr('male')),
                                    onTap: () => Navigator.pop(context, 'male'),
                                  ),
                                  ListTile(
                                    title: Text(context.tr('female')),
                                    onTap: () => Navigator.pop(context, 'female'),
                                  ),
                                ],
                              ),
                            );
                            if (result != null) {
                              setState(() => selectedGender = result);
                            }
                          },
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: context.tr('gender'),
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff677294),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Image.asset(
                          'assets/images/img_87.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: 380.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xffFAFAFA),
                  border: Border.all(color: const Color(0xffEEEEEE)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 0.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: context.tr('enter_email'),
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff677294),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Image.asset(
                          'assets/images/img_88.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: 380.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xffFAFAFA),
                  border: Border.all(color: const Color(0xffEEEEEE)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 3.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: context.tr('phone_number'),
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff677294),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Image.asset(
                          'assets/images/img_89.png',
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 230.h),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  final isLoading = state is ProfileLoading;

                  return GestureDetector(
                    onTap: isLoading ? null : saveProfile,
                    child: Container(
                      width: 358.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        gradient: const LinearGradient(
                          colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                        ),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                context.tr('save'),
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
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    nickNameController.dispose();
    birthController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
