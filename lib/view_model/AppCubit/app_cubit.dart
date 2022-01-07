import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/services/DioHelper/dio_helper.dart';
import 'package:newsapp/view_model/AppStates/app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
static AppCubit get(context) => BlocProvider.of(context);

int currentIndex=0;
List<BottomNavigationBarItem> bottomItem = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.business),
    label:'Business',

  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.science),
    label:'Science',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.sports),
    label:'Sport',
  ),
];

void changeIndexBottomNav (int index){
  currentIndex = index;
  emit(ChangeBottomNavState());
}

List<dynamic>businessList=[];


void getBusinessNew(){
  emit(GetBusinessNewsLoadingState());
  DioHelper.getData(
      url: 'v2/top-headlines/',
      queries: {
        'category': 'sports',
        'language': 'ar',
        'apiKey':
        'd4026a9324cf4415a67a049318928dad'
      })
      .then((value) {
    print(value.data);
    businessList=value.data['articles'];
    emit(GetBusinessNewsSuccessfulState());
  })
      .catchError((error) {
        emit(GetBusinessNewsErrorState(error.toString()));
    print(error.toString());
  });
}
}