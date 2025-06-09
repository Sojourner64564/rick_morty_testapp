import 'package:flutter/animation.dart' show AnimationController;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:injectable/injectable.dart';



@lazySingleton
class BlurAnimationControllerCubit extends Cubit<int> {
  BlurAnimationControllerCubit() : super(-1);

  Future<void> updateWidget(int index, AnimationController controller, bool isNeedToAnimate) async{
    if (isNeedToAnimate) return;

    emit(index);
    controller.reset();
    controller.forward();

  }
}
