import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/views/components/card/card_fixed.dart';

import '../../components/card/card_expandable.dart';
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
              InkWell(
                onTap: (){
                  //ke halaman yang dituju
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: ListColor.gray200),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 24.h, 0, 24.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/attendance.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                        SizedBox(width: 16.w,),
                        TextDescriptionMain("Absensi"),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/arrow-right.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Pemasukan
              InkWell(
                onTap: (){
                  //ke halaman yang dituju
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: ListColor.gray200),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 24.h, 0, 24.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/request-money.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                        SizedBox(width: 16.w,),
                        TextDescriptionMain("Pemasukan"),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/arrow-right.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Pengeluaran
              InkWell(
                onTap: (){
                  //ke halaman yang dituju
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: ListColor.gray200),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 24.h, 0, 24.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/money-transfer.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                        SizedBox(width: 16.w,),
                        TextDescriptionMain("Pengeluaran"),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/arrow-right.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Kasbon
              InkWell(
                onTap: (){
                  //ke halaman yang dituju
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: ListColor.gray200),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 24.h, 0, 24.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/money-pocket.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                        SizedBox(width: 16.w,),
                        TextDescriptionMain("Kasbon"),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/arrow-right.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Progress
              InkWell(
                onTap: (){
                  //ke halaman yang dituju
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: ListColor.gray200),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 24.h, 0, 24.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/progress.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                        SizedBox(width: 16.w,),
                        TextDescriptionMain("Progress"),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/arrow-right.svg',
                          width: 24.w,
                          height: 24.h,
                          color: ListColor.gray700,
                        ),
                      ],
                    ),
                  ),
                ),
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
