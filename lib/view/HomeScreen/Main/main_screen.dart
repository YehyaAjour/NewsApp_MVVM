import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/view/CustomWidget/custom_text.dart';
import 'package:newsapp/view/CustomWidget/custom_widget.dart';
import 'package:newsapp/view/MultibleCardFlow/multiple_card_flow.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController(
    viewportFraction: 0.8,
  );
  AnimationController _animationController;
  double page = 0.0;
  int _currentPage = 0;

  Timer _timer;

  void _listenScroll() {
    setState(() {
      page = _pageController.page;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_listenScroll);
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 1500));
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    super.dispose();
    _timer?.cancel();
  }

  void _onSwipe(article) async {
    _animationController.forward();
    await Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1200),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
              opacity: animation,
              child: MultipleCardFlowScreen(
                article: article,
              ));
        }));
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10,),
            ConditionalBuilder(
              condition: AppCubit.get(context).generalList.length > 0,
              builder: (context) {
                return Container(
                  height: 240,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: AppCubit.get(context).generalList.length,
                    itemBuilder: (context, index) {
                      _currentPage = index;
                      final percent =
                      (page - index).abs().clamp(0.0, 1.0);
                      final factor = _pageController
                          .position.userScrollDirection ==
                          ScrollDirection.forward
                          ? 1.0
                          : -1.0;
                      final opacity = percent.clamp(0.0, 0.7);
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(vector
                              .radians(45 * factor * percent)),
                        child: Opacity(
                          opacity: (1 - opacity),
                          child: NewsItemWidget(
                              article: AppCubit.get(context).generalList[index],
                              onSwipe: () {
                                _onSwipe(
                                    AppCubit.get(context).generalList[index]);
                              }),
                        ),
                      );
                    },
                  ),
                );
              },
              fallback: (context) =>
              const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'آخر الأخبار',
                    fontSize: 25,
                    fontFamily: 'din',
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  AppCubit.get(context).listScreen[AppCubit.get(context).tapBarCurrentIndex],

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
