import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'animated_grid_controller_state.dart';

class AnimatedGridControllerCubit extends Cubit<AnimatedGridControllerState> {
  AnimatedGridControllerCubit() : super(AnimatedGridControllerInitial());

  void animated() async{

  }
}
