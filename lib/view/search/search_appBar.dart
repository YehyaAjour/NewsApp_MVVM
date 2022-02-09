import 'package:flutter/material.dart';
import 'package:newsapp/view/CustomWidget/custom_search.dart';
import 'package:newsapp/view_model/AppCubit/app_cubit.dart';


Widget SearchAppBar (context){
  TextEditingController searchController = TextEditingController();

  return AppBar(

    leading: AppCubit.get(context).isSearching
        ? BackButton(
      onPressed: () {
        AppCubit.get(context)
            .changeSearchState(isSearchingShown: false);
      },
    )
        : null,
    toolbarHeight: 90,
    title: AppCubit.get(context).isSearching
        ? SizedBox(
      height: 50,
      child: defaultTextFormField(
        onchange: (value) {AppCubit.get(context).getSearch(value);},
        controller: searchController,
        keyboardType: TextInputType.text,
        validate: (value) {
          print("value");
        },
        labelText: "",
        inputBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)),
        fillBoxColor: Colors.white,
      ),
    )
        : Text(
      "البحث",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Color(0xff00266f),
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            AppCubit.get(context)
                .changeSearchState(isSearchingShown: true);
          },
        ),
      )
    ],
  );

}