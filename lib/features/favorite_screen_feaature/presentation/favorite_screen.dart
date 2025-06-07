import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/core/assets/app_colors.dart';
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/features/favorite_screen_feaature/presentation/favorite_page.dart';


@RoutePage()
class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final controller = TextEditingController();

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
                controller: controller,
                onChanged: (String text){
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
                    controller.clear();
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
      body: FavoritePage(controller: controller),
    );
  }
}
