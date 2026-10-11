import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:trim_app/profile/action_page.dart';
import 'package:trim_app/registration_page.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.listImage});
  final  List <ListImage> listImage;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 294),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/img_4.png', width: 192, height: 169),
              SizedBox(height: 217),
              Container(
                width: 358,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                  ),
                ),
                child: Center(
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
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage(listImage: widget.listImage,)),
                  );
                },
                child: Container(
                  width: 358,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xffFAFAFA),
                    border: Border.all(color: Color(0xffEEEEEE)),
                  ),
                  child: Center(
                    child: Text(
                      'Регистрация',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'regular',
                        color: Color(0xff677294),
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
