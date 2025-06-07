// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

import '../../features/common_feature/data/remote_ds/retrofit_remote_client.dart'
    as _i198;
import '../../features/common_feature/data/repository_impl/database_favorite_repository_impl.dart'
    as _i366;
import '../../features/common_feature/domain/repository/database_repository.dart'
    as _i1060;
import '../../features/common_feature/domain/usecase/delete_and_load_filtered_uc.dart'
    as _i235;
import '../../features/common_feature/domain/usecase/load_favorite_from_db_uc.dart'
    as _i260;
import '../../features/common_feature/domain/usecase/load_favorite_ids_uc.dart'
    as _i199;
import '../../features/common_feature/domain/usecase/load_filtered_favorite_from_db_uc.dart'
    as _i394;
import '../../features/common_feature/domain/usecase/save_or_delete_prev_favorite_uc.dart'
    as _i625;
import '../../features/common_feature/presentation/controller/theme_controller/theme_controller_cubit.dart'
    as _i530;
import '../../features/favorite_screen_feaature/presentation/sorted_favorites_cubit/sorted_favorites_cubit.dart'
    as _i15;
import '../../features/main_screen_feature/data/repository_impl/fetch_cached_characters_repository_impl.dart'
    as _i80;
import '../../features/main_screen_feature/data/repository_impl/fetch_characters_repository_impl.dart'
    as _i733;
import '../../features/main_screen_feature/domain/repository/fetch_cached_characters_repository.dart'
    as _i780;
import '../../features/main_screen_feature/domain/repository/fetch_characters_repository.dart'
    as _i475;
import '../../features/main_screen_feature/domain/usecase/cache_characters_uc.dart'
    as _i440;
import '../../features/main_screen_feature/domain/usecase/fetch_cached_characters_uc.dart'
    as _i317;
import '../../features/main_screen_feature/domain/usecase/fetch_characters_uc.dart'
    as _i293;
import '../../features/main_screen_feature/domain/usecase/fetch_paginated_characters_uc.dart'
    as _i1043;
import '../../features/main_screen_feature/presentation/controller/favorite_button_controller/favorite_button_cubit.dart'
    as _i246;
import '../../features/main_screen_feature/presentation/controller/favorite_card_controller/favorite_card_controller.dart'
    as _i857;
import '../../features/main_screen_feature/presentation/controller/fetch_characters_cubit/fetch_characters_cubit.dart'
    as _i860;
import '../database/cache_database.dart' as _i614;
import '../database/favorite_database.dart' as _i890;
import '../network/internet_connection_checker.dart' as _i657;
import '../network/network_info.dart' as _i932;
import '../network/network_info_impl.dart' as _i865;
import '../route/app_router.dart' as _i1007;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModuleConnectionChecker = _$RegisterModuleConnectionChecker();
  gh.factory<_i973.InternetConnectionChecker>(
      () => registerModuleConnectionChecker.internetConnection);
  gh.factory<_i198.RetrofitRemoteClientInstance>(
      () => _i198.RetrofitRemoteClientInstance());
  gh.lazySingleton<_i614.CacheDatabase>(() => _i614.CacheDatabase());
  gh.lazySingleton<_i890.FavoriteDatabase>(() => _i890.FavoriteDatabase());
  gh.lazySingleton<_i1007.AppRouter>(() => _i1007.AppRouter());
  gh.lazySingleton<_i530.ThemeControllerCubit>(
      () => _i530.ThemeControllerCubit());
  gh.lazySingleton<_i780.FetchCachedCharactersRepository>(() =>
      _i80.FetchCachedCharactersRepositoryImpl(gh<_i614.CacheDatabase>()));
  gh.lazySingleton<_i1060.DatabaseFavoriteRepository>(
      () => _i366.DatabaseFavoriteRepositoryImpl(gh<_i890.FavoriteDatabase>()));
  gh.lazySingleton<_i260.LoadFavoriteFromDbUC>(() =>
      _i260.LoadFavoriteFromDbUC(gh<_i1060.DatabaseFavoriteRepository>()));
  gh.lazySingleton<_i199.LoadFavoriteIdsUC>(
      () => _i199.LoadFavoriteIdsUC(gh<_i1060.DatabaseFavoriteRepository>()));
  gh.lazySingleton<_i394.LoadFilteredFavoriteFromDbUC>(() =>
      _i394.LoadFilteredFavoriteFromDbUC(
          gh<_i1060.DatabaseFavoriteRepository>()));
  gh.lazySingleton<_i625.SaveOrDeletePrevFavoriteUC>(() =>
      _i625.SaveOrDeletePrevFavoriteUC(
          gh<_i1060.DatabaseFavoriteRepository>()));
  gh.lazySingleton<_i235.DeleteAndLoadFilteredFromDbUC>(() =>
      _i235.DeleteAndLoadFilteredFromDbUC(
          gh<_i1060.DatabaseFavoriteRepository>()));
  gh.lazySingleton<_i246.FavoriteButtonCubit>(() => _i246.FavoriteButtonCubit(
        gh<_i625.SaveOrDeletePrevFavoriteUC>(),
        gh<_i199.LoadFavoriteIdsUC>(),
      ));
  gh.lazySingleton<_i932.NetworkInfo>(
      () => _i865.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
  gh.lazySingleton<_i440.CacheCharactersUC>(() =>
      _i440.CacheCharactersUC(gh<_i780.FetchCachedCharactersRepository>()));
  gh.lazySingleton<_i317.FetchCachedCharactersUc>(() =>
      _i317.FetchCachedCharactersUc(
          gh<_i780.FetchCachedCharactersRepository>()));
  gh.lazySingleton<_i15.SortedFavoritesCubit>(() => _i15.SortedFavoritesCubit(
        gh<_i394.LoadFilteredFavoriteFromDbUC>(),
        gh<_i260.LoadFavoriteFromDbUC>(),
        gh<_i235.DeleteAndLoadFilteredFromDbUC>(),
        gh<_i246.FavoriteButtonCubit>(),
      ));
  gh.lazySingleton<_i475.FetchCharactersRepository>(
      () => _i733.FetchCharactersRepositoryImpl(
            gh<_i198.RetrofitRemoteClientInstance>(),
            gh<_i932.NetworkInfo>(),
          ));
  gh.lazySingleton<_i857.FavoriteCardController>(
      () => _i857.FavoriteCardController(
            gh<_i246.FavoriteButtonCubit>(),
            gh<_i15.SortedFavoritesCubit>(),
          ));
  gh.lazySingleton<_i293.FetchCharactersUC>(
      () => _i293.FetchCharactersUC(gh<_i475.FetchCharactersRepository>()));
  gh.lazySingleton<_i1043.FetchPaginatedCharactersUC>(() =>
      _i1043.FetchPaginatedCharactersUC(gh<_i475.FetchCharactersRepository>()));
  gh.lazySingleton<_i860.FetchCharactersCubit>(() => _i860.FetchCharactersCubit(
        gh<_i293.FetchCharactersUC>(),
        gh<_i440.CacheCharactersUC>(),
        gh<_i317.FetchCachedCharactersUc>(),
        gh<_i1043.FetchPaginatedCharactersUC>(),
      ));
  return getIt;
}

class _$RegisterModuleConnectionChecker
    extends _i657.RegisterModuleConnectionChecker {}
