import 'package:flutter/material.dart';

import 'dart:math';

class AnimatedPizzaBox extends StatefulWidget {
  const AnimatedPizzaBox({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedPizzaBox> createState() => _AnimatedPizzaBoxState();
}

class _AnimatedPizzaBoxState extends State<AnimatedPizzaBox>
    with TickerProviderStateMixin {
  ///Animation Controllers
  late AnimationController animationController;

  ///Animations : these are set in sequence folding first, opacity second...and so on
  late Animation topLidfoldingAnimation;
  late Animation topLidOpcaityAnimation;
  late Animation scalingUpBoxAnimation;
  late Animation scalingDownBoxAnimation;
  late Animation translatingUpwardsBoxAnimation;
  late Animation translatingSideWayBoxAnimation;

  @override
  void initState() {
    ///Animation Controllers
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    ///Animations
    //the box scaling up
    scalingUpBoxAnimation = Tween(begin: 0.0, end: .6).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, .6, curve: Curves.ease)));
    //the lid of the box folding
    topLidfoldingAnimation = Tween(begin: -.5, end: -2.6).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(.6, .75, curve: Curves.ease)));
    topLidOpcaityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(.6, .75, curve: Curves.ease)));
    // the box shrinking in size
    scalingDownBoxAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(.75, 1, curve: Curves.easeInExpo)));
    // the box Moving towards the cart
    translatingUpwardsBoxAnimation = Tween(begin: -120.0, end: -1500.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(.75, 1, curve: Curves.easeInExpo)));
    translatingSideWayBoxAnimation = Tween(begin: 0.0, end: 900.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: const Interval(.75, 1, curve: Curves.easeInExpo)));
    super.initState();
    animationController.addListener(() {});
    animationController.addStatusListener((status) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 226, 226),
        body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Stack(
            children: [
              Positioned.fill(
                bottom: 12,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 64,
                    width: MediaQuery.of(context).size.width * .9,
                    child: RawMaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () => animationController.forward(),
                      fillColor: Colors.black,
                      child: Center(
                          child: Text(
                        'اضف الى العربة',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                    ),
                  ),
                ),
              ),

              ///PizzBox
              Opacity(
                opacity: scalingDownBoxAnimation.value,
                child: Transform.scale(
                  scale: scalingDownBoxAnimation.value,
                  child: Transform.translate(
                    offset: Offset(translatingSideWayBoxAnimation.value,
                        translatingUpwardsBoxAnimation.value),
                    child: Transform.scale(
                      scale: scalingUpBoxAnimation.value,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          ///BottomBox
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Transform.scale(
                              scale: .6,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, .001)
                                  ..rotateX(-.5),
                                child: Image.network(
                                  'https://raw.githubusercontent.com/MujtabaMuneer01/pizzaboxanimation/main/box_inside.png',
                                ),
                              ),
                            ),
                          ),

                          ///TopBox : inside
                          Positioned(
                            bottom: 147,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Transform.rotate(
                                angle: pi,
                                child: Transform.scale(
                                  scaleX: .45,
                                  scaleY: .4,
                                  child: Transform(
                                    alignment: Alignment.topCenter,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, .001)

                                      /// Top lid folding-animation is done using[..rotateX]
                                      //at - 1.6 the cover of the pizza shows
                                      // at - 2.6 the cover closes and  is compeletly shown
                                      ..rotateX(topLidfoldingAnimation.value),
                                    child: Image.network(
                                      'https://raw.githubusercontent.com/MujtabaMuneer01/pizzaboxanimation/main/box_inside.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///TopBox : PizzaHouseCover
                          Positioned(
                            bottom: 147,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Opacity(
                                opacity: topLidOpcaityAnimation.value,
                                child: Transform.scale(
                                  scaleX: .45,
                                  scaleY: .4,
                                  child: Transform.rotate(
                                    angle: pi,
                                    child: Transform(
                                      alignment: Alignment.topCenter,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, .001)

                                        /// Top lid folding-animation is done using[..rotateX]
                                        //at - 1.6 the cover of the pizza shows
                                        // at - 2.6 the cover closes and  is compeletly shown
                                        ..rotateX(topLidfoldingAnimation.value),
                                      child: Image.network(
                                        'https://raw.githubusercontent.com/MujtabaMuneer01/pizzaboxanimation/main/box_front.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
