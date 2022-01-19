import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/view/CustomWidget/custom_widget.dart';
import 'package:newsapp/view/MultibleCardFlow/multiple_card_flow.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';

import 'package:newsapp/view_model/AppStates/app_states.dart';
import 'package:vector_math/vector_math_64.dart' as vector;


class BusinesScreen extends StatefulWidget {

  @override
  _BusinesScreenState createState() => _BusinesScreenState();
}

class _BusinesScreenState extends State<BusinesScreen> with SingleTickerProviderStateMixin{
  final _pageController = PageController(viewportFraction: 0.8);
  AnimationController _animationController;
  double page = 0.0;

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
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    super.dispose();
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
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MySearchTextField(
                                _animationController))),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.brightness_4_sharp,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: state is! GetBusinessNewsErrorState &&
                      state is! GetBusinessNewsLoadingState,
                  builder: (context) {
                    return PageView.builder(
                      controller: _pageController,
                      itemCount:
                      AppCubit.get(context).businessList.length,
                      itemBuilder: (context, index) {
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
                            ..rotateY(
                                vector.radians(45 * factor * percent)),
                          child: Opacity(
                            opacity: (1 - opacity),
                            child: NewsItemWidget(
                                article: AppCubit.get(context)
                                    .businessList[index],
                                onSwipe: () {
                                  _onSwipe(AppCubit.get(context)
                                      .businessList[index]);
                                }),
                          ),
                        );
                      },
                    );
                  },
                  fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
