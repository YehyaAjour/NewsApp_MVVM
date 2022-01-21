import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/view/CustomWidget/custom_widget.dart';
import 'package:newsapp/view/MultibleCardFlow/multiple_card_flow.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';
import 'package:newsapp/view_model/AppStates/app_states.dart';
import 'package:vector_math/vector_math_64.dart' as vector;




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
         cubit.generalList[0],
         cubit.businessList[0],
         cubit.entertainmentList[0],
         cubit.healthList[0],
         cubit.scienceList[0],
         cubit.sportsList[0],
         cubit.technologyList[0],
       ];
       List<Color> _listColor = [
         Color(0xfffff2be),
         Color(0xff93beb7),
         Color(0xfff9e7f3),
         Color(0xff84dcff),
         Color(0xfff3f3f3),
         Color(0xfffff2be),
         Color(0xff93beb7),


       ];
       List<String> _categoryList = [
         'عام',
         'أعمال',
         'ترفيه',
         'صحة',
         'علوم',
         'رياضة',
         'تكنولوجيا',

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
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Expanded(
                        child: ConditionalBuilder(
                          condition: state is! GetGeneralNewsLoadingState&& state is! GetBusinessNewsLoadingState
                      && state is! GetEntertainmentNewsLoadingState && state is! GetHealthNewsLoadingState &&
                  state is! GetScienceNewsLoadingState && state is! GetSportNewsLoadingState && state is! GetTechnologyNewsLoadingState,
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
                                        listColor: _listColor[index],
                                        listCategory:_categoryList[index],
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
