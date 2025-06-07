import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/error/failure.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/character_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/usecase/cache_characters_uc.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/usecase/fetch_cached_characters_uc.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/usecase/fetch_characters_uc.dart';



part 'fetch_characters_state.dart';

@lazySingleton
class FetchCharactersCubit extends Cubit<FetchCharactersState> {
  FetchCharactersCubit(this._fetchCharactersUC, this._cacheCharactersUC, this._fetchCachedCharactersUC) : super(FetchCharactersStateInitial());

  final FetchCharactersUC _fetchCharactersUC;
  final CacheCharactersUC _cacheCharactersUC;
  final FetchCachedCharactersUc _fetchCachedCharactersUC;

  Future<void> fetchCharacters() async{
    emit(FetchCharactersStateLoading());
    _fetchCharactersUC.call().then((entity) async{
      emit(FetchCharactersStateLoaded(entity));
      await _cacheCharactersUC.call(entity).onError((error, stackTrace){
        //TODO обратная свзяь об ошибки записи
      });
      }).onError<Failure>((error, stackTrace){

      if(error is NoInternetFailure){
        _fetchCachedCharactersUC.call().then((results){
          if(results.isEmpty){
            emit(FetchCharactersStateCacheEmpty());
          }else{
            emit(FetchCharactersStateLoaded(
              CharacterEntity(
                results: results,
              ),
            ));
          }
        }).onError<Failure>((error, stackTrace){
          emit(FetchCharactersStateCacheError());
        });
      }
      if(error is AppFailure){
        emit(FetchCharactersStateError());
      }

      });

    }
}

