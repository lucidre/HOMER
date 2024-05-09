// ignore_for_file: use_build_context_synchronously

import 'package:homer/common_libs.dart';

class SpeakerWidget extends StatelessWidget {
  const SpeakerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: blackGradient,
        ),
      ),
      child: Stack(
        children: [
          buildImage(),
          buildText(),
        ],
      ),
    );
  }

  buildText() {
    return Padding(
      padding: const EdgeInsets.all(space16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Speaker',
                      style: satoshi700S16,
                    ),
                    verticalSpacer4,
                    Text(
                      'TYS12EQ',
                      style: satoshi700S12.copyWith(color: grey),
                    ),
                  ],
                ),
              ),
              horizontalSpacer8,
              GetX<HomeController>(builder: (controller) {
                final value = controller.speakerSwitch;
                return Switch.adaptive(
                  value: value,
                  onChanged: (value) => controller.setSpeakerSwitch(value),
                  activeColor: primaryColor,
                );
              })
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Positioned buildImage() {
    return Positioned(
      bottom: -space32 * 2,
      right: -space16,
      child: Transform.scale(
        scale: 1.4,
        child: Image.asset(
          speaker,
          height: 200,
        ),
      ),
    );
  }
}
