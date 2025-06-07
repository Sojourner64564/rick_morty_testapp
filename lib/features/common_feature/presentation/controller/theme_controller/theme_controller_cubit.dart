import 'package:flutter/material.dart' show ThemeData;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/theme/theme.dart';

@lazySingleton
class ThemeControllerCubit extends Cubit<ThemeData> {
  ThemeControllerCubit() : super(AppThemeData.lightTheme);


  void changeTheme(){
    if(state == AppThemeData.lightTheme){
      emit(AppThemeData.darkTheme);
    }else{
      emit(AppThemeData.lightTheme);
    }
  }
}
