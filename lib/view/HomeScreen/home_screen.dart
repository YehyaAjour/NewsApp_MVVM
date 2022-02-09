import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapp/view/HomeScreen/Main/main_screen.dart';
import 'package:newsapp/view/MultibleCardFlow/multiple_card_flow.dart';
import 'package:newsapp/view/favourite/favourite_screen.dart';
import 'package:newsapp/view/search/search_appBar.dart';
import 'package:newsapp/view/search/search_screen.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';
import 'package:newsapp/view_model/AppStates/app_states.dart';

import 'Main/main_appBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            DefaultTabController(
              length: 6,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: cubit.bottomNavCurrentIndex==0?MainAppBar(context):cubit.bottomNavCurrentIndex==1? SearchAppBar(context):AppBar(),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: cubit.bottomNavCurrentIndex,
                    onTap: (index){
                      cubit.changeBottomNavCurrentIndex(index);},
                    items: cubit.bottomItem,
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    selectedItemColor: Color(0xff00266f),
                  ),
                  body: cubit.bottomNavScreens[cubit.bottomNavCurrentIndex],
              ),
            ),
          ],
        );
      },
    );
  }
}
