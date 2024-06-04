// ignore_for_file: use_build_context_synchronously

import 'package:homer/common_libs.dart';
import 'package:homer/presenation/kitchen/widget/air_conditioner_widget.dart';

import 'package:homer/presenation/kitchen/widget/cleaner_widget.dart';
import 'package:homer/presenation/kitchen/widget/light_widget.dart';
import 'package:homer/presenation/kitchen/widget/speaker_widget.dart';

class KitchenBar extends StatefulWidget {
  const KitchenBar({super.key});

  @override
  State<KitchenBar> createState() => _KitchenBarState();
}

class _KitchenBarState extends State<KitchenBar> {
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
        const AirConditionerWidget()
            .fadeInAndMoveFromBottom(delay: delayBuilder(2)),
        verticalSpacer16,
        Expanded(
          child: Row(
            children: [
              Expanded(child: buildSecondDevices()),
              horizontalSpacer16,
              const LightWidget().fadeInAndMoveFromBottom(
                delay: delayBuilder(3, 500),
              ),
            ],
          ),
        ),
        verticalSpacer16,
      ],
    );
  }

  buildSecondDevices() {
    return Column(
      children: [
        Expanded(
          child: const CleanerWidget().fadeInAndMoveFromBottom(
            delay: delayBuilder(3),
          ),
        ),
        verticalSpacer16,
        Expanded(
          child: const SpeakerWidget().fadeInAndMoveFromBottom(
            delay: delayBuilder(4),
          ),
        )
      ],
    );
  }
}
