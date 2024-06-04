import 'package:homer/common_libs.dart';

class AirConditionerWidget extends StatefulWidget {
  const AirConditionerWidget({super.key});

  @override
  State<AirConditionerWidget> createState() => _AirConditionerWidgetState();
}

class _AirConditionerWidgetState extends State<AirConditionerWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().simulateAirConditioner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: blackGradient,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          buildImage(),
          buildBody(),
        ],
      ),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(space16),
      child: Column(
        children: [
          buildItem(),
          const Spacer(),
          buildItem2(),
        ],
      ),
    );
  }

  buildItem2() {
    return GetX<HomeController>(builder: (controller) {
      final temperature = controller.airConditionerValue;
      return Row(
        children: [
          Text(
            '${temperature.toStringAsFixed(2)}°',
            style: satoshi700S32.copyWith(
              fontSize: 70,
              fontWeight: FontWeight.normal,
              color: white,
            ),
          ),
          const Spacer(),
          buildDecreaseButton(controller),
          horizontalSpacer8,
          buildIncreaseButton(controller),
        ],
      );
    });
  }

  buildIncreaseButton(HomeController controller) {
    final temperature = controller.airConditionerValue;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (temperature < 30) {
          AppHaptics.heavyImpact();
          controller.setAirConditionerValue(temperature + 1);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(space16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: grey),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: blackGradient2,
          ),
        ),
        child: Icon(
          Icons.add_rounded,
          color: white.withOpacity(
            temperature > 30 ? .5 : 1,
          ),
          size: 26,
        ),
      ),
    );
  }

  InkWell buildDecreaseButton(HomeController controller) {
    final temperature = controller.airConditionerValue;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (temperature > 15) {
          AppHaptics.heavyImpact();
          controller.setAirConditionerValue(temperature - 1);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(space16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: grey),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: blackGradient2,
          ),
        ),
        child: Icon(
          Icons.remove_rounded,
          color: white.withOpacity(
            temperature < 16 ? .5 : 1,
          ),
          size: 26,
        ),
      ),
    );
  }

  Row buildItem() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Air Conditioner',
                style: satoshi700S16.copyWith(color: white),
              ),
              verticalSpacer4,
              Text(
                'LGS12EQ',
                style: satoshi700S12.copyWith(
                  color: const Color(0xFF6C6C6C),
                ),
              ),
            ],
          ),
        ),
        horizontalSpacer8,
        GetX<HomeController>(builder: (controller) {
          final value = controller.airConditionerSwitch;
          return Switch.adaptive(
            value: value,
            onChanged: (value) => controller.setAirConditionerSwitch(value),
            activeColor: primaryColor,
          );
        })
      ],
    );
  }

  Positioned buildImage() {
    return Positioned(
      bottom: -space24,
      right: -space24,
      child: Opacity(
        opacity: .6,
        child: Transform.scale(
          scale: 1.4,
          child: Image.asset(
            conditioner,
            height: 200,
          ),
        ),
      ),
    );
  }
}
