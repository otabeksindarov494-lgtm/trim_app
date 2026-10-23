import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/auth/presentation/pages/registration_page.dart';
import 'package:trim_app/theme/app_theme.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.listImage});
  final List<ListImage> listImage;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 294),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/img_4.png', width: 192, height: 169),
              const SizedBox(height: 217),
              Container(
                width: 358,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Войти',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'regular',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage(listImage: widget.listImage)),
                  );
                },
                child: Container(
                  width: 358,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: context.theme.inputBackground,
                    border: Border.all(color: context.theme.border),
                  ),
                  child: Center(
                    child: Text(
                      'Регистрация',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'regular',
                        color: context.theme.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
