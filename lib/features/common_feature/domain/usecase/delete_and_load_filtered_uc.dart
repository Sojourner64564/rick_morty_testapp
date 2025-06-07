import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/usecase/abstract_usecase.dart';
import 'package:rick_morty_testapp/features/common_feature/domain/repository/database_repository.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';

@lazySingleton
class DeleteAndLoadFilteredFromDbUC implements AbstractUsecase<List<ResultEntity>, DeleteAndLoadFavoriteFromDbParams>{
  DeleteAndLoadFilteredFromDbUC(this._databaseFavoriteRepository);

  final DatabaseFavoriteRepository _databaseFavoriteRepository;

  @override
  Future<List<ResultEntity>> call(DeleteAndLoadFavoriteFromDbParams params) async{
    await _databaseFavoriteRepository.deleteFromDB(params.characterId);
    return await _databaseFavoriteRepository.loadNameFilteredFromDB(params.text);
  }
  }


class  DeleteAndLoadFavoriteFromDbParams{
  final String text;
  final int characterId;
  DeleteAndLoadFavoriteFromDbParams({required this.text, required this.characterId});
}
