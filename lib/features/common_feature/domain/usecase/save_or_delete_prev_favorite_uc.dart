import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/usecase/abstract_usecase.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/repository/database_repository.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';

@lazySingleton
class SaveOrDeletePrevFavoriteUC implements AbstractUsecase<List<int>, ResultEntity>{
  SaveOrDeletePrevFavoriteUC(this._databaseFavoriteRepository);

  final DatabaseFavoriteRepository _databaseFavoriteRepository;

  @override
  Future<List<int>> call(ResultEntity resultEntity) async{
    // логика для удаление из дазы данных при повторном нажатии на кнопку
    final allFavoritesCharacter = await _databaseFavoriteRepository.loadFromDB();
    final List<ResultEntity> overlapResultEntity = [];
    allFavoritesCharacter.forEach((value){
      if(value.id==resultEntity.id){
        overlapResultEntity.add(value);
      }
    });
    overlapResultEntity.forEach((value){
      _databaseFavoriteRepository.deleteFromDB(value.id);
    });
    if(overlapResultEntity.isEmpty){
      await _databaseFavoriteRepository.saveToDB(resultEntity);
      return await _databaseFavoriteRepository.favoriteIds();
    }else{
      return await _databaseFavoriteRepository.favoriteIds();
    }
  }

}