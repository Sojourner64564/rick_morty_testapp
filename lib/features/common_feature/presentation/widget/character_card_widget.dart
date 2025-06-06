import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/core/assets/app_colors.dart';

class CharacterCardWidget extends StatelessWidget {
  const CharacterCardWidget({
    super.key,
    required this.onTap,
    required this.isFavorite,
  });
  final bool isFavorite;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.grey002,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/mock_images/mock_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'name',
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'name',
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'name',
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'name',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: !isFavorite,
              child: Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: onTap,
                  iconSize: 30,
                  icon: const Icon(
                    Icons.star_border_outlined,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isFavorite,
              child: Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: onTap,
                  iconSize: 30,
                  icon: const Icon(
                    Icons.star,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
