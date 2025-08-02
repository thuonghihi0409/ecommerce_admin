import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/service/picker_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:url_launcher/url_launcher.dart';

/// Toast type
enum ToastType { success, error }

/// Picker type
enum PickerType { takePhoto, gallery, video, recordVideo }

class Helper {
  /// Use when showing custom dialog

  static void showCustomBottomSheet({
    required BuildContext context,
    String? message,
    Function()? onClose,
    bool isShowSecondButton = false,
    Function()? onPressPrimaryButton,
    Function()? onPressSecondButton,
    String? labelPrimary,
    String? labelSecondary,
    Widget? headerCustom,
    ValueNotifier<bool>? isDisablePrimaryButton,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    final disableNotifier = isDisablePrimaryButton ?? ValueNotifier(false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
          ),
          child: ValueListenableBuilder<bool>(
            valueListenable: disableNotifier,
            builder: (context, isDisabled, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header (icon, title...)
                  if (headerCustom != null) headerCustom,

                  // Nội dung thông báo
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        message,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Nút hành động
                  if (onPressPrimaryButton != null)
                    Row(
                      children: [
                        // Nút phụ
                        if (isShowSecondButton)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onPressSecondButton,
                              child: Text(labelSecondary ?? 'Cancel'),
                            ),
                          ),

                        if (isShowSecondButton) const SizedBox(width: 12),

                        // Nút chính
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isDisabled ? null : onPressPrimaryButton,
                            child: Text(labelPrimary ?? 'Confirm'),
                          ),
                        ),
                      ],
                    ),

                  // Close icon hoặc hành động đóng
                  if (onClose != null)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onClose();
                      },
                      child: const Text('Close'),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  static void showCustomDialog({
    required BuildContext context,
    String? message,
    Function()? onClose,
    bool isShowSecondButton = false,
    bool isShowPrimaryButton = false,
    required Function() onPressPrimaryButton,
    onPressSecondButton,
    String? labelPrimary,
    labelSecondary,
    bool barrierDismissible = true,
    Widget? headerCustom,
    ValueNotifier<bool>? isDisablePrimaryButton,
    ScrollController? scrollController,
    bool isNeverScroll = false,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (dialogContext) {
          return SingleChildScrollView(
            controller: scrollController,
            physics:
                isNeverScroll ? const NeverScrollableScrollPhysics() : null,
            child: ValueListenableBuilder(
                valueListenable: isDisablePrimaryButton ?? ValueNotifier(false),
                builder: (context, isDisableButton, child) {
                  return Dialog(
                    insetPadding: kIsWeb
                        ? EdgeInsets.symmetric(
                            horizontal: context.widthScreen * 0.3)
                        : const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          if (message != null)
                            Text(
                              message,
                              style: AppTextStyles.textSize18(),
                            ),
                          headerCustom ?? const SizedBox(),
                          Row(
                            mainAxisAlignment:
                                isShowPrimaryButton && isShowSecondButton
                                    ? MainAxisAlignment.spaceAround
                                    : (isShowPrimaryButton
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start),
                            children: [
                              if (isShowSecondButton)
                                CustomButton(
                                  text: "key_cancel".tr(),
                                  isMinWidth: true,
                                  onPressed: onClose ??
                                      () {
                                        NavigationService.instance.goBack();
                                      },
                                ),
                              if (isShowPrimaryButton)
                                CustomButton(
                                  text: "key_ok".tr(),
                                  isMinWidth: true,
                                  onPressed: onPressPrimaryButton,
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }

  static Future<void> showAdditionalCustomDialog({
    required BuildContext context,
    required Widget customDialog,
    double? horizontalInsetPadding,
    double? verticalInsetPadding,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColor.primary,
          insetPadding: EdgeInsets.symmetric(
            horizontal: horizontalInsetPadding ?? 150,
            vertical: verticalInsetPadding ?? 20,
          ),
          child: customDialog,
        );
      },
    );
  }

  /// Show toast message

  static void showToastBottom({
    required String message,
    ToastType type = ToastType.error,
    Duration? duration,
  }) {
    Color color = const Color(0xffFDEDEE);
    late Widget icon;
    switch (type) {
      case ToastType.success:
        color = const Color(0xffEBFBF6);
        icon = const Icon(
          Icons.check_circle,
          color: Colors.green,
        );
        break;
      case ToastType.error:
        icon = const Icon(
          Icons.error_outlined,
          color: Colors.red,
        );
        break;
    }

    showSimpleNotification(
        Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Expanded(
                child: Linkify(
              text: message,
              style: AppTextStyles.textSize10(),
              linkStyle: AppTextStyles.textSize10()
                  .copyWith(decoration: TextDecoration.underline),
              onOpen: (link) => launchUrl(Uri.parse(link.url)),
              options: const LinkifyOptions(humanize: false),
            ))
          ],
        ),
        elevation: 0,
        background: color,
        duration: duration ?? const Duration(milliseconds: 1500),
        position: NotificationPosition.top,
        autoDismiss: true,
        slideDismissDirection: DismissDirection.up);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return phoneNumber;

    phoneNumber = phoneNumber.replaceAll(' ', '');

    String countryCode = '';
    if (phoneNumber.startsWith('+')) {
      int firstDigitIndex = phoneNumber.indexOf(RegExp(r'\d'));
      int secondDigitIndex = firstDigitIndex + 1;

      while (secondDigitIndex < phoneNumber.length &&
          secondDigitIndex - firstDigitIndex < 2 &&
          int.tryParse(phoneNumber.substring(
                  firstDigitIndex, secondDigitIndex + 1)) !=
              null) {
        secondDigitIndex++;
      }

      countryCode = phoneNumber.substring(0, secondDigitIndex);
      phoneNumber = phoneNumber.substring(secondDigitIndex);
    }

    List<String> parts = [];
    if (phoneNumber.length >= 3) {
      parts.add(phoneNumber.substring(0, 3));
    }
    if (phoneNumber.length >= 7) {
      parts.add(phoneNumber.substring(3, 7));
    }
    if (phoneNumber.length > 7) {
      parts.add(phoneNumber.substring(7));
    }

    return countryCode.isNotEmpty
        ? '$countryCode ${parts.join(' ')}'
        : parts.join(' ');
  }

  static String formatNumber(num number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }

  static String extractDatePart(String input) {
    try {
      if (input.length == 10) {
        DateTime date = DateTime.parse(input);
        return "${date.day}";
      } else if (input.length == 7) {
        DateTime date = DateTime.parse("$input-01");
        return "${date.month}";
      } else if (input.length == 4) {
        return input;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  static void showImagePickerDialog(BuildContext context,
      {Function(String?)? onPicker,
      Function(List<String>?)? onPickers,
      Function(String?)? onCamera,
      bool? isOne = false}) {
    PickerService pickerService = PickerService();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Chọn từ thư viện'),
                  leading: const Icon(Icons.photo_library),
                  onTap: () async {
                    NavigationService.instance.goBack();
                    if (isOne == true) {
                      final path =
                          await pickerService.pickSingleImageFromGallery();
                      log(" path = $path");
                      onPicker?.call(path);
                    } else {
                      final paths =
                          await pickerService.pickMultipleImagesFromGallery();
                      onPickers?.call(paths);
                    }
                  },
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('Mở camera'),
                  leading: const Icon(Icons.camera_alt_outlined),
                  onTap: () async {
                    NavigationService.instance.goBack();
                    final path = await pickerService.captureImageFromCamera();
                    onCamera?.call(path);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  static String timeAgo(DateTime time) {
    // Viết theo nhu cầu: '2 phút trước', 'hôm qua',...
    return DateFormat.Hm().format(time);
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm dd/MM').format(time);
  }

  static String formatCurrencyVND(dynamic input) {
    try {
      final number = num.tryParse(input.toString());
      if (number == null) return '0 ₫';

      final formatter = NumberFormat.currency(
        locale: 'vi_VN',
        symbol: '₫',
        decimalDigits: 0,
      );

      return formatter.format(number);
    } catch (e) {
      return '0 ₫';
    }
  }

  static String convertLastMessage(MessageEntity? message) {
    switch (message?.messageType ?? MessageType.message) {
      case MessageType.message:
        return message?.content ?? "";
      case MessageType.media:
        return message?.content ?? "";
      case MessageType.product:
        return "[${"key_product".tr()}] ${message?.product?.productName ?? ""}";
    }
  }
}
