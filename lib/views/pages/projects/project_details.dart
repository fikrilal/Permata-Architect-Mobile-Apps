import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';
import 'package:permata_architect_mobile_apps/poviders/total_biaya_proyek.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/views/components/card/card_fixed.dart';
import 'package:permata_architect_mobile_apps/views/components/text/format_rupiah.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_absensi.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_kasbon.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_pemasukan.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_pengeluaran.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_progress.dart';
import 'package:provider/provider.dart';

import '../../../poviders/list_progress_byId.dart';
import '../../../repository/api/api_config.dart';
import '../../../repository/res/font_style.dart';
import '../../components/appbar/custom_appbar.dart';
import '../../components/card/card_expandable.dart';
import '../../components/card/card_list.dart';
import '../../components/text/format_date.dart';

class ProjectDetails extends StatefulWidget {
  final ListProyek listProyek;
  const ProjectDetails({super.key, required this.listProyek});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  void initState() {
    // TODO: implement initState
    final provider =
        Provider.of<TotalBiayaProyekProvider>(context, listen: false);
    final progress =
        Provider.of<ListProgressByIdProvider>(context, listen: false);
    provider.fetchBiayaProyek(idProyek: widget.listProyek.idProyek.toString());
    progress.fetchGetById(idProyek: widget.listProyek.idProyek.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.listProyek.keterangan!,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Absensi
              CardList(
                iconPath: 'assets/icons/attendance.svg',
                title: 'Absensi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProjectAbsensi(
                              listProyek: widget.listProyek,
                            )),
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
                        builder: (context) => ProjectTambahPemasukan(
                              listProyek: widget.listProyek,
                            )),
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
                        builder: (context) => ProjectTambahPengeluaran(
                              listProyek: widget.listProyek,
                            )),
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
                        builder: (context) =>
                            ProjectKasbon(listProyek: widget.listProyek)),
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
                        builder: (context) => ProjectTambahProgress(
                              listProyek: widget.listProyek,
                            )),
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
              //duid
              _buildTotalProyek(),
              SizedBox(
                height: 20.h,
              ),
              progressProyek()
            ],
          ),
        ),
      ),
    );
  }

  Widget progressProyek() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Progress Proyek",
          style: headerFontMenu.copyWith(fontSize: 20.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        Consumer<ListProgressByIdProvider>(
          builder: (context, state, _) {
            if (state.state == ResultProgressId.loading) {
              return const CircularProgressIndicator();
            } else if (state.state == ResultProgressId.hasData) {
              return ListView.builder(
                itemCount: state.listprogress.length,
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
                              imageUrl:
                                  "${ApiConfig.baseUrlImage}${data.picUrl}",
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
            } else {
              if (state.message == '404') {
                return const Text('Terjadi masalah jaringan');
              } else {
                return Text(state.message);
              }
            }
          },
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Widget _buildTotalProyek() {
    return Consumer<TotalBiayaProyekProvider>(
      builder: (context, state, _) {
        if (state.state == ResultBiaya.loading) {
          return const CircularProgressIndicator();
        } else if (state.state == ResultBiaya.hasData) {
          return Column(
            children: [
              FixedCard(
                description: "Total Pemasukan",
                amount:
                    formatRupiah(int.parse(state.biayaProyek.totalPemasukan!)),
              ),
              SizedBox(height: 8.w),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ExpandableCard(
                            description: "Total Pengeluaran",
                            amount: formatNominal(formatRupiah(int.parse(
                                state.biayaProyek.totalPengeluaran!))),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ExpandableCard(
                            description: "Total \nKasbons",
                            amount: formatNominal(formatRupiah(
                                int.parse(state.biayaProyek.totalKasbons!))),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        } else {
          if (state.message == '404') {
            return const Text('Terjadi masalah jaringan');
          } else {
            return Text(state.message);
          }
        }
      },
    );
  }
}
