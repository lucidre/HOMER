// ignore_for_file: use_build_context_synchronously

import 'package:homer/common_libs.dart';

class HomeTabBars extends StatelessWidget {
  const HomeTabBars({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: GetX<HomeController>(builder: (controller) {
        final previous = controller.selectedItem;
        return buildBody(previous);
      }),
    );
  }

  Row buildBody(String previous) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildTabBarItem('Living room', previous),
        horizontalSpacer16,
        buildTabBarItem('Kitchen', previous),
        horizontalSpacer16,
        buildTabBarItem('Bathroom', previous),
        horizontalSpacer16,
        buildTabBarItem('Bedroom', previous),
        horizontalSpacer16,
        buildTabBarItem('Garage', previous),
      ],
    );
  }

  Widget buildTabBarItem(String text, String previous) {
    final selected = text == previous;

    return GestureDetector(
      onTap: () => Get.find<HomeController>().setSelectedItem(text),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: satoshi500S16.copyWith(
              color: selected ? primaryColor : white,
              fontSize: 20,
            ),
          ),
          verticalSpacer4,
          AnimatedContainer(
            duration: slowDuration,
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? primaryColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
