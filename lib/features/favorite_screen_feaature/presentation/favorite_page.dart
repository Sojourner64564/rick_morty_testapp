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

  final TextEditingController textEditingController;
  final sortedFavoritesCubit = getIt<SortedFavoritesCubit>();
  late AnimationController animationController;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedGridState> gridKey = GlobalKey();


  @override
  void initState() {
    print('initState');
    widget.animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  void _flipCard() {
    if ( widget.animationController.status == AnimationStatus.completed) {
      widget.animationController.reverse();
    } else {
      widget.animationController.forward();
    }
  }

  bool isDeleting = false;
  int indexOfAnimatedGrid = 0;

  @override
  void dispose() {
    print('dispose');
    widget.animationController.dispose();
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
              IconButton(onPressed: (){
                setState(() {
                  widget.sortedFavoritesCubit.loadCharactersWithoutFilter();

                });
              }, icon: Icon(Icons.update)),
              Expanded(
                child: AnimatedGrid(
                  key: gridKey,
                  initialItemCount: state.resultEntityList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.63,
                  ),
                  itemBuilder: (context, index, animation) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if(!isDeleting){
                          print('deleting');
                          if (gridKey.currentState != null) {
                            print('gridKey.currentState != null');
                            if(state.resultEntityList.length == index+1){
                              print('state.resultEntityList.length == index');
                              setState(() {
                                gridKey.currentState?.insertItem(index+1);
                                isDeleting = false;
                              });
                            }
                          }
                        }
                    });

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
                             _flipCard();
                              gridKey.currentState?.removeItem(index,
                                duration: const Duration(seconds: 1),
                                    (context, animation) {
                                  return MatrixTransition(
                                    animation:  widget.animationController,
                                    onTransform: (double value) {
                                      return Matrix4.identity()..setEntry(3, 2, 0.001)
                                        ..rotateY(pi * value);
                                    },
                                    child: ValueListenableBuilder<double>(
                                      valueListenable:  widget.animationController,
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
