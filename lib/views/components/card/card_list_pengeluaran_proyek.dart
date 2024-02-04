// pengeluaran_proyek_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_cost_proyek_model.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/text/format_rupiah.dart';

Widget pengeluaranProyek({List<ListCostProyek>? data}) {
  return ListView.builder(
    itemCount: data!.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final proyeks = data[index];
      return Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              formatRupiah(int.parse(proyeks.totalPengeluaran.toString())),
              style: headerFontMenu.copyWith(fontSize: 18),
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
                Text(
                  proyeks.lokasiProyek!,
                  style: subHeaderFont.copyWith(fontSize: 16.sp),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      );
    },
  );
}
