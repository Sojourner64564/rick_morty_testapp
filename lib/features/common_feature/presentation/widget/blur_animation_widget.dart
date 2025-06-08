import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

/// Виджет с анимацией сжимания и пролета в сторону
class BlurAnimationWidget extends StatefulWidget {
  const BlurAnimationWidget(
      {super.key,
      required this.child,
      required this.animateWidget,
        required this.controller, required this.hideWidget,
      });

  final Widget child;
  final bool animateWidget;
  final AnimationController controller;

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
    widget.controller.addListener(listener);
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 0.1),
    ]).animate(widget.controller);

    _positionAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -1.5), weight: 1),
    ]).animate(widget.controller);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        widget.child,

        if (widget.animateWidget)
          Visibility(
            visible: widget.hideWidget,
            child: Transform.translate(
              offset: Offset(_positionAnimation.value * -screenWidth, 0),
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

