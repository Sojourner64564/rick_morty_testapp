import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/character_entity.dart';

abstract class FetchCharactersRepository{
  Future<CharacterEntity> fetchCharacters();
  Future<CharacterEntity> fetchPaginatedCharacters(String url);
}