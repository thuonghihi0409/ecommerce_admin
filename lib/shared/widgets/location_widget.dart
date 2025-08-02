import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';

class LocationWidget extends StatelessWidget {
  final AddressEntity address;
  final Function? onTap;
  const LocationWidget({super.key, required this.address, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: AppColor.blackColor),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.name ?? "",
                style: AppTextStyles.textSize18(),
              ),
              10.h,
              Text(
                "+ ${address.phone}",
                style: AppTextStyles.textSize18(),
              ),
              10.h,
              Row(
                children: [
                  const Icon(Icons.location_on),
                  15.w,
                  Text(
                    address.address,
                    style: AppTextStyles.textSize18(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
