import 'package:flutter/cupertino.dart';

import 'package:homer/common_libs.dart';
import 'package:homer/presenation/home/widget/home_body_item.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Duration delayBuilder(
    int position, [
    int increment = 0,
  ]) {
    return Duration(milliseconds: (300 * position) + increment);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Stack(
        children: [
          buildDecore(),
          SafeArea(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(space16),
              ),
              margin: const EdgeInsets.only(
                left: space12,
                right: space12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAppBar(),
                  verticalSpacer16,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: buildBody(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildBody() {
    return Column(
      children: [
        HomeBodyItem(
          description: 'Electric Usage (1-7 Nov)',
          icon: CupertinoIcons.bolt_fill,
          colors: [
            Colors.green[900]!,
            Colors.green[800]!,
            Colors.green[700]!,
            Colors.green,
          ],
          lottie: powerLottie,
          text1: '790',
          text2: 'kwh',
        ).fadeInAndMoveFromBottom(delay: delayBuilder(1)),
        verticalSpacer16,
        HomeBodyItem(
          description: 'Device Timelapse (1-7 Nov)',
          icon: CupertinoIcons.timelapse,
          colors: [
            Colors.purple[900]!,
            Colors.purple[800]!,
            Colors.purple[700]!,
            Colors.purple,
          ],
          lottie: timelineLottie,
          text1: '800+',
          text2: 'hours',
        ).fadeInAndMoveFromBottom(delay: delayBuilder(2)),
        verticalSpacer16,
        HomeBodyItem(
          description: 'Billing Chart (1-7 Nov)',
          icon: CupertinoIcons.chart_bar_alt_fill,
          colors: [
            Colors.blue[900]!,
            Colors.blue[800]!,
            Colors.blue[700]!,
            Colors.blue,
          ],
          lottie: costLottie,
          text1: '100',
          text2: 'dollars',
        ).fadeInAndMoveFromBottom(delay: delayBuilder(3)),
        verticalSpacer16 * 3,
      ],
    );
  }

  Positioned buildDecore() {
    return Positioned(
      top: -space32 * 1.2,
      right: -space32 * 1.2,
      child: Opacity(
        opacity: 0.6,
        child: Image.asset(
          decore,
          height: 400,
          width: 400,
        ),
      ).fadeIn(),
    );
  }

  Row buildAppBar() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue[200],
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
        ),
        Transform.translate(
          offset: const Offset(-10, 0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: black,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  sun,
                  width: 35,
                  height: 35,
                ),
                horizontalSpacer8,
                Text(
                  '24°',
                  style: satoshi700S24.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Today,',
                  style: satoshi500S14,
                ),
                Text(
                  ' 07 Nov 2023',
                  style: satoshi500S14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                horizontalSpacer8,
                const Icon(
                  CupertinoIcons.chevron_down,
                  color: black,
                  size: 14,
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
