import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/navigation_page.dart';
import '../bloc/provider/profile_bloc.dart';
import '../bloc/provider/profile_event.dart';
import '../bloc/provider/profile_state.dart';
import '../profile/action_page.dart';
class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({
    super.key,
    required this.profileId,
    required this.email, required this.listImage,
  });
  final List<ListImage> listImage;
  final String profileId;
  final String email;

  @override
  State<CreateProfilePage> createState() =>
      _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final nameController = TextEditingController();
  final nickNameController = TextEditingController();
  final birthController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String? gender;

  @override
  void initState() {
    super.initState();

    emailController.text = widget.email;
  }

  void saveProfile() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите имя'),
        ),
      );
      return;
    }
    print('saveProfile chaqirildi');
    context.read<ProfileBloc>().add(
      UpdateProfile(
        profileId: widget.profileId,
        name: nameController.text,
        nickName: nickNameController.text,
        birthday: birthController.text,
        email: emailController.text,
        phone: phoneController.text,
        gender: gender,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        print('STATE: $state');
        if (state is ProfileLoaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>  NavigationPage(listImage: widget.listImage),
            ),
          );
        }

        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 20.h,
              bottom: 30.h,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BACK + TITLE

                Row(
                  children: [
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

                    SizedBox(width: 16.w),

                    Text(
                      'Заполнить профиль',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'bold'
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 39.h),

                _textField(
                  controller: nameController,
                  hint: 'Ваше имя',
                ),

                SizedBox(height: 24.h),

                _textField(
                  controller: nickNameController,
                  hint: 'Ваша фамилия',
                ),

                SizedBox(height: 24.h),


                _textField(
                  controller: birthController,
                  hint: 'Дата рождения',
                ),

                SizedBox(height: 24.h),

                _textField(
                  controller: emailController,
                  hint: 'Введите почту',
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 24.h),

                _textField(
                  controller: phoneController,
                  hint: '+998',
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 24.h),

                GestureDetector(
                  onTap: () {
                    _showGenderBottomSheet();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xffFAFAFA),
                      border: Border.all(
                        color: const Color(0xffEEEEEE),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      gender ?? 'Ваш пол',
                      style: TextStyle(
                        fontSize: 14,
                        color: gender == null
                            ? const Color(0xff677294)
                            : Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // SAVE BUTTON

                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    final loading =
                    state is ProfileUpdating;

                    return GestureDetector(
                      onTap: loading ? null : saveProfile,
                      child: Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(100),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffFFAB38),
                              Color(0xffFB9400),
                            ],
                          ),
                        ),
                        child: Center(
                          child: loading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            'Сохранить',
                            style: TextStyle(
                              fontSize: 16,
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

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Container(
      width: double.infinity,
      height: 60.h,
      padding: EdgeInsets.only(left: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Color(0xffFAFAFA),
        border: Border.all(
          color: Color(0xffEEEEEE),
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: Color(0xff677294),
            ),
          ),
        ),
      ),
    );
  }

  void _showGenderBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              ListTile(
                title: Text('Мужской', style: TextStyle(fontSize: 16),),
                onTap: () {
                  setState(() {
                    gender = 'Мужской';
                  });

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Женский', style: TextStyle(fontSize: 16),),
                onTap: () {
                  setState(() {
                    gender = 'Женский';
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
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