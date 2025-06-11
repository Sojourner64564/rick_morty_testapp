import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/error/failure.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/usecase/delete_and_load_filtered_uc.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/usecase/load_favorite_from_db_uc.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/usecase/load_filtered_favorite_from_db_uc.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/controller/favorite_button_controller/favorite_button_cubit.dart';


part 'sorted_favorites_state.dart';

@lazySingleton
class SortedFavoritesCubit extends Cubit<SortedFavoritesState> {
  SortedFavoritesCubit(this._loadFilteredFavoriteFromDbUC, this._loadFavoriteFromDbUC, this._deleteAndLoadFilteredFromDbUC, this._favoriteButtonCubit) : super(SortedFavoritesStateInitial());

  final LoadFilteredFavoriteFromDbUC _loadFilteredFavoriteFromDbUC;
  final LoadFavoriteFromDbUC _loadFavoriteFromDbUC;
  final DeleteAndLoadFilteredFromDbUC _deleteAndLoadFilteredFromDbUC;

  final FavoriteButtonCubit _favoriteButtonCubit;

  Future<void> sortCharacters(String text) async{
    emit(SortedFavoritesStateLoading());
    await _loadFilteredFavoriteFromDbUC.call(text).then((entity){
      if(entity.isEmpty) {
        emit(SortedFavoritesStateLoadedEmpty());
      }else{
        for(final item in entity){
          print('damn name is: ${item.name}');
        }
        emit(SortedFavoritesStateLoaded(entity));
      }
    }).onError<Failure>((error, stackTrace){
        emit(SortedFavoritesStateError());
    });
  }

  Future<void> loadCharactersWithoutFilter() async{
    emit(SortedFavoritesStateLoading());
    await _loadFavoriteFromDbUC.call().then((entity){
      if(entity.isEmpty) {
        emit(SortedFavoritesStateLoadedEmpty());
      }else{
        for(final item in entity){
          print('damn name is: ${item.name}');
        }

          emit(SortedFavoritesStateLoaded(entity));
      }
    }).onError<Failure>((error, stackTrace){
      emit(SortedFavoritesStateError());
    });
  }

  Future<void> deleteWithFilter(String text, characterId) async{
    emit(SortedFavoritesStateLoading());
    await _deleteAndLoadFilteredFromDbUC.call(DeleteAndLoadFavoriteFromDbParams(
        characterId: characterId, text: text)).then((entity) async{
      await _favoriteButtonCubit.updateFavoriteButtons();

      if(entity.isEmpty) {
        emit(SortedFavoritesStateLoadedEmpty());
      }else{
        emit(SortedFavoritesStateLoaded(entity));
      }
    }).onError<Failure>((error, stackTrace){
      emit(SortedFavoritesStateError());
    });
  }

  Future<void> test1() async{
    final List<ResultEntity> listResult = [
      ResultEntity(
        name: 'Name1'
      ),
      ResultEntity(
          name: 'Name2'
      ),
      ResultEntity(
          name: 'Name3'
      ),
      ResultEntity(
          name: 'Name4'
      ),
    ];
    emit(SortedFavoritesStateLoaded(listResult));
  }

  Future<void> test2() async{
    final List<ResultEntity> listResult = [
      ResultEntity(
          name: 'Name1'
      ),

    ];
    emit(SortedFavoritesStateLoaded(listResult));
  }
}
