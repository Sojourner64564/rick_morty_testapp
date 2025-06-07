import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/core/injectable/injectable.dart';
import 'package:rick_morty_testapp/features/common_feature/presentation/widget/character_card_widget.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/sorted_favorites_cubit/sorted_favorites_cubit.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key, required this.controller});
  final TextEditingController controller;

  final sortedFavoritesCubit = getIt<SortedFavoritesCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortedFavoritesCubit, SortedFavoritesState>(
      bloc: sortedFavoritesCubit,
      builder: (context, state) {
        if(state is SortedFavoritesStateInitial){
          return const Center(
            child: Text(
              'Initial',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        }
        if(state is SortedFavoritesStateLoading){
          return const Center(
            child: Text(
              'Loading',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        }
        if(state is SortedFavoritesStateLoaded){
          return GridView.builder(
            itemCount: state.resultEntityList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.63,
            ),
            itemBuilder: (BuildContext context, int index) {
              final result = state.resultEntityList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CharacterCardWidget(
                  onTap: () {
                    sortedFavoritesCubit.deleteWithFilter(controller.text, result.id);
                  },
                  resultEntity: result,
                  isFavorite: true,
                ),
              );
            },
          );
        }
        if(state is SortedFavoritesStateLoadedEmpty){
          return const Center(
            child: Text(
              'Empty Result',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        }
        if(state is SortedFavoritesStateError){
          return const Center(
            child: Text(
              'Error',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        }else{
          return const Center(
            child: Text(
              'Unexpected Error',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        }
      },
    );
  }
}
