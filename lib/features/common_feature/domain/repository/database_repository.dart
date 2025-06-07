
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';

abstract class DatabaseFavoriteRepository{
  Future<void> saveToDB(ResultEntity resultEntity);
  Future<List<ResultEntity>> loadFromDB();
  Future<List<ResultEntity>> loadNameFilteredFromDB(String text);
  Future<List<int>> favoriteIds();
  Future<void> deleteFromDB(int characterId);
}