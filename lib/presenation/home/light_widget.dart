// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:homer/common_libs.dart';

class LightWidget extends StatefulWidget {
  const LightWidget({super.key});

  @override
  State<LightWidget> createState() => _LightWidgetState();
}

class _LightWidgetState extends State<LightWidget> {
  final GlobalKey key = GlobalKey();

  /// gets the start offset of the widget and subtract the position of the mouse from it.
  /// then the difference is used to determine where the slider should be.
  onVerticalDragUpdate(DragUpdateDetails details, double maxHeight) {
    final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;

    final offsetGeneral = box.localToGlobal(Offset.zero).dy;
    final positionMouse = details.globalPosition.dy;

    final differnce = positionMouse - offsetGeneral;

    final controller = Get.find<HomeController>();

    // get the difference in percentage of the max container height.
    double newValue = (maxHeight - differnce) * 100 / maxHeight;
    newValue = newValue.clamp(0, 100);
    controller.seLightPercentage(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraint) {
      final maxHeight = constraint.maxHeight;
      return GestureDetector(
        key: key,
        onVerticalDragUpdate: (details) =>
            onVerticalDragUpdate(details, maxHeight),
        child: Container(
            width: 80,
            height: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(space12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: blackGradient,
              ),
            ),
            child: SizedBox(
              height: maxHeight,
              child: Stack(
                children: [
                  buildDragger(maxHeight),
                  buildBulb(),
                ],
              ),
            )),
      );
    });
  }

  buildDragger(double maxHeight) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: maxHeight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GetX<HomeController>(builder: (controller) {
          final percentage = controller.lightPercentage;
          return Container(
            height: percentage * maxHeight / 100,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: const EdgeInsets.all(space8),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(space12),
                color: primaryColor),
            child: Container(
              width: double.infinity,
              height: 3,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(space16),
              ),
            ),
          );
        }),
      ),
    );
  }

  buildBulb() {
    return Positioned(
      left: space16,
      right: space16,
      top: space16,
      child: Column(
        children: [
          const Icon(
            Icons.lightbulb_rounded,
            color: white,
            size: 45,
          ),
          verticalSpacer8,
          GetX<HomeController>(builder: (controller) {
            final percentage = controller.lightPercentage;

            return Text(
              '${percentage.toStringAsFixed(0)}%',
              style: satoshi700S24.copyWith(fontSize: 20),
            );
          }),
        ],
      ),
    );
  }
}
