import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/usecase/abstract_light_usecase.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/repository/database_repository.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';

@lazySingleton
class LoadFavoriteFromDbUC implements AbstractLightUC<List<ResultEntity>>{
  LoadFavoriteFromDbUC(this._databaseFavoriteRepository);

  final DatabaseFavoriteRepository _databaseFavoriteRepository;

  @override
  Future<List<ResultEntity>> call() async{
    return await _databaseFavoriteRepository.loadFromDB();
  }
}
