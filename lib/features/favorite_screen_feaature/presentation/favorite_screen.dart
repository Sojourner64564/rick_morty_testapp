import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/core/injectable/injectable.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/favorite_page.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/sorted_favorites_cubit/sorted_favorites_cubit.dart';


@RoutePage()
class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  final sortedFavoritesCubit = getIt<SortedFavoritesCubit>();


  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _controller = TextEditingController();


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
                style: AppLightTextstyles.w700Text25,
              ),
              const SizedBox(height: 10),
              SearchBar(
                hintText: 'Sort by Name',
                controller: _controller,
                backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.secondary,),
                elevation: const WidgetStatePropertyAll<double>(2),
                onChanged: (String text){
                  widget.sortedFavoritesCubit.sortCharacters(text);
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
                    widget.sortedFavoritesCubit.loadCharactersWithoutFilter();
                    },
                    icon: const Icon(Icons.close),
                ),
                ]
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: FavoritePage(
          controller: _controller,
      ),
    );
  }
}
