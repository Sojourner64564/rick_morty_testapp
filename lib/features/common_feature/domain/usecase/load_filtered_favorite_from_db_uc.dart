import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/usecase/abstract_usecase.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/repository/database_repository.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';

@lazySingleton
class LoadFilteredFavoriteFromDbUC implements AbstractUsecase<List<ResultEntity>, String>{
  LoadFilteredFavoriteFromDbUC(this._databaseFavoriteRepository);

  final DatabaseFavoriteRepository _databaseFavoriteRepository;

  @override
  Future<List<ResultEntity>> call(String text) async{
    if(text.isEmpty){
      return await _databaseFavoriteRepository.loadFromDB();
    }
    // Дебаунсер на запросы к базе данных
    await Future.delayed(const Duration(milliseconds: 300));
    return await _databaseFavoriteRepository.loadNameFilteredFromDB(text);
  }

}
