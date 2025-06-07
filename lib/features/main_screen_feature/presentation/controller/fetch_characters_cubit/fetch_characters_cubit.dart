import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/error/failure.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/character_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/extension/extension_character_entity_to_updated.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/usecase/cache_characters_uc.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/usecase/fetch_cached_characters_uc.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/usecase/fetch_characters_uc.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/usecase/fetch_paginated_characters_uc.dart';



part 'fetch_characters_state.dart';

@lazySingleton
class FetchCharactersCubit extends Cubit<FetchCharactersState> {
  FetchCharactersCubit(this._fetchCharactersUC, this._cacheCharactersUC, this._fetchCachedCharactersUC, this._fetchPaginatedCharactersUC) : super(FetchCharactersStateInitial());

  final FetchCharactersUC _fetchCharactersUC;
  final CacheCharactersUC _cacheCharactersUC;
  final FetchCachedCharactersUc _fetchCachedCharactersUC;
  final FetchPaginatedCharactersUC _fetchPaginatedCharactersUC;

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


  void fetchPaginatedCharacters(double actualOffset, double maxScroll) {
    if(state is! FetchCharactersStateLoaded) return;
    if((state as FetchCharactersStateLoaded).characterEntity.info.next == '') return;
    // На 90 процентов от максимальной длины страницы будет добавляться следующая страница
    if(!((maxScroll*0.9)<actualOffset)) return;

    final fetchCharactersStateLoaded = state as FetchCharactersStateLoaded;

    _fetchPaginatedCharactersUC.call(fetchCharactersStateLoaded.characterEntity.info.next).then((entity) async{
      emit(FetchCharactersStateLoaded(fetchCharactersStateLoaded.characterEntity.insertIn(entity)));

      await _cacheCharactersUC.call(entity).then((value){
        //TODO обратная свзязь что данные сохранились (например в виде маленького значка в углу экрана)
      }).onError<Failure>((error, stackTrace){
        //TODO обратная свзязь
      });

    }).onError<Failure>((error, stackTrace){
      if(error is NoInternetFailure){
        //TODO сделать обратную связь
      }
      if(error is AppFailure){
        //TODO сделать обратную связь
      }
    });
  }
}

