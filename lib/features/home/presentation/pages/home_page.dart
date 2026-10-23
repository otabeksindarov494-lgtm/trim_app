import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/core/router/app_router.dart';

class IntroModel {
  final String image;

  IntroModel({required this.image});
}

List<IntroModel> introList = [
  IntroModel(image: "assets/images/img.png"),
  IntroModel(image: "assets/images/img_1.png"),
  IntroModel(image: "assets/images/img_2.png"),
  IntroModel(image: "assets/images/img_3.png"),
];

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.listImage = const []});

  final List<ListImage> listImage;

  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: introList.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });

          if (index == introList.length - 1) {
            Future.delayed(const Duration(seconds: 1), () {
              if (!mounted) return;
              AutoRouter.of(
                context,
              ).push(SignInRoute(listImage: widget.listImage));
            });
          }
        },
        itemBuilder: (context, index) {
          final item = introList[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(item.image, fit: BoxFit.cover),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(.7)],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
