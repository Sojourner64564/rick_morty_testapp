import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/core/assets/app_colors.dart';
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/core/injectable/injectable.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/favorite_page.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/sorted_favorites_cubit/sorted_favorites_cubit.dart';


@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _controller = TextEditingController();

  final sortedFavoritesCubit = getIt<SortedFavoritesCubit>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          toolbarHeight: 120,
          centerTitle: true,
          title: Column(
            children: [
              const Text(
                'Favorites Characters',
                style: AppTextstyles.w700Text25Black,
              ),
              const SizedBox(height: 10),
              SearchBar(
                hintText: 'Sort by Name',
                controller: _controller,
                onChanged: (String text){
                  sortedFavoritesCubit.sortCharacters(text);
                },
                leading: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                      Icons.search,
                    size: 30,
                  ),
                ),
                trailing: [
                  IconButton(
                    onPressed: (){
                    _controller.clear();
                    sortedFavoritesCubit.loadCharactersWithoutFilter();
                    },
                    icon: const Icon(Icons.close),
                ),
                ]
              ),
            ],
          ),
          backgroundColor: AppColors.blueColor,
        ),
      ),
      body: FavoritePage(controller: _controller),
    );
  }
}
