import 'package:flutter/material.dart';
import 'package:newsapp/view/CustomWidget/custom_image.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';


Widget MainAppBar(context){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    toolbarHeight: 90,
    centerTitle: true,
    title: Row(
      children: [
        CustomSvgImage(imageName:'logo',width: 100,height: 40,),
      ],
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          color: Colors.transparent),
    ),
    bottom: TabBar(
      padding: EdgeInsets.all(5),
      physics: BouncingScrollPhysics(),
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: true,
      onTap: (index) {AppCubit.get(context).changeIndexTapBar(index);},
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Color(0xff00266f),
      labelStyle: TextStyle(fontSize: 17,fontFamily: 'din'),
      tabs: const [
        Tab(
          child: Text('أعمال'),
        ),
        Tab(
          child: Text('ترفيه'),
        ),
        Tab(
          child: Text('صحة'),
        ),
        Tab(
          child: Text('علوم'),
        ),
        Tab(
          child: Text('رياضة'),
        ),
        Tab(
          child: Text('تكنولوجيا'),
        ),

      ],
    ),
  );
}
