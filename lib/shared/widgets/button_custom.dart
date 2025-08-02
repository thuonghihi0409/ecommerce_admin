import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Widget? icon;
  final bool isLoading;
  final bool isEnable;
  final bool isMinWidth;

  const CustomButton(
      {super.key,
      required this.text,
      this.isEnable = true,
      this.onPressed,
      this.borderColor,
      this.textStyle,
      this.backgroundColor,
      this.foregroundColor,
      this.borderRadius = 25,
      this.padding,
      this.width,
      this.height,
      this.icon,
      this.isLoading = false,
      this.isMinWidth = false});

  @override
  Widget build(BuildContext context) {
    final buttonChild = isLoading
        ? const SizedBox(
            width: 22,
            height: 22,
            child:
                CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: textStyle ??
                    const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          );

    return SizedBox(
      width: isMinWidth ? null : (width ?? double.infinity),
      height: height,
      child: ElevatedButton(
        onPressed: (isLoading || !isEnable) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          backgroundColor: backgroundColor ?? AppColor.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            side: borderColor != null
                ? BorderSide(width: 1, color: borderColor ?? AppColor.primary)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
        ),
        child: buttonChild,
      ),
    );
  }
}
