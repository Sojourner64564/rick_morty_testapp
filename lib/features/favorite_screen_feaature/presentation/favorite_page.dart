import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/core/injectable/injectable.dart';
import 'package:rick_morty_testapp/features/common_feature/presentation/widget/character_card_widget.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/sorted_favorites_cubit/sorted_favorites_cubit.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/widget/back_delete_card_widget.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/widget/front_delete_card_widget.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';
import 'dart:math' show pi;


class FavoritePage extends StatefulWidget {
  FavoritePage({
    required this.controller,
  }) : super(key: UniqueKey());

  final TextEditingController controller;
  final sortedFavoritesCubit = getIt<SortedFavoritesCubit>();

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedGridState> gridKey = GlobalKey();

  late AnimationController controller;

  @override
  void initState() {
    print('initState');
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  void _flipCard() {
    if (controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  Future<void> deleteCardAndAnimate(int resultsLength, ResultEntity resultEntity) async{
    await widget.sortedFavoritesCubit
        .deleteWithFilter(widget.controller.text, resultEntity.id);

    _flipCard();
    gridKey.currentState?.removeItem(resultsLength,
        duration: const Duration(seconds: 1),
            (context, animation) {
          return MatrixTransition(
            animation: controller,
            onTransform: (double value) {
              return Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(pi * value);
            },
            child: ValueListenableBuilder<double>(
              valueListenable: controller,
              builder: (context, value, child) {
                final showFront = (value * pi) < pi / 2;
                return Stack(
                  children: [
                    if (!showFront)
                      Transform(
                        transform: Matrix4.identity()
                          ..rotateY(pi),
                        alignment: Alignment.center,
                        child: const BackDeleteCardWidget(),
                      ),
                    if (showFront)
                      FrontDeleteCardWidget(
                        resultEntity: resultEntity,
                      ),
                  ],
                );
              },
            ),
          );
        });
  }

  //int counter = 0;

  @override
  void dispose() {
    print('dispose');
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build _FavoritePageState');
    return BlocBuilder<SortedFavoritesCubit, SortedFavoritesState>(
      bloc: widget.sortedFavoritesCubit,
      builder: (context, state) {
        if (state is SortedFavoritesStateInitial) {
          return const Center(
            child: Text(
              'Initial',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        }
        if (state is SortedFavoritesStateLoading) {
          return const Center(
            child: Text(
              'Loading',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        }
        if (state is SortedFavoritesStateLoaded) {
         // counter = state.resultEntityList.length;
          print("SortedFavoritesStateLoaded");

          return AnimatedGrid(
            key: gridKey,
            initialItemCount: state.resultEntityList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.63,
            ),
            itemBuilder: (context, index, animation) {
              print('gridTile $index');
              final result = state.resultEntityList[index];
              return ScaleTransition(
                scale: animation,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CharacterCardWidget(
                    onTap: () {
                      //deleteCardAndAnimate(state.resultEntityList.length, result);

                     // setState(() {


                       //counter--;
                        _flipCard();
                        gridKey.currentState?.removeItem(index,
                          duration: const Duration(seconds: 1),
                              (context, animation) {
                            return MatrixTransition(
                              animation: controller,
                              onTransform: (double value) {
                                return Matrix4.identity()..setEntry(3, 2, 0.001)
                                  ..rotateY(pi * value);
                              },
                              child: ValueListenableBuilder<double>(
                                valueListenable: controller,
                                builder: (context, value, child) {
                                  final showFront = (value * pi) < pi / 2;
                                  return Stack(
                                    children: [
                                      if (!showFront)
                                        Container(
                                          color: Colors.blue,
                                        ),
                                       /* Transform(
                                          transform: Matrix4.identity()..rotateY(pi),
                                          alignment: Alignment.center,
                                          child: const BackDeleteCardWidget(),
                                        ),*/
                                      if (showFront)
                                        Container(
                                          color: Colors.yellow
                                        ),
                                       /* FrontDeleteCardWidget(
                                          resultEntity: result,
                                        ),*/
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );

                        widget.sortedFavoritesCubit
                            .deleteWithFilter(widget.controller.text, result.id);
                      //});

                    },
                    resultEntity: result,
                    isFavorite: true,
                  ),
                ),
              );
            },
          );
/*
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
                    sortedFavoritesCubit.deleteWithFilter(
                        widget.controller.text, result.id);
                  },
                  resultEntity: result,
                  isFavorite: true,
                ),
              );
            },
          );*/
        }
        if (state is SortedFavoritesStateLoadedEmpty) {
          return const Center(
            child: Text(
              'Empty Result',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        }
        if (state is SortedFavoritesStateError) {
          return const Center(
            child: Text(
              'Error',
              style: AppLightTextstyles.w700Text20,
            ),
          );
        } else {
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
