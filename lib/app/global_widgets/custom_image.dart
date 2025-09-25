import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_constants.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppDimensions.radiusMedium),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ??
            Shimmer.fromColors(
              baseColor: AppColors.greyLight,
              highlightColor: AppColors.white,
              child: Container(
                width: width,
                height: height,
                color: AppColors.greyLight,
              ),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              width: width,
              height: height,
              color: AppColors.greyLight,
              child: const Icon(
                Icons.error,
                color: AppColors.grey,
              ),
            ),
      ),
    );
  }
}

class CustomImageWithGradient extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final Widget? child;
  final Gradient? gradient;
  final BorderRadius? borderRadius;

  const CustomImageWithGradient({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.child,
    this.gradient,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.circular(AppDimensions.radiusMedium),
      child: Stack(
        children: [
          CustomNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.zero,
          ),
          if (gradient != null)
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: gradient,
              ),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
