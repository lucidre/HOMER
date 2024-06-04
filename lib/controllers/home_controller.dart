import 'dart:math';

import 'package:homer/common_libs.dart';

class HomeController extends GetxController {
  Timer? cleanerTimer;
  final random = Random();
  final RxString _selectedItem = 'Living room'.obs;
  final RxBool _airConditionerSwitch = true.obs;
  final RxBool _speakerSwitch = false.obs;
  final RxBool _cleanerSwitch = true.obs;
  final RxDouble _airConditionerValue = 21.4.obs;
  final RxInt _cleanerPercentage = 60.obs;
  final RxInt _cleanerKeyValue = 0.obs;
  final RxDouble _lightPercentage = 30.0.obs;
  final RxDouble _totalCleanerButtonWidth = 1.0.obs;
  final RxDouble _cleanerDifference = 0.0.obs;

  String get selectedItem => _selectedItem.value;
  bool get airConditionerSwitch => _airConditionerSwitch.value;
  bool get cleanerSwitch => _cleanerSwitch.value;
  bool get speakerSwitch => _speakerSwitch.value;
  double get airConditionerValue => _airConditionerValue.value;
  double get totalCleanerButtonWidth => _totalCleanerButtonWidth.value;
  int get cleanerPercentage => _cleanerPercentage.value;
  int get cleanerKeyValue => _cleanerKeyValue.value;
  double get lightPercentage => _lightPercentage.value;
  double get cleanerDifference => _cleanerDifference.value;

  setSelectedItem(String item) => _selectedItem(item);
  setAirConditionerSwitch(bool conditioner) =>
      _airConditionerSwitch(conditioner);
  setSpeakerSwitch(bool conditioner) => _speakerSwitch(conditioner);
  setCleanerSwitch(bool value) {
    _cleanerSwitch(value);
    if (value) {
      simulateCleaner();
    } else {
      simulateCleaner(true);
    }
  }

  setAirConditionerValue(double value) => _airConditionerValue(value);
  setTotalCleanerButtonWidth(double value) {
    if (totalCleanerButtonWidth != value) _totalCleanerButtonWidth(value);
  }

  setCleanerPercentage(int value) => _cleanerPercentage(value);
  setCleanerDifference(double value) => _cleanerDifference(value);
  seLightPercentage(double value) => _lightPercentage(value);
  setCleanerCleanValue(int value) => _cleanerKeyValue(value);

  void simulateAirConditioner() {
    const minChange = -0.7;
    const maxChange = 0.7;

    Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        final changeInTemperature =
            minChange + random.nextDouble() * (maxChange - minChange);
        final value = airConditionerValue + changeInTemperature;
        setAirConditionerValue(value);
      },
    );
  }

  int get cleanerTimeLeft {
    const seconds = 4;
    final percentageLeft = 100 - cleanerPercentage;
    return percentageLeft * seconds;
  }

  void simulateCleaner([bool isPaused = false]) {
    cleanerTimer?.cancel();
    if (isPaused) return;

    if (cleanerPercentage == 100) {
      setCleanerPercentage(0);
    }
    cleanerTimer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (cleanerPercentage < 100) {
          setCleanerCleanValue(random.nextInt(9999));
          setCleanerPercentage(cleanerPercentage + 1);
        } else {
          if (totalCleanerButtonWidth >= 5) {
            setCleanerDifference(totalCleanerButtonWidth - 60);
            setCleanerSwitch(false);
          }
          timer.cancel();
        }
      },
    );
  }
}
