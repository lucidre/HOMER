import 'package:homer/common_libs.dart';
import 'package:homer/presenation/shapes/custom_shape.dart';
import 'package:homer/presenation/home/home_tab_bar.dart';
import 'package:homer/presenation/kitchen/kitchen.dart';
import 'package:homer/presenation/living_room/living_room.dart';

class HomeBottomBar extends StatefulWidget {
  final bool isMin;
  const HomeBottomBar({super.key, required this.isMin});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight,
      child: Stack(
        children: [
          buildBackground(),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: context.screenHeight,
              child: buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  CustomPaint buildBackground() {
    return CustomPaint(
      willChange: true,
      painter: CustomShape(
        isMin: widget.isMin,
      ),
      size: const Size(
        double.infinity,
        double.infinity,
      ),
    );
  }

  Widget buildBody() {
    return Container(
      padding: const EdgeInsets.all(space12),
      margin: const EdgeInsets.only(top: space12),
      child: Column(
        children: [
          if (!widget.isMin) ...buildDragBar() else verticalSpacer8,
          const HomeTabBars(key: ObjectKey('indicator')),
          verticalSpacer16,
          Expanded(
            child: GetX<HomeController>(builder: (controller) {
              final previous = controller.selectedItem;
              return previous.toLowerCase() == 'kitchen'
                  ? const KitchenBar()
                  : previous.toLowerCase() == 'living room'
                      ? const LivingRoom()
                      : const SizedBox();
            }),
          ),
          verticalSpacer32,
        ],
      ),
    );
  }

  List<Widget> buildDragBar() {
    return [
      verticalSpacer32,
      Container(
        width: 80,
        height: 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(space12),
          color: white.withOpacity(.6),
        ),
      ).fadeInAndMoveFromBottom(),
      verticalSpacer16,
    ];
  }
}
