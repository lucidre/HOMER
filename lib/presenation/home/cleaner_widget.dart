// ignore_for_file: use_build_context_synchronously

import 'package:homer/common_libs.dart';

class CleanerWidget extends StatefulWidget {
  const CleanerWidget({super.key});

  @override
  State<CleanerWidget> createState() => _CleanerWidgetState();
}

class _CleanerWidgetState extends State<CleanerWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().simulateCleaner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(const CleanerRoute());
      },
      child: LayoutBuilder(builder: (_, constraint) {
        final height = constraint.maxHeight;
        return Container(
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(space12),
            color: primaryColor,
          ),
          child: Stack(
            children: [
              AppHero(
                tag: 'Cleaner',
                child: Container(
                  width: double.infinity,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(space12),
                    color: primaryColor,
                  ),
                ),
              ),
              buildImage(),
              buildTexts(),
            ],
          ),
        );
      }),
    );
  }

  buildImage() {
    return Positioned(
      bottom: -space24,
      right: -space24,
      child: Transform.scale(
        scale: 1.2,
        child: Image.asset(
          cleaner,
          height: 200,
        ),
      ),
    );
  }

  buildTexts() {
    return Padding(
      padding: const EdgeInsets.all(space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Robotic Cleaner',
            style: satoshi700S16,
          ),
          verticalSpacer4,
          Text(
            'LGS13RW',
            style: satoshi700S12.copyWith(color: primaryColorGrey),
          ),
          const Spacer(),
          buildPercentage(),
        ],
      ),
    );
  }

  buildPercentage() {
    return GetX<HomeController>(builder: (controller) {
      final percentage = controller.cleanerPercentage;
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: 3,
              valueColor: const AlwaysStoppedAnimation<Color>(white),
              backgroundColor: primaryColorGrey,
            ),
          ),
          Text(
            '$percentage%',
            style: satoshi700S24.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      );
    });
  }
}
