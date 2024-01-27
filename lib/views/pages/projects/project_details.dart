import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/views/components/card/card_fixed.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_absensi.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_kasbon.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_pemasukan.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_pengeluaran.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_progress.dart';

import '../../components/appbar/custom_appbar.dart';
import '../../components/card/card_expandable.dart';
import '../../components/card/card_list.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Detail Proyek",
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Absensi
              CardList(
                iconPath: 'assets/icons/attendance.svg',
                title: 'Absensi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectAbsensi()),
                  );
                },
              ),
              CardList(
                iconPath: 'assets/icons/request-money.svg',
                title: 'Pemasukan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectTambahPemasukan()),
                  );
                },
              ),
              CardList(
                iconPath: 'assets/icons/money-transfer.svg',
                title: 'Pengeluaran',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectTambahPengeluaran()),
                  );
                },
              ),
              CardList(
                iconPath: 'assets/icons/money-pocket.svg',
                title: 'Kasbon',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectKasbon()),
                  );
                },
              ),
              CardList(
                iconPath: 'assets/icons/progress.svg',
                title: 'Progress',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectTambahProgress()),
                  );
                },
              ),
              const Divider(
                height: 1,
                thickness: 8,
                color: ListColor.gray50,
              ),
              SizedBox(
                height: 16.h,
              ),
              Column(
                children: [
                  FixedCard(
                    description: "Total Pemasukan",
                    amount: "Rp 15.000",
                  ),
                  SizedBox(height: 8.w),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ExpandableCard(
                                description: "Total Pemasukan",
                                amount: "Rp 15.000",
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: ExpandableCard(
                                description: "Total Pemasukan",
                                amount: "Rp 15.000",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
