import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

/// Виджет с анимацией сжимания и пролета в сторону
/// Обязательно должен быть поставлен флаг [animateToRight] или [animateToLeft],
/// чтобы виджет знал в какую сторону смещать анимацией виджет
class BlurAnimationWidget extends StatefulWidget {
  const BlurAnimationWidget({super.key,
      required this.child,
      required this.animateWidget,
        required this.animationController,
    required this.hideWidget,
     this.animateToRight,
     this.animateToLeft,
      });

  final Widget child;
  final bool animateWidget;
  final AnimationController animationController;
  final bool? animateToRight;
  final bool? animateToLeft;

  final bool hideWidget;

  @override
  State<BlurAnimationWidget> createState() => _BlurAnimationWidgetState();
}

class _BlurAnimationWidgetState extends State<BlurAnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late Animation<double> _positionAnimation;


  void listener() {
    setState(() {});
  }


  @override
  void initState() {
    widget.animationController.addListener(listener);
    _scaleAnimation = Tween(begin: 1.0, end: 0.0).animate(widget.animationController);

    _positionAnimation = Tween( begin: 0.0, end: -1.5).animate(widget.animationController);
    super.initState();
  }

  @override
  void dispose() {
    widget.animationController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Анимация должна быть либо влево либо вправо
    print(widget.animateToLeft != widget.animateToRight);
    assert(widget.animateToLeft != widget.animateToRight);
    assert(!(widget.animateToLeft == null && widget.animateToRight == null));

    final signForScreenWidth = screenWidth * (widget.animateToLeft==null  ? -1 : 1);


    return Stack(
      children: [
        widget.child,

        if (widget.animateWidget)
          Visibility(
            visible: widget.hideWidget,
            child: Transform.translate(
              offset: Offset(_positionAnimation.value * signForScreenWidth, 0),
              child: Transform.scale(
                scaleY: _scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter.grouped(
                      filter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                      ),
                    child: SizedBox.expand(
                      child: Center(
                        child: Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.tertiary,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

