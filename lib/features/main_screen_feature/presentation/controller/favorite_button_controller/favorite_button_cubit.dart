import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/usecase/load_favorite_ids_uc.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/usecase/save_or_delete_prev_favorite_uc.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';

@lazySingleton
class FavoriteButtonCubit extends Cubit<List<int>>{
  FavoriteButtonCubit(this._saveOrDeletePrevFavoriteUC, this._loadFavoriteIdsUC) : super([]);

  final SaveOrDeletePrevFavoriteUC _saveOrDeletePrevFavoriteUC;
  final LoadFavoriteIdsUC _loadFavoriteIdsUC;

  Future<void> saveOrDeletePrevFavorite(ResultEntity resultEntity) async{
    await _saveOrDeletePrevFavoriteUC.call(resultEntity).then((favoriteIds){
      emit(favoriteIds);
    }).onError((error, stackTrace){
      // TODO добавить обратную свзяь
    });
  }


  Future<void> updateFavoriteButtons() async{
    await _loadFavoriteIdsUC.call().then((favoriteIds){
      emit(favoriteIds);
    }).onError((error, stackTrace){
      // TODO добавить обратную свзяь
    });
  }

}

