import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Widget? icon;
  final double borderRadius;
  final bool isEnabled;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.padding,
    this.icon,
    this.borderRadius = AppDimensions.radiusMedium,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height ?? AppDimensions.buttonHeight,
        child: OutlinedButton(
          onPressed: isEnabled && !isLoading ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? AppColors.primary,
            side: BorderSide(
              color: backgroundColor ?? AppColors.primary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: padding,
          ),
          child: _buildChild(theme),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height ?? AppDimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: foregroundColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        child: _buildChild(theme),
      ),
    );
  }

  Widget _buildChild(ThemeData theme) {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: AppDimensions.paddingSmall),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}
