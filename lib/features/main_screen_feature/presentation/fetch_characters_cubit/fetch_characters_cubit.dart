import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/error/failure.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/character_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/usecase/fetch_characters_uc.dart';



part 'fetch_characters_state.dart';

@lazySingleton
class FetchCharactersCubit extends Cubit<FetchCharactersState> {
  FetchCharactersCubit(this._fetchCharactersUC,) : super(FetchCharactersStateInitial());

  final FetchCharactersUC _fetchCharactersUC;

  void fetchCharacters() {
    emit(FetchCharactersStateLoading());
    _fetchCharactersUC.call().then((entity){
      emit(FetchCharactersStateLoaded(entity));

      }).onError<Failure>((error, stackTrace){

      });

    }
}

