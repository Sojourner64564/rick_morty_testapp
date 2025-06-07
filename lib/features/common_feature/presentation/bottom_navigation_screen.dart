import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/core/assets/app_colors.dart';
import 'package:rick_morty_testapp/core/route/app_router.dart';

@RoutePage()
class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      extendBody: true,
      routes: [
        MainRoute(),
        const FavoriteRoute(),
      ],
      animationDuration: const Duration(milliseconds: 150),
      bottomNavigationBuilder: (BuildContext context, TabsRouter tabRouter) {
        return BottomNavigationBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onTap: tabRouter.setActiveIndex,
          currentIndex: tabRouter.activeIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.paste_sharp,
                size: 35,
                color: AppLightColors.errorContainerColor,
              ),
              activeIcon: Icon(
                Icons.paste_sharp,
                size: 35,
                color: AppLightColors.tertiaryColor,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.rectangle_outlined,
                size: 35,
                color: AppLightColors.errorContainerColor,
              ),
              activeIcon: Icon(
                Icons.rectangle_outlined,
                size: 35,
                color: AppLightColors.tertiaryColor ,
              ),
            ),
          ],
        );
      },
    );
  }
}
