import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:homer/common_libs.dart';
import 'package:homer/presenation/home/home_body.dart';
import 'package:homer/presenation/home/home_bottom_bar.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  int selectedPosition = 0;
  bool isMin = true;
  bool isHide = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: fastDuration,
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    if (velocity < 0 && isMin) {
      isMin = false;
      controller.reset();
      controller.forward();
    } else if (velocity > 0 && !isMin) {
      isMin = true;
      controller.reset();
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: black,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!isHide) {
                isHide = true;
                setState(() {});
              }
            },
            child: const HomeBody(),
          ),
          AnimatedPositioned(
            duration: fastDuration,
            bottom: isHide ? -context.screenHeight * .55 : 0,
            top: 0,
            right: 0,
            left: 0,
            child: buildBody(),
          ),
          Positioned(
            bottom: space32 + space8,
            right: 0,
            left: 0,
            child: buildBottomBar(),
          ),
        ],
      ),
    );
  }

  Widget bottomBarItem(IconData icon, int position) {
    bool selected = selectedPosition == position;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPosition = position;
        });
      },
      child: AnimatedContainer(
        duration: fastDuration,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? white.withOpacity(.4) : Colors.transparent,
          ),
        ),
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.only(
          left: space24,
          right: space24,
        ),
        child: AnimatedContainer(
          duration: fastDuration,
          padding: const EdgeInsets.all(space8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? white : Colors.transparent,
          ),
          child: Icon(
            icon,
            color: selected ? black : white,
          ),
        ),
      ),
    );
  }

  Widget buildBottomBar() {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final value = Curves.decelerate.transform(controller.value);
          return Opacity(
            opacity: isMin ? value : 1 - value,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(space32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                      tileMode: TileMode.mirror,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: space16,
                        right: space16,
                        top: space8,
                        bottom: space8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(space32),
                        color: black.withOpacity(.3),
                        border: Border.all(
                          color: white.withOpacity(.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          bottomBarItem(CupertinoIcons.app_badge_fill, -1),
                          bottomBarItem(CupertinoIcons.house_fill, 0),
                          bottomBarItem(CupertinoIcons.tray_full_fill, 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ).fadeInAndMoveFromBottom(delay: slowDuration),
              if (isHide) horizontalSpacer8,
              buildExpandButton()
            ]),
          );
        });
  }

  AnimatedSwitcher buildExpandButton() {
    return AnimatedSwitcher(
      duration: fastDuration,
      child: !isHide
          ? const SizedBox()
          : ClipRRect(
              borderRadius: BorderRadius.circular(space32),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                  tileMode: TileMode.mirror,
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    left: space8,
                    right: space8,
                    top: space8,
                    bottom: space8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(space32),
                    color: black.withOpacity(.3),
                    border: Border.all(
                      color: white.withOpacity(.4),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (isHide) {
                        isHide = false;
                        setState(() {});
                      }
                    },
                    child: AnimatedContainer(
                      duration: fastDuration,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      padding: const EdgeInsets.all(space8 + 2),
                      child: const Icon(
                        CupertinoIcons.arrow_up_square_fill,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildBody() {
    const min = .55;
    const minReverse = 1 - min;
    return AnimatedOpacity(
      duration: fastDuration,
      opacity: isHide ? 0 : 1,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final transformedHeight =
              Curves.decelerate.transform(controller.value);
          final progress =
              context.screenHeight * minReverse * transformedHeight;
          final height = isMin
              ? context.screenHeight - progress
              : (context.screenHeight * min) + progress;
          return GestureDetector(
            onVerticalDragEnd: handleDragEnd,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: height,
                child: HomeBottomBar(
                  isMin: isMin,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
