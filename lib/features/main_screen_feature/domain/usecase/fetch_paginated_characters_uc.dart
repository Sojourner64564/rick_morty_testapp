import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/usecase/abstract_usecase.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/character_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/repository/fetch_characters_repository.dart';

@lazySingleton
class FetchPaginatedCharactersUC implements AbstractUsecase<CharacterEntity, String>{
  FetchPaginatedCharactersUC(this.fetchCharactersRepository);

  final FetchCharactersRepository fetchCharactersRepository;

  @override
  Future<CharacterEntity> call(String url) async{
    return await fetchCharactersRepository.fetchPaginatedCharacters(url);
  }

}