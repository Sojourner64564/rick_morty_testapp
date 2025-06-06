import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/core/assets/app_colors.dart';
import 'package:rick_morty_testapp/core/assets/app_textstyles.dart';
import 'package:rick_morty_testapp/features/main_screen_feature/domain/entity/result_entity.dart';

class CharacterCardWidget extends StatelessWidget {
  const CharacterCardWidget({
    super.key,
    required this.resultEntity,
    required this.onTap,
    required this.isFavorite,
  });
  final ResultEntity resultEntity;
  final bool isFavorite;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
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
                      child: Image.network(
                        resultEntity.image,
                        fit: BoxFit.cover,
                        loadingBuilder:
                            (buildContext, widget, imageChunkEvent) {
                          if (imageChunkEvent == null) {
                            return widget;
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (buildContext, object, stackTrace) {
                          return Container(
                            color: AppLightColors.errorContainerColor,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        resultEntity.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppLightTextstyles.w700Text20,
                      ),
                      Text.rich(
                        maxLines: 1,
                        TextSpan(children: [
                          const TextSpan(
                            text: 'Status: ',
                            style: AppLightTextstyles.w300Text17,
                          ),
                          TextSpan(
                            text: resultEntity.status,
                            style: AppLightTextstyles.w300Text17Grey,
                          ),
                        ]),
                      ),
                      Text.rich(
                        maxLines: 1,
                        TextSpan(children: [
                          const TextSpan(
                            text: 'Species: ',
                            style: AppLightTextstyles.w300Text17,
                          ),
                          TextSpan(
                            text: resultEntity.species,
                            style: AppLightTextstyles.w300Text17Grey,
                          ),
                        ]),
                      ),
                      Text.rich(
                        maxLines: 2,
                        TextSpan(
                            children: [
                          const TextSpan(
                            text: 'Location: ',
                            style: AppLightTextstyles.w300Text17,
                          ),
                          TextSpan(
                            text: resultEntity.location.name,
                            style: AppLightTextstyles.w300Text17Grey,
                          ),
                        ]),
                      ),

                   /*   RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Status: ',
                            style: AppLightTextstyles.w300Text17,
                          ),
                          TextSpan(
                            text: resultEntity.status,
                            style: AppLightTextstyles.w300Text17Grey,
                          ),
                        ]),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Species: ',
                            style: AppLightTextstyles.w300Text17,
                          ),
                          TextSpan(
                            text: resultEntity.species,
                            style: AppLightTextstyles.w300Text17Grey,
                          ),
                        ]),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Location: ',
                            style: AppLightTextstyles.w300Text17,
                          ),
                          TextSpan(
                            text: resultEntity.location.name,
                            style: AppLightTextstyles.w300Text17Grey,
                          ),
                        ]),
                      ),*/

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
                    color: AppLightColors.blackColor,
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
                    color: AppLightColors.tertiaryColor,
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
