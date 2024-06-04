import 'package:homer/common_libs.dart';
import 'package:homer/presenation/shapes/custom_shape2.dart';

class CardItem extends StatelessWidget {
  final Color color;
  final String title;
  final String image;
  final String subtext;
  final double scale;
  final IconData icon;

  const CardItem({
    super.key,
    required this.color,
    required this.title,
    required this.subtext,
    required this.icon,
    required this.image,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: black,
              borderRadius: BorderRadius.circular(space24 - 4),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
        buildBackgroundImage(),
        buildItem1(),
        buildRectangle(),
        buildImage(),
      ],
    );
  }

  Positioned buildRectangle() {
    return Positioned(
      bottom: space6,
      left: space6,
      right: space6,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(space24 - 4),
        ),
      ),
    );
  }

  Positioned buildImage() {
    return Positioned(
      bottom: space6,
      left: space6,
      right: space6,
      top: 0,
      child: LayoutBuilder(builder: (context, constraint) {
        final height = constraint.maxHeight - 90;
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: height,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(space24 - 4),
            ),
            child: Transform.scale(
              scale: scale,
              child: Transform.translate(
                offset: const Offset(0, 30),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: height,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  buildItem1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(space6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: satoshi500S16.copyWith(
                    color: black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: black,
                      size: 14,
                    ),
                    horizontalSpacer4,
                    Text(
                      subtext,
                      style: satoshi500S12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          child: Text(
            'On',
            style: satoshi500S16.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  buildBackgroundImage() {
    return CustomPaint(
      painter: CustomShape2(color: color),
      size: const Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}
