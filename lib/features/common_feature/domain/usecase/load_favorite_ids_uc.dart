import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/usecase/abstract_light_usecase.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/repository/database_repository.dart';

@lazySingleton
class LoadFavoriteIdsUC implements AbstractLightUC<List<int>>{
  LoadFavoriteIdsUC(this._databaseFavoriteRepository);

  final DatabaseFavoriteRepository _databaseFavoriteRepository;

  @override
  Future<List<int>> call() async{
    return await _databaseFavoriteRepository.favoriteIds();
  }

}
