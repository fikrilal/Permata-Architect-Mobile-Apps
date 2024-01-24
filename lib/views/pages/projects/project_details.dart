import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/views/components/card/card_fixed.dart';

import '../../components/card/card_expandable.dart';
import '../../components/card/card_list.dart';
import '../../components/text/description.dart';
import '../../components/text/header.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ListColor.gray500),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: ComponentTextAppBar("Detail Proyek"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: ListColor.gray200,
            height: 1.0,
          ),
        ),
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
                  // ke halaman yang dituju
                },
              ),
              CardList(
                iconPath: 'assets/icons/request-money.svg',
                title: 'Pemasukan',
                onTap: () {
                  // ke halaman yang dituju
                },
              ),
              CardList(
                iconPath: 'assets/icons/money-transfer.svg',
                title: 'Pengeluaran',
                onTap: () {
                  // ke halaman yang dituju
                },
              ),
              CardList(
                iconPath: 'assets/icons/money-pocket.svg',
                title: 'Kasbon',
                onTap: () {
                  // ke halaman yang dituju
                },
              ),
              CardList(
                iconPath: 'assets/icons/progress.svg',
                title: 'Progress',
                onTap: () {
                  // ke halaman yang dituju
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
