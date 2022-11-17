import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedPizzaBox extends StatefulWidget {
  const AnimatedPizzaBox({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedPizzaBox> createState() =>
      _AnimatedPizzaBoxState();
}

class _AnimatedPizzaBoxState extends State<AnimatedPizzaBox>
    with SingleTickerProviderStateMixin {
  ///Variables
  late AnimationController controller;

  late Animation topBoxCoverfoldingAnimation;
  late Animation topBoxOpcaityAnimation;

  bool showPizzaBoxCover = false;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 370));
    topBoxCoverfoldingAnimation = Tween(begin: -.5, end: -2.6)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    topBoxOpcaityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    super.initState();
    controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Stack(
        children: [
          ///BottomBox
          Positioned(
            right: 10,
            bottom: 75,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .001)
                ..rotateX(-.5)
                ..scale(.4),
              child: Image.asset('assets/images/box_inside.png'),
            ),
          ),

          ///TopBox : inside
          Positioned(
            right: 10,
            bottom: 394,
            child: Transform.rotate(
              angle: pi,
              child: Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, .001)

                  /// Top lid folding-animation is done using[..rotateX]
                  //at - 1.6 the cover of the pizza shows
                  // at - 2.6 the cover closes and  is compeletly shown
                  ..rotateX(topBoxCoverfoldingAnimation.value)
                  ..scale(.38),
                child: Image.asset('assets/images/box_inside.png'),
              ),
            ),
          ),

          ///TopBox : PizzaHouseCover
          Positioned(
            right: 10,
            bottom: 440,
            child: GestureDetector(
              onTap: () {
                controller.forward();
              },
              child: Opacity(
                opacity: topBoxOpcaityAnimation.value,
                child: Transform.scale(
                  scaleY: 1.1,
                  child: Transform.rotate(
                    angle: pi,
                    child: Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, .001)

                        /// Top lid folding-animation is done using[..rotateX]
                        //at - 1.6 the cover of the pizza shows
                        // at - 2.6 the cover closes and  is compeletly shown
                        ..rotateX(topBoxCoverfoldingAnimation.value)
                        ..scale(
                          .38,
                        ),
                      child: Image.asset('assets/images/box_front.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
