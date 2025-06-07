import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/usecase/save_or_delete_prev_favorite_uc.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';

@lazySingleton
class FavoriteButtonCubit extends Cubit<List<int>>{
  FavoriteButtonCubit(this._saveOrDeletePrevFavoriteUC) : super([]);

  final SaveOrDeletePrevFavoriteUC _saveOrDeletePrevFavoriteUC;

  Future<void> saveOrDeletePrevFavorite(ResultEntity resultEntity) async{
    _saveOrDeletePrevFavoriteUC.call(resultEntity).then((favoriteIds){
      emit(favoriteIds);
    }).onError((error, stackTrace){
      // TODO добавить обратную свзяь
    });
  }

}

