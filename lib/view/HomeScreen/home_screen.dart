import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/view/CustomWidget/custom_widget.dart';
import 'package:newsapp/view/MultibleCardFlow/multiple_card_flow.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';
import 'package:newsapp/view_model/AppStates/app_states.dart';
import 'package:vector_math/vector_math_64.dart' as vector;


const backgroundGradiant = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff4b6089),
      Color(0xffA0D7B4),
    ]);

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController(viewportFraction: 0.9);
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
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
       AppCubit cubit=AppCubit.get(context);
       List<dynamic>homeNews=[
         cubit.generalList[0]
       ];

        return Stack(
          children: [

             const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Scaffold(


                // bottomNavigationBar: CurvedNavigationBar(
                //   height: 30,
                //   animationDuration: Duration(milliseconds: 500),
                //   items: AppCubit.get(context).bottomItem,
                //   onTap: (value) {
                //     AppCubit.get(context).changeIndexBottomNav(value);
                //   },
                //   index: AppCubit.get(context).currentIndex,
                //
                // ),
                // bottomNavigationBar: BottomNavigationBar(
                //   type: BottomNavigationBarType.fixed,
                //   onTap: (value) {
                //     AppCubit.get(context).changeIndexBottomNav(value);
                //   },
                //   currentIndex: AppCubit.get(context).currentIndex,
                //   items: AppCubit.get(context).bottomItem,
                // ),
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Expanded(
                        child: ConditionalBuilder(
                          condition: state is! GetBusinessNewsErrorState &&
                              state is! GetBusinessNewsLoadingState ,
                          builder: (context) {
                            return PageView.builder(

                              controller: _pageController,
                              itemCount:
                              homeNews.length,
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
                                        article: homeNews[index],
                                        onSwipe: () {
                                          _onSwipe(homeNews[index]);
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
                )),
          ],
        );
      },
    );
  }
}
