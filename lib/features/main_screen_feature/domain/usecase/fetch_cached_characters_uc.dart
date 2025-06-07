import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/usecase/abstract_light_usecase.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/repository/fetch_cached_characters_repository.dart';

@lazySingleton
class FetchCachedCharactersUc implements AbstractLightUC<List<ResultEntity>>{
  FetchCachedCharactersUc(this._fetchCachedCharactersRepository);

  final FetchCachedCharactersRepository _fetchCachedCharactersRepository;

  @override
  Future<List<ResultEntity>> call() async{
    return await _fetchCachedCharactersRepository.loadCache();
  }
}

