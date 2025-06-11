import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/core/injectable/injectable.dart';
import 'package:rick_morty_testapp/features/common_feature/presentation/widget/character_card_widget.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/sorted_favorites_cubit/sorted_favorites_cubit.dart';
import 'dart:math' show pi;


class FavoritePage extends StatefulWidget {
  FavoritePage({
    required this.textEditingController,
  });
  final GlobalKey<AnimatedGridState> gridKey = GlobalKey();

  final TextEditingController textEditingController;
  final sortedFavoritesCubit = getIt<SortedFavoritesCubit>();

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;


  @override
  void initState() {
    print('initState');
    isInitStateComplete = true;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  void _flipCard() {
    if ( animationController.status == AnimationStatus.completed) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  bool isDeleting = false;
  int indexOfAnimatedGrid = 0;
  bool isInitStateComplete = false;

  @override
  void dispose() {
    print('dispose');
    animationController.dispose();
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
          print("SortedFavoritesStateLoaded");
          indexOfAnimatedGrid = state.resultEntityList.length;

          return Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    widget.sortedFavoritesCubit.loadCharactersWithoutFilter();
                    //widget.sortedFavoritesCubit.sortCharacters('mo');
                   // widget.sortedFavoritesCubit.test1();
                      //widget.gridKey.currentState?.insertItem(2);
                  }, icon: Icon(Icons.ac_unit),
                  ),
                  IconButton(onPressed: (){
                    //widget.sortedFavoritesCubit.sortCharacters('mo');
                     widget.sortedFavoritesCubit.test1();
                    //gridKey.currentState?.insertItem(2);
                  }, icon: Icon(Icons.update),
                  ),
                  IconButton(onPressed: (){
                    //widget.sortedFavoritesCubit.sortCharacters('mo');
                    widget.sortedFavoritesCubit.test2();
                    //gridKey.currentState?.insertItem(2);
                  }, icon: Icon(Icons.abc_rounded),
                  ),
                  IconButton(onPressed: (){
                    widget.sortedFavoritesCubit.sortCharacters('');
                    //widget.sortedFavoritesCubit.test2();
                    //gridKey.currentState?.insertItem(2);
                  }, icon: Icon(Icons.access_time_rounded),
                  ),
                  IconButton(onPressed: (){
                    widget.sortedFavoritesCubit.sortCharacters('mo');
                    //widget.sortedFavoritesCubit.test2();
                    //gridKey.currentState?.insertItem(2);
                  }, icon: Icon(Icons.access_time_rounded),
                  ),
                  IconButton(onPressed: (){
                    widget.sortedFavoritesCubit.sortCharacters('s');
                    //widget.sortedFavoritesCubit.test2();
                    //gridKey.currentState?.insertItem(2);
                  }, icon: Icon(Icons.access_time_rounded),
                  ),
                ],
              ),
              Expanded(
                child: AnimatedGrid(
                  key: widget.gridKey,
                  initialItemCount: state.resultEntityList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.63,
                  ),
                  itemBuilder: (context, index, animation) {
                    indexOfAnimatedGrid = state.resultEntityList.length;
                    if(isInitStateComplete){
                      if(!isDeleting){
                        // gridKey.currentState?.insertItem(indexOfAnimatedGrid-1);
                      }
                    }


                    print('gridTile $index');
                    print('lenght of state ${state.resultEntityList.length}');
                    final result = state.resultEntityList[index];

                    return ScaleTransition(
                      scale: animation,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CharacterCardWidget(
                          resultEntity: result,
                          isFavorite: true,
                          onTap: () {
                              isDeleting = true;
                             //_flipCard();
                              widget.gridKey.currentState?.removeItem(index,
                                duration: const Duration(seconds: 1),
                                    (context, animation) {
                                return Container(
                                    color: Colors.yellow
                                );
                                  return MatrixTransition(
                                    animation:  animationController,
                                    onTransform: (double value) {
                                      return Matrix4.identity()..setEntry(3, 2, 0.001)
                                        ..rotateY(pi * value);
                                    },
                                    child: ValueListenableBuilder<double>(
                                      valueListenable:  animationController,
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
                                  .deleteWithFilter(widget.textEditingController.text, result.id);
                            isDeleting = false;
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
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
