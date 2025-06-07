import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_morty_testapp/core/links/url_links.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/data/model/character_model.dart';

part 'retrofit_remote_client.g.dart';

@RestApi()
abstract class RetrofitRemoteClient {
  factory RetrofitRemoteClient(Dio dio, {String? baseUrl}) =
      _RetrofitRemoteClient;

  @GET(UrlLinks.fetchFirstCharacterPage)
  Future<CharacterModel> fetchCharacters();


  /// Ссылка полностью береться из JSON
  @GET('{url}')
  Future<CharacterModel> fetchPaginatedCharacters(
    @Path('url') String url,
      );
}
@injectable
class RetrofitRemoteClientInstance {
  RetrofitRemoteClient client() {
    return _RetrofitRemoteClient(Dio());
  }
}
