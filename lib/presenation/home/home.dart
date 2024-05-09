// ignore_for_file: use_build_context_synchronously

import 'package:homer/common_libs.dart';
import 'package:homer/presenation/home/air_conditioner_widget.dart';
import 'package:homer/presenation/home/cleaner_widget.dart';
import 'package:homer/presenation/home/home_tab_bars.dart';
import 'package:homer/presenation/home/light_widget.dart';
import 'package:homer/presenation/home/speaker_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// this helps build the animation fading in one after the other.
  /// The time is set such that the next animation would fade in while
  /// the current one is close to ending its animatiuno
  Duration delayBuilder(
    int position, [
    int increment = 0,
  ]) {
    return Duration(milliseconds: (300 * position) + increment);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: backgroundGradient,
        ),
      ),
      child: AppScaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(space16),
      child: Column(
        children: [
          const HomeTabBars().fadeInAndMoveFromBottom(delay: delayBuilder(1)),
          verticalSpacer16,
          const AirConditionerWidget()
              .fadeInAndMoveFromBottom(delay: delayBuilder(2)),
          verticalSpacer16,
          Expanded(
            child: Row(
              children: [
                Expanded(child: buildSecondDevices()),
                horizontalSpacer16,
                const LightWidget()
                    .fadeInAndMoveFromBottom(delay: delayBuilder(3, 500)),
              ],
            ),
          ),
          verticalSpacer16,
        ],
      ),
    );
  }

  buildSecondDevices() {
    return Column(
      children: [
        Expanded(
          child: const CleanerWidget()
              .fadeInAndMoveFromBottom(delay: delayBuilder(3)),
        ),
        verticalSpacer16,
        Expanded(
          child: const SpeakerWidget()
              .fadeInAndMoveFromBottom(delay: delayBuilder(4)),
        )
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leading: null,
      title: Row(
        children: [
          const Icon(
            Icons.view_in_ar_outlined,
            color: white,
          ),
          horizontalSpacer8,
          Text(
            'HOMER',
            style: satoshi700S24.copyWith(color: white),
          ),
        ],
      ).fadeInAndMoveFromBottom(),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: space16),
          padding: const EdgeInsets.all(space8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(space12),
            color: grey,
          ),
          child: const Icon(
            Icons.dashboard_rounded,
            color: white,
          ),
        ).fadeInAndMoveFromBottom()
      ],
    );
  }
}
