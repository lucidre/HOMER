import 'package:homer/common_libs.dart';

extension DeviceStyles on BuildContext {
  TextStyle? bodyLarge({
    final FontWeight? fontWeight,
    double? fontSize,
    double? height,
    Color? color,
    String? fontFamily,
  }) {
    final style = Theme.of(this).textTheme.bodyLarge;
    final size = fontSize ?? style?.fontSize;
    return style?.copyWith(
      fontWeight: fontWeight ?? style.fontWeight,
      color: color ?? style.color,
      height: height ?? style.height,
      fontSize: size,
      fontFamily: fontFamily ?? style.fontFamily,
    );
  }

  TextStyle? bodyMedium({
    final FontWeight? fontWeight,
    double? fontSize,
    Color? color,
    String? fontFamily,
    double? height,
    FontStyle? fontStyle,
  }) {
    final style = Theme.of(this).textTheme.bodyMedium;
    final size = fontSize ?? style?.fontSize;
    return style?.copyWith(
      // height: height ?? style.height,
      height: 1.5,
      fontStyle: fontStyle ?? style.fontStyle,
      fontWeight: fontWeight ?? style.fontWeight,
      fontSize: size,
      color: color ?? style.color,
      fontFamily: fontFamily ?? style.fontFamily,
    );
  }

  InputDecoration inputDecoration(
      {Widget? prefixIcon,
      Widget? suffixIcon,
      Widget? icon,
      String? labelText,
      String? hintText,
      String? errorText,
      String? helperText,
      String? prefixText,
      String? suffixText,
      String? counterText,
      String? semanticCounterText,
      InputBorder? border,
      InputBorder? focusedBorder,
      InputBorder? enabledBorder,
      InputBorder? errorBorder,
      TextStyle? hintStyle,
      TextStyle? labelStyle,
      TextStyle? errorStyle,
      TextStyle? helperStyle,
      TextStyle? prefixStyle,
      TextStyle? suffixStyle,
      TextStyle? counterStyle,
      TextStyle? floatingLabelStyle,
      EdgeInsets? padding}) {
    final borderRadius = BorderRadius.circular(cornersSmall);
    const borderSide = BorderSide(width: 1, color: neutral300);
    return InputDecoration(
      errorMaxLines: 5,
      hintStyle: hintStyle ?? satoshi500S14.copyWith(color: neutral400),
      labelStyle: labelStyle ?? satoshi500S14,
      errorStyle: errorStyle ?? satoshi500S14.copyWith(color: Colors.red),
      helperStyle: helperStyle ?? satoshi500S14,
      prefixStyle: prefixStyle ?? satoshi500S14,
      suffixStyle: suffixStyle ?? satoshi500S14,
      counterStyle: counterStyle ?? satoshi500S14,
      floatingLabelStyle: floatingLabelStyle ?? satoshi500S14,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      fillColor: neutral100,
      filled: true,
      icon: icon,
      contentPadding: padding ??
          const EdgeInsets.only(
              left: kDefaultPadding / 2, right: kDefaultPadding / 2),
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      helperText: helperText,
      prefixText: prefixText,
      suffixText: suffixText,
      counterText: counterText,
      semanticCounterText: semanticCounterText,
      border: border ??
          OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
      focusedBorder: focusedBorder ??
          OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: borderSide,
          ),
      enabledBorder: enabledBorder ??
          OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
      errorBorder: errorBorder ??
          OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              width: .8,
              color: Colors.red,
            ),
          ),
    );
  }
}
