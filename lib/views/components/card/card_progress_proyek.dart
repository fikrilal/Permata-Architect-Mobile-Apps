import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/repository/api/api_config.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/text/format_date.dart';

import '../../../poviders/list_progress_all.dart';

Widget progressProyek(ListProgressAllProvider state) {
  return ListView.builder(
    itemCount: 5,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final data = state.listprogress[index];
      return Column(
        children: [
          ListTile(
            leading: Container(
              width: 56.w,
              height: 56.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: CachedNetworkImage(
                  imageUrl: "${ApiConfig.baseUrlImage}${data.picUrl}",
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/construction.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              data.progress!,
              style: headerFontMenu.copyWith(fontSize: 18.sp),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Hicons.location_light_outline,
                  size: 20,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Flexible(
                  child: Text(
                    data.detailLokasi!,
                    style: subHeaderFont.copyWith(fontSize: 16.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            trailing: Text(
              dateMonth(date: data.tanggal),
              style: regularFont.copyWith(fontSize: 14.sp),
            ),
          ),
          const Divider(),
        ],
      );
    },
  );
}
