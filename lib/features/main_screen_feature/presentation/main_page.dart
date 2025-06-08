import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/core/injectable/injectable.dart';
import 'package:rick_morty_testapp/features/common_feature/presentation/widget/blur_animation_widget.dart';
import 'package:rick_morty_testapp/features/common_feature/presentation/widget/character_card_widget.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/sorted_favorites_cubit/sorted_favorites_cubit.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/controller/favorite_button_controller/favorite_button_cubit.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/controller/favorite_card_controller/favorite_card_controller.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/presentation/controller/fetch_characters_cubit/fetch_characters_cubit.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  final fetchCharactersCubit = getIt<FetchCharactersCubit>();
  final favoriteButtonCubit = getIt<FavoriteButtonCubit>();
  final sortedFavoritesCubit = getIt<SortedFavoritesCubit>();
  final favoriteCardController = getIt<FavoriteCardController>();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final scrollController = ScrollController();
  late AnimationController firstAnimationController;
  late AnimationController secondAnimationController;

  void _scrollListener(){
    widget.fetchCharactersCubit.fetchPaginatedCharacters(scrollController.offset, scrollController.position.maxScrollExtent);
  }


  @override
  void initState() {
    firstAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 5000));

    widget.fetchCharactersCubit.fetchCharacters();
    widget.favoriteButtonCubit.updateFavoriteButtons();
    widget.sortedFavoritesCubit.loadCharactersWithoutFilter();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void animate(){
    firstAnimationController.reset();
    firstAnimationController.forward();
  }

  @override
  void dispose() {
    firstAnimationController.dispose();
    secondAnimationController.dispose();

    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  int animateIndex = -1;
  bool hideWidget = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<FetchCharactersCubit, FetchCharactersState>(
        bloc: widget.fetchCharactersCubit,
        builder: (context, fetchCharacterState) {
          if (fetchCharacterState is FetchCharactersStateInitial) {
            return const Center(
              child: Text(
                'Initial',
                style: AppLightTextstyles.w700Text20,
              ),
            );
          }
          if (fetchCharacterState is FetchCharactersStateLoading) {
            return const Center(
              child: Text(
                'Loading',
                style: AppLightTextstyles.w700Text20,
              ),
            );
          }
          if (fetchCharacterState is FetchCharactersStateLoaded) {
            return RefreshIndicator(
              onRefresh: () async{
                widget.fetchCharactersCubit.fetchCharacters();
              },
              child: GridView.builder(
                itemCount: fetchCharacterState.characterEntity.results.length,
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.63,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final result = fetchCharacterState.characterEntity.results[index];

                  return BlurAnimationWidget(
                    animationController: firstAnimationController,
                    animateWidget: animateIndex == index,
                      animateToRight: true,
                      hideWidget: hideWidget,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<FavoriteButtonCubit, List<int>>(
                          bloc: widget.favoriteButtonCubit,
                          builder: (context, favoriteButtonState) {
                            return CharacterCardWidget(
                              onTap: () {
                                setState(() {
                                  hideWidget = true;
                                  animateIndex = index;
                                });
                                animate();
                                widget.favoriteCardController.saveFavoriteCard(result);
                              },
                              resultEntity: result,
                              isFavorite:  favoriteButtonState.contains(result.id),
                            );
                          },
                        ),
                      ),

                  );
                },
              ),
            );
          }
          if (fetchCharacterState is FetchCharactersStateCacheEmpty) {
            return const Center(
              child: Text(
                'Cache Empty',
                style: AppLightTextstyles.w700Text20,
              ),
            );
          }
          if (fetchCharacterState is FetchCharactersStateCacheError) {
            return const Center(
              child: Text(
                'Cache Error',
                style: AppLightTextstyles.w700Text20,
              ),
            );
          }
          if (fetchCharacterState is FetchCharactersStateError) {
            return const Center(
              child: Text(
                'Error',
                style: AppLightTextstyles.w700Text20,
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Unexpected error',
                style: AppLightTextstyles.w700Text20,
              ),
            );
          }
        },
      ),
    );
  }
}

