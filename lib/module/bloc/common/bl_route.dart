import 'package:flutter/material.dart';
import 'package:sm/module/bloc/base_bloc/base_bloc_page.dart';
import 'package:sm/module/bloc/base_bloc/cubit_page.dart';
import 'package:sm/module/bloc/eg/form_validate/form_page.dart';

class BlRoute {
  static String blHome = "/";
  static String blCubitPage = "/cubitPage";
  static String blBlocPage = "/blocPage";
  static String blCounterCubitPage = "/counterCubitPage";
  static String blCounterBlocPage = "/counterBlocPage";
  static String blFormValidatePage = "formValidatePage";

  static Map<String,WidgetBuilder> routes = {
    blCubitPage:(context) => const CubitPage(),
    blBlocPage:(context) => const BaseBlocPage(),
    blCounterCubitPage: (context) => const CounterCubitPage(),
    blCounterBlocPage: (context) => const CounterBlocPage(),
    blFormValidatePage: (context) => const FormPage()
  };
}