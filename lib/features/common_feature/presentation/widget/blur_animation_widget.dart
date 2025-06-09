import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

/// Виджет с анимацией сжимания и пролета в сторону
/// Обязательно должен быть поставлен флаг [animateToRight] или [animateToLeft],
/// чтобы виджет знал в какую сторону смещать анимацией виджет
class BlurAnimationWidget extends StatefulWidget {
  const BlurAnimationWidget({
    super.key,
    required this.animateWidget,
    required this.animationController,
    required this.hideWidget,
    required this.edgeInsetsGeometry,
    this.animateToRight,
    this.animateToLeft,
    required this.child,
  });

  final Widget child;
  final bool animateWidget;
  final AnimationController animationController;
  final bool? animateToRight;
  final bool? animateToLeft;
  final bool hideWidget;
  final EdgeInsetsGeometry edgeInsetsGeometry;

  @override
  State<BlurAnimationWidget> createState() => _BlurAnimationWidgetState();
}

class _BlurAnimationWidgetState extends State<BlurAnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<double> _positionAnimation;
  late OverlayPortalController overlayPortalController;
  final _link = LayerLink();

  void listener() {
    setState(() {});
  }

  @override
  void initState() {
    widget.animationController.addListener(listener);

    overlayPortalController = OverlayPortalController();
    _scaleAnimation =
        Tween(begin: 1.0, end: 0.0).animate(widget.animationController);
    _positionAnimation =
        Tween(begin: 0.0, end: -1.0).animate(widget.animationController);

    overlayPortalController.show();

    super.initState();
  }

  @override
  void dispose() {
    widget.animationController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build blur');
    final screenWidth = MediaQuery.of(context).size.width;
    // Анимация должна быть либо влево либо вправо
    assert(widget.animateToLeft != widget.animateToRight);
    assert(!(widget.animateToLeft == null && widget.animateToRight == null));

    final signForScreenWidth =
        screenWidth * (widget.animateToLeft == null ? -1 : 1);

    return Stack(
      children: [
        widget.child,

          if (widget.animateWidget)
            Positioned.fill(
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return CompositedTransformTarget(
                  link: _link,
                  child: OverlayPortal(
                    controller: overlayPortalController,
                    overlayChildBuilder: (BuildContext context) {
                      return CompositedTransformFollower(
                        link: _link,
                        targetAnchor: Alignment.center,
                        followerAnchor: Alignment.center,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: widget.edgeInsetsGeometry,
                            child: SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              child: Transform.translate(
                                offset: Offset(
                                    _positionAnimation.value *
                                        signForScreenWidth,
                                    0),
                                child: Transform.scale(
                                  scaleY: _scaleAnimation.value,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: BackdropFilter.grouped(
                                      filter: ImageFilter.blur(
                                        sigmaX: 20,
                                        sigmaY: 20,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
      ],
    );
  }
}
