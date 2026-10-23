import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trim_app/core/router/app_router.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      AutoRouter.of(context).replace(HomeRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF79E1B),
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'T',
              style: TextStyle(
                fontSize: 140.sp,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                fontFamily: 'serif',
              ),
            ),
            Positioned(
              bottom: 80.h,
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
