import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/sorted_favorites_cubit/sorted_favorites_cubit.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/controller/favorite_button_controller/favorite_button_cubit.dart';

@lazySingleton
class FavoriteCardController {
  FavoriteCardController(this._favoriteButtonCubit, this._sortedFavoritesCubit);

  final FavoriteButtonCubit _favoriteButtonCubit;
  final SortedFavoritesCubit _sortedFavoritesCubit;

  Future<void> saveFavoriteCard(ResultEntity resultEntity) async{
    await _favoriteButtonCubit.saveOrDeletePrevFavorite(resultEntity).then((_) async{
       await _sortedFavoritesCubit.loadCharactersWithoutFilter();
    }).onError((error, stackTrace){

    });
  }
}

