import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_testapp/core/database/cache_database.dart';
import 'package:rick_morty_testapp/core/database/database.dart';
import 'package:rick_morty_testapp/core/error/failure.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/location_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/repository/fetch_cached_characters_repository.dart';


@LazySingleton(as: FetchCachedCharactersRepository)
class FetchCachedCharactersRepositoryImpl implements FetchCachedCharactersRepository{
  FetchCachedCharactersRepositoryImpl(this.appDatabase);

  final CacheDatabase appDatabase;

  @override
  Future<List<ResultEntity>> loadCache() async{
    try{
      final resultTable = await appDatabase.select(appDatabase.result).get();
      final List<ResultEntity> resultList = [];
      for(final element in resultTable){

        final originLocationStatement = appDatabase.select(appDatabase.location)
          ..where((row)=> row.id.isValue(element.locationId));
        final originTable =  await originLocationStatement.get();
        final originLocationEntity = LocationEntity(
          name: originTable.first.name,
          url: originTable.first.url,
        );

        final locationStatement =  appDatabase.select(appDatabase.location)
          ..where((row)=> row.id.isValue(element.locationId));
        final locationTable =  await locationStatement.get();
        final locationEntity = LocationEntity(
          name: locationTable.first.name,
          url: locationTable.first.url,
        );

        final ResultEntity resultEntity = ResultEntity(
          id: element.characterId,
          name: element.name,
          status:element.status,
          species:element.species,
          type:element.type,
          gender:element.gender,
          origin:originLocationEntity,
          location:locationEntity,
          image:element.image,
          episode:element.episodes,
          url:element.url,
          created:element.created,
        );
        resultList.add(resultEntity);
      }
      return resultList;
    }catch(e){
      throw DataBaseFailure();
    }
  }

  @override
  Future<void> saveCharactersToCache(List<ResultEntity> listResultEntity) async{
    try {
      listResultEntity.forEach((resultEntity) async{
        final originId = await appDatabase
            .into(appDatabase.location)
            .insert(LocationCompanion.insert(
              name: resultEntity.origin.name,
              url: resultEntity.origin.url,
            ),
            mode: InsertMode.replace,
        );
        final locationId = await appDatabase.into(appDatabase.location).insert(
              LocationCompanion.insert(
                name: resultEntity.location.name,
                url: resultEntity.location.url,
              ),
          mode: InsertMode.replace,
        );
        await appDatabase.into(appDatabase.result).insert(
              ResultCompanion.insert(
                characterId: resultEntity.id,
                name: resultEntity.name,
                status: resultEntity.status,
                species: resultEntity.species,
                type: resultEntity.type,
                gender: resultEntity.gender,
                originId: originId,
                locationId: locationId,
                image: resultEntity.image,
                episodes: resultEntity.episode,
                url: resultEntity.url,
                created: resultEntity.created,
              ),
          mode: InsertMode.replace,
        );
      });
    }catch(e){
      throw DataBaseFailure();
    }
  }

}
