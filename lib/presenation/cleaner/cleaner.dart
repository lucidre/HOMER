import 'package:homer/common_libs.dart';
import 'package:homer/presenation/cleaner/timer_count_down.dart';

@RoutePage()
class CleanerScreen extends StatefulWidget {
  const CleanerScreen({super.key});

  @override
  State<CleanerScreen> createState() => _CleanerScreenState();
}

class _CleanerScreenState extends State<CleanerScreen> {
  final GlobalKey key = GlobalKey();
  bool hasSetvalue = false;
  Duration delayBuilder(
    int position, [
    int increment = 0,
  ]) {
    return Duration(milliseconds: (300 * position) + increment);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppHero(
          tag: 'Cleaner',
          child: Container(
            width: context.screenWidth,
            height: context.screenHeight,
            color: primaryColor,
          ),
        ),
        AppScaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(),
          body: buildBody(),
        ),
      ],
    );
  }

  buildBody() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: buildItem1().fadeInAndMoveFromBottom(delay: delayBuilder(1)),
        ),
        Positioned(
          top: space32 * 4,
          right: -space16,
          child: Transform.scale(
            scale: 1.15,
            alignment: Alignment.centerLeft,
            child: Image.asset(
              cleaner,
              width: context.screenWidth,
              height: context.screenWidth,
              fit: BoxFit.contain,
            ),
          ).fadeInAndMoveFromBottom(delay: delayBuilder(2)),
        ),
        Positioned(
          bottom: space32 * 7,
          right: 0,
          left: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(space12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(space12),
                color: white,
              ),
              child: GetX<HomeController>(builder: (controller) {
                final totalSeconds = controller.cleanerTimeLeft;
                return TimerCountDown2(
                  key: ObjectKey(controller.cleanerKeyValue),
                  totalSeconds: totalSeconds,
                );
              }),
            ),
          ).fadeInAndMoveFromBottom(delay: delayBuilder(2)),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: buildItem2(),
        ),
      ],
    );
  }

  Padding buildItem2() {
    return Padding(
      padding: const EdgeInsets.all(space16),
      child: Column(
        children: [
          buildProgressText().fadeInAndMoveFromBottom(delay: delayBuilder(3)),
          verticalSpacer8,
          buildProgressBar().fadeInAndMoveFromBottom(delay: delayBuilder(4)),
          verticalSpacer16,
          buildToggleSessionButton()
              .fadeInAndMoveFromBottom(delay: delayBuilder(5)),
          verticalSpacer16,
        ],
      ),
    );
  }

  Row buildProgressText() {
    return Row(
      children: [
        Text('Cleaning Progress', style: satoshi500S24),
        const Spacer(),
        GetX<HomeController>(builder: (controller) {
          return Text(
            '${controller.cleanerPercentage} %',
            style: satoshi700S24.copyWith(
              color: primaryColorGrey,
            ),
          );
        }),
      ],
    );
  }

  Widget buildProgressBar() {
    return LayoutBuilder(builder: (_, constraint) {
      final width = constraint.maxWidth;
      return GetX<HomeController>(builder: (controller) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: 3,
              decoration: BoxDecoration(
                color: primaryColorGrey,
                borderRadius: BorderRadius.circular(space16),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: slowDuration,
                width: controller.cleanerPercentage * width / 100,
                height: 3,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(space16),
                ),
              ),
            ),
          ],
        );
      });
    });
  }

  onVerticalDragUpdate(
      DragUpdateDetails details, HomeController controller, double width) {
    final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;

    final offsetGeneral = box.localToGlobal(Offset.zero).dx;
    final positionMouse = details.globalPosition.dx;

    // The differrence between the mouse position and the x position of the total container.
    final differnce = positionMouse - offsetGeneral;

    final cleanerPreviousDifference = controller.cleanerDifference;

    final percentage = differnce / width;
    final maxAllocatableWidth = width - 60;
    final value = controller.cleanerSwitch;
    final check1 =
        value && percentage > 0.5 && differnce > cleanerPreviousDifference;
    final check2 =
        !value && percentage < 0.49 && differnce < cleanerPreviousDifference;
    final check3 = (!value && cleanerPreviousDifference < differnce) ||
        (value && cleanerPreviousDifference > differnce);

    if (check1) {
      controller.setCleanerDifference(maxAllocatableWidth);
      controller.setCleanerSwitch(false);
    } else if (check2) {
      controller.setCleanerDifference(0);
      controller.setCleanerSwitch(true);
    } else if (check3) {
      controller.setCleanerDifference(differnce.clamp(0, maxAllocatableWidth));
    }
  }

  updateWidth(HomeController controller, double width) {
    if (!hasSetvalue) {
      Future.delayed(const Duration(seconds: 1), () {
        controller.setTotalCleanerButtonWidth(width);
      });

      hasSetvalue = true;
    }
  }

  Widget buildToggleSessionButton() {
    return Container(
      key: key,
      padding: const EdgeInsets.all(space8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space12),
        color: const Color(0xFF1C0906),
      ),
      child: LayoutBuilder(builder: (_, constraint) {
        final width = constraint.maxWidth;

        return GetX<HomeController>(builder: (controller) {
          updateWidth(controller, width);

          return GestureDetector(
            onVerticalDragUpdate: (details) =>
                onVerticalDragUpdate(details, controller, width),
            child: Stack(
              children: [
                buildSliderBackground(controller),
                AnimatedPositioned(
                  duration: fastDuration,
                  left: controller.cleanerDifference,
                  top: 0,
                  bottom: 0,
                  child: buildSliderItem(controller),
                ),
              ],
            ),
          );
        });
      }),
    );
  }

  buildSliderBackground(HomeController controller) {
    final value = controller.cleanerSwitch;
    return Row(
      children: [
        AnimatedOpacity(
          duration: medDuration,
          opacity: !controller.cleanerSwitch ? 1 : 0,
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: const Icon(
              Icons.keyboard_double_arrow_left_rounded,
              color: white,
              size: 30,
            ),
          ),
        ),
        const Spacer(),
        Text(
          '${value ? 'Stop' : 'Start'} Session',
          style: satoshi500S24.copyWith(
            fontSize: 20,
          ),
        ),
        const Spacer(),
        AnimatedOpacity(
          duration: medDuration,
          opacity: controller.cleanerSwitch ? 1 : 0,
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: const Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  buildSliderItem(HomeController controller) {
    final value = controller.cleanerSwitch;
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space12),
        color: primaryColor,
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(space12),
          color: white,
        ),
        child: Icon(
          !value ? Icons.power_rounded : Icons.close_rounded,
          color: primaryColor,
          size: 30,
        ),
      ),
    );
  }

  Padding buildItem1() {
    return Padding(
      padding: const EdgeInsets.all(space16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Robotic\nCleaner',
            style: satoshi700S24.copyWith(
              fontSize: 50,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          GetX<HomeController>(builder: (controller) {
            final width = controller.totalCleanerButtonWidth - 60;
            final value = controller.cleanerSwitch;
            return Switch.adaptive(
              value: value,
              onChanged: (value) {
                controller.setCleanerSwitch(value);
                if (value) {
                  controller.setCleanerDifference(0);
                } else {
                  controller.setCleanerDifference(width);
                }
              },
              thumbColor: MaterialStateProperty.all(primaryColor),
              activeTrackColor: white,
              inactiveThumbColor: white,
              inactiveTrackColor: white,
            );
          })
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leading: null,
      automaticallyImplyLeading: false,
      title: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          context.router.maybePop();
        },
        child: Container(
          padding: const EdgeInsets.all(space8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(space12),
            color: primaryColorGrey,
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: white,
          ),
        ),
      ).fadeInAndMoveFromBottom(),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: space16),
          padding: const EdgeInsets.all(space8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(space12),
            color: primaryColorGrey,
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
