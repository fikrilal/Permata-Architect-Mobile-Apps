import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';

import '../../../repository/res/color_libraries.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lokasi Proyek",
          style: headerFontMenu,
        ),
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(
                color: ListColor.gray100,
                thickness: 5,
              ),
              listLokasiProyek(
                  alamat: "Jl. Suparjan Mangun Wijaya No.02",
                  lokasi: "Lokasi Proyek 1")
            ],
          ),
        ),
      ),
    );
  }

  Widget listLokasiProyek({String? lokasi, String? alamat}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: 15,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      "$lokasi",
                      style: headerFontMenu.copyWith(fontSize: 18),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Hicons.location_bold,
                          size: 20,
                          color: ListColor.gray400,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "$alamat",
                          style: subHeaderFont.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
