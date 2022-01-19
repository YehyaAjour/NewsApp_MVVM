import 'package:flutter/material.dart';
import 'package:newsapp/view/CustomWidget/custom_widget.dart';
import 'package:newsapp/view/HomeScreen/home_screen.dart';

class MultipleCardFlowScreen extends StatelessWidget {
  final dynamic article;



  const MultipleCardFlowScreen({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: backgroundGradiant),
            ),
          ),
          Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: NewsWidget(article: article,),
                ),
                Expanded(
                  flex: 5,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height*0.4,
                      child: ReviewNewsWidget(article: article,),
                    )


                )
              ],
            ),
          ),
          Positioned(
            right: 20 ,
            top: 40,
            child: BackButton(color: Colors.white,),
          )
        ],
      ),
    );
  }
}
