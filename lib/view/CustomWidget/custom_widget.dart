import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/view/CustomWidget/custom_text.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        child: Column(
          children: [

            Container(
              height: 190,

              child: NewsWidget(
                article: article,
              ),
            ),

            // const SizedBox(
            //   height: 30,
            // ),
            // Expanded(
            //     flex: 5,
            //     child: ReviewNewsWidget(
            //       article: article,
            //     ),
            // ),
          ],
        ),
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  final Color listColor;
  final dynamic article;
  final titleStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);

  NewsWidget({Key key, @required this.article, @required this.listColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 20,
      child: Stack(
        children: [
          Positioned.fill(
            child: ConditionalBuilder(
              condition: article['urlToImage']!=null,
              builder:(context) {
                return  Image(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider('${article['urlToImage']}')
                );
              } ,
              fallback: (context) {
                  return Shimmer(
                    child: Container(
                      color: Colors.grey[500],
                    ),
                  );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomText( '${article['publishedAt']}',color: Colors.white,fontFamily: 'din',fontSize: 13,),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      width: 250,
                      height: 70,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText('${article['title']}',color: Colors.white,fontFamily: 'din',fontSize: 18,maxLines: 2,),
                      ),


                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewNewsWidget extends StatelessWidget {
  final dynamic article;
  final titleStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 8.0);

  ReviewNewsWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'news_${article['title']}',
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
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
                  child: Image(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          '${article['urlToImage']}')),
                ),
              ],
            ),
          )),
    );
  }
}

class MySearchTextField extends AnimatedWidget {
  MySearchTextField(Animation<double> animation) : super(listenable: animation);

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
        child: value > 0.4
            ? Padding(
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
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
