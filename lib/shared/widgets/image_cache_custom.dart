import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';

enum ImageType { none, avatar }

class CustomCacheImageNetwork extends StatelessWidget {
  final String? imageUrl;

  final double? width;

  final double? height;

  final double? withResize, heightResize;

  final BoxFit boxFitResize;

  final double borderRadius;

  final BoxFit boxFit;

  final Color? customColor;

  final Widget? errorWidget;

  final ImageType imageType;
  final bool isShowLoading;

  const CustomCacheImageNetwork(
      {super.key,
      required this.imageUrl,
      this.width,
      this.height,
      this.borderRadius = 0,
      this.boxFit = BoxFit.cover,
      this.errorWidget,
      this.customColor,
      this.imageType = ImageType.none,
      this.withResize = 512,
      this.heightResize = 512,
      this.boxFitResize = BoxFit.contain,
      this.isShowLoading = true});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl == null || imageUrl!.isEmpty
          ? errorWidget ??
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(borderRadius)),
                child: imageType == ImageType.avatar
                    ? Icon(
                        Icons.account_circle_rounded,
                        color: Colors.grey,
                        size: (width! / 2),
                      )
                    : null,
              )
          : CachedNetworkImage(
              imageUrl: imageUrl ?? "",
              color: customColor,
              repeat: ImageRepeat.repeat,
              placeholderFadeInDuration: Duration.zero,
              errorWidget: (_, __, ___) {
                if (imageType == ImageType.avatar) {
                  return Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(borderRadius)),
                      child: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.grey,
                        size: (width! / 2),
                      ));
                }
                return errorWidget ??
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(borderRadius)),
                    );
              },
              placeholder: (context, string) => Center(
                child: isShowLoading
                    ? const CircularProgressIndicator(
                        color: AppColor.primary,
                      )
                    : const SizedBox(),
              ),
              width: width,
              height: height,
              fit: boxFit,
            ),
    );
  }
}
