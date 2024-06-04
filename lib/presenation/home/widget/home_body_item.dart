import 'package:flutter/cupertino.dart';
import 'package:homer/common_libs.dart';

class HomeBodyItem extends StatelessWidget {
  final String description;
  final IconData icon;
  final List<Color> colors;
  final String lottie;
  final String text1;
  final String text2;
  const HomeBodyItem({
    super.key,
    required this.description,
    required this.icon,
    required this.colors,
    required this.lottie,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colors.last.withOpacity(.4),
            offset: const Offset(0, 4),
          )
        ],
        gradient: RadialGradient(
          center: Alignment.centerRight,
          radius: 1.5,
          focalRadius: 10,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(space16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -space32 * 1.2,
            bottom: -space32 * 1.2,
            child: Lottie.asset(
              lottie,
              height: 250,
              width: 250,
              repeat: true,
              reverse: false,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(space12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: white,
                      size: 18,
                    ),
                    horizontalSpacer4,
                    Text(
                      description,
                      style: satoshi700S16.copyWith(color: white),
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.ellipsis,
                      color: white,
                    ),
                  ],
                ),
                verticalSpacer8,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      text1,
                      style: satoshi700S32.copyWith(
                        fontSize: 80,
                        color: white,
                        height: 1,
                      ),
                    ),
                    Text(
                      text2,
                      style: satoshi700S24.copyWith(
                        color: white,
                        height: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
