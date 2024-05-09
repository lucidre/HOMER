import 'package:homer/common_libs.dart';

class TimerCountDown2 extends StatefulWidget {
  final int totalSeconds;
  const TimerCountDown2({super.key, required this.totalSeconds});

  @override
  State<TimerCountDown2> createState() => _TimerCountDown2State();
}

class _TimerCountDown2State extends State<TimerCountDown2> {
  DateTime? time;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      int hours = widget.totalSeconds ~/ 3600;
      int remainder = widget.totalSeconds % 3600;
      int minutes = remainder ~/ 60;
      int seconds = remainder % 60;
      time = DateTime(
        DateTime.now().year,
        1,
        1,
        hours,
        minutes,
        seconds,
      );
      setState(() {});
      startTimer();
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == null) {
        return;
      }
      final hours = time!.hour;
      final minutes = time!.minute;
      final seconds = time!.second;

      if (hours == 0 && minutes == 0 && seconds == 0) {
        timer.cancel();
      } else {
        bool isWorking = Get.find<HomeController>().cleanerSwitch;
        if (isWorking) {
          time = time!.subtract(const Duration(seconds: 1));
        }

        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String getFormattedTime() {
    if (time == null) {
      return '';
    }
    final hours = time!.hour.toString().padLeft(2, '0');
    final minutes = time!.minute.toString().padLeft(2, '0');
    final seconds = time!.second.toString().padLeft(2, '0');

    return '$hours : $minutes : $seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getFormattedTime(),
      style: satoshi700S24.copyWith(
        fontSize: 35,
        color: primaryColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
