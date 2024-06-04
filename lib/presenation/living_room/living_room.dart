import 'package:flutter/cupertino.dart';
import 'package:homer/common_libs.dart';
import 'package:homer/presenation/home/widget/card_item.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({super.key});

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  Duration delayBuilder(
    int position, [
    int increment = 0,
  ]) =>
      Duration(
        milliseconds: (300 * position) + increment,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: buildRow1().fadeInAndMoveFromBottom(
            delay: delayBuilder(2),
          ),
        ),
        verticalSpacer12,
        Expanded(
          child: buildRow2().fadeInAndMoveFromBottom(
            delay: delayBuilder(3),
          ),
        ),
      ],
    );
  }

  Row buildRow2() {
    return Row(
      children: [
        const Expanded(
          child: CardItem(
            color: Colors.white,
            title: 'Cleaner',
            subtext: 'Cleaning: 100%',
            icon: CupertinoIcons.chart_bar_fill,
            image: cleaner,
            scale: 1.4,
          ),
        ),
        horizontalSpacer12,
        Expanded(
          child: CardItem(
            color: Colors.green[300]!,
            title: 'Camera',
            subtext: 'Active: 8 Devics',
            icon: CupertinoIcons.camera_viewfinder,
            image: camera,
            scale: 1.1,
          ),
        ),
      ],
    );
  }

  Row buildRow1() {
    return Row(
      children: [
        Expanded(
          child: CardItem(
            color: Colors.yellow[300]!,
            title: 'Home Pod',
            subtext: 'The weekend star...',
            icon: CupertinoIcons.music_note,
            image: homePod,
            scale: 1.1,
          ),
        ),
        horizontalSpacer12,
        Expanded(
          child: CardItem(
            color: Colors.red[300]!,
            title: 'Bed Lamp',
            subtext: 'Light: 3000 Kelvin.',
            icon: CupertinoIcons.light_max,
            image: lamp,
            scale: 1.2,
          ),
        ),
      ],
    );
  }
}
