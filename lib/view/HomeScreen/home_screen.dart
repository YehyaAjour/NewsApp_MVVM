import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/services/DioHelper/dio_helper.dart';
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
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: backgroundGradiant),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
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
                                  child: _MySearchTextField(
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
              ),
            ),
          ],
        );
      },
    );
  }
}

class NewsItemWidget extends StatelessWidget {
  final dynamic article;
  final titleStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0);
  final VoidCallback onSwipe;

  const NewsItemWidget({Key key, this.article, this.onSwipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        print(details.primaryDelta);
        if (details.primaryDelta < -7) {
          onSwipe();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: NewsWidget(
                article: article,
              ),
            ),
            const Spacer(),
            Expanded(
                flex: 5,
                child: ReviewNewsWidget(
                  article: article,
                ))
          ],
        ),
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  final dynamic article;
  final titleStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);

  const NewsWidget({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'news_${article['urlToImage']}',
      child: Card(
        elevation: 10,
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.network(
              '${article['urlToImage']}',
              fit: BoxFit.cover,
            )),
          ],
        ),
      ),
    );
  }
}

class ReviewNewsWidget extends StatelessWidget {
  final dynamic article;
  final titleStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 11.0);

  ReviewNewsWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'news_${article['title']}',
      child: Card(
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xff4b6089),
                      child: Center(
                        child: Text(
                          '${article['source']['name']}',
                          textAlign: TextAlign.center,
                          style: titleStyle,
                          // textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${article['title']}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('${article['publishedAt']}',
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${article['description']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  // textDirection: TextDirection.rtl,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Image.network(
                    '${article['urlToImage']}',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class _MySearchTextField extends AnimatedWidget {
  _MySearchTextField(Animation<double> animation)
      : super(listenable: animation);

  Animation<double> get animation => listenable;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final value = 1 - animation.value;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: size.width * value,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xff8E9BB5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: value>0.4?Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey[800],
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Text(
                'البحث ',
                style: TextStyle(color: Colors.grey[800]),
              )),
            ],
          ),
        ):const SizedBox.shrink(),
      ),
    );
  }
}
