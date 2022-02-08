import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/services/DioHelper/dio_helper.dart';
import 'package:newsapp/view/category/business/business_screen.dart';
import 'package:newsapp/view/category/entertainment/entertainment_screen.dart';
import 'package:newsapp/view/category/general/general_screen.dart';
import 'package:newsapp/view/category/health/health_screen.dart';
import 'package:newsapp/view/category/science/science_screen.dart';
import 'package:newsapp/view/category/sports/sports_screen.dart';
import 'package:newsapp/view/category/technology/technology_screen.dart';
import 'package:newsapp/view_model/AppStates/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int tapBarCurrentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_sharp),
      label: 'الرئيسية',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'أعمال',
    ),const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'ترفيه',
    ),const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'صحة',
    ),const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'علوم',
    ),const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'رياضة',
    ),const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'تكنولوجيا',
    ),

  ];

  List<Widget> listScreen=[
    BusinesScreen(),
    EntertainmentScreen(),
    HealthScreen(),
    ScienceScreen(),
    SportScreen(),
    TechnologyScreen()
  ];


  void changeIndexTapBar(int index) {
    tapBarCurrentIndex = index;
    emit(ChangeBottomNavState());
  }

  List<dynamic> generalList = [];
  List<dynamic> businessList = [];
  List<dynamic> entertainmentList = [];
  List<dynamic> healthList = [];
  List<dynamic> scienceList = [];
  List<dynamic> sportsList = [];
  List<dynamic> technologyList = [];
  List<dynamic>homeScreenNews=[];




  void getGeneral() {
    emit(GetGeneralNewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines/', queries: {
      'category': 'general',
      'language': 'ar',
      'apiKey': 'fea6b665b7e94b77afd2dada4cb7e983'
    }).then((value) {
      print(value.data);
      generalList = value.data['articles'];
      homeScreenNews.add(value.data['articles'][0]);
      emit(GetGeneralNewsSuccessfulState());
    }).catchError((error) {
      emit(GetGeneralNewsErrorState(error.toString()));
      print(error.toString());
    });
  }

  void getBusinessNew() {
    emit(GetBusinessNewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines/', queries: {
      'category': 'business',
      'language': 'ar',
      'apiKey': 'fea6b665b7e94b77afd2dada4cb7e983'
    }).then((value) {
      print(value.data);
      businessList = value.data['articles'];
      homeScreenNews.add(value.data['articles'][0]);

      emit(GetBusinessNewsSuccessfulState());
    }).catchError((error) {
      emit(GetBusinessNewsErrorState(error.toString()));
      print(error.toString());
    });
  }

  void getEntertainment() {
    emit(GetEntertainmentNewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines/', queries: {
      'category': 'entertainment',
      'language': 'ar',
      'apiKey': 'fea6b665b7e94b77afd2dada4cb7e983'
    }).then((value) {
      print(value.data);
      entertainmentList = value.data['articles'];
      homeScreenNews.add(value.data['articles'][0]);

      emit(GetEntertainmentNewsSuccessfulState());
    }).catchError((error) {
      emit(GetEntertainmentNewsErrorState(error.toString()));
      print(error.toString());
    });
  }

  void getHealth() {
    emit(GetHealthNewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines/', queries: {
      'category': 'health',
      'language': 'ar',
      'apiKey': 'fea6b665b7e94b77afd2dada4cb7e983'
    }).then((value) {
      print(value.data);
      healthList = value.data['articles'];
      homeScreenNews.add(value.data['articles'][0]);

      emit(GetHealthNewsSuccessfulState());
    }).catchError((error) {
      emit(GetHealthNewsErrorState(error.toString()));
      print(error.toString());
    });
  }

  void getScience() {
    emit(GetScienceNewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines/', queries: {
      'category': 'science',
      'language': 'ar',
      'apiKey': 'fea6b665b7e94b77afd2dada4cb7e983'
    }).then((value) {
      print(value.data);
      scienceList = value.data['articles'];
      homeScreenNews.add(value.data['articles'][0]);

      emit(GetScienceNewsSuccessfulState());
    }).catchError((error) {
      emit(GetScienceNewsErrorState(error.toString()));
      print(error.toString());
    });
  }

  void getSport() {
    emit(GetSportNewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines/', queries: {
      'category': 'sports',
      'language': 'ar',
      'apiKey': 'fea6b665b7e94b77afd2dada4cb7e983'
    }).then((value) {
      print(value.data);
      sportsList = value.data['articles'];
      homeScreenNews.add(value.data['articles'][0]);

      emit(GetSportNewsSuccessfulState());
    }).catchError((error) {
      emit(GetSportNewsErrorState(error.toString()));
      print(error.toString());
    });
  }

  void getTechnology() {
    emit(GetTechnologyNewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines/', queries: {
      'category': 'technology',
      'language': 'ar',
      'apiKey': 'fea6b665b7e94b77afd2dada4cb7e983'
    }).then((value) {
      print(value.data);
      technologyList = value.data['articles'];
      homeScreenNews.add(value.data['articles'][0]);

      emit(GetTechnologyNewsSuccessfulState());
    }).catchError((error) {
      emit(GetTechnologyNewsErrorState(error.toString()));
      print(error.toString());
    });
  }

}
