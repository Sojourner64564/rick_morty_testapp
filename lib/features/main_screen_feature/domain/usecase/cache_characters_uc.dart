import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/usecase/abstract_usecase.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/character_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/repository/fetch_cached_characters_repository.dart';

@lazySingleton
class CacheCharactersUC implements AbstractUsecase<void, CharacterEntity>{
  CacheCharactersUC(this._fetchCachedCharactersRepository);

  final FetchCachedCharactersRepository _fetchCachedCharactersRepository;

  @override
  Future<void> call(CharacterEntity characterEntity) async{
    //логика чтобы не сохранять дубликаты
    final cached = await _fetchCachedCharactersRepository.loadCache();
    //Разница между листами
    final difference = characterEntity.results.where((id1) => !cached.any((id2) => id2.id == id1.id)).toList();
    return await _fetchCachedCharactersRepository.saveCharactersToCache(difference);
  }

}