import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';
import 'package:permata_architect_mobile_apps/poviders/total_biaya_proyek.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/shared/shared_prefs.dart';
import 'package:permata_architect_mobile_apps/views/components/card/card_fixed.dart';
import 'package:permata_architect_mobile_apps/views/components/text/format_rupiah.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_absensi.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_kasbon.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_pemasukan.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_pengeluaran.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_progress.dart';
import 'package:provider/provider.dart';

import '../../components/appbar/custom_appbar.dart';
import '../../components/card/card_expandable.dart';
import '../../components/card/card_list.dart';

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<TotalBiayaProyekProvider>(context, listen: false);
    provider.fetchBiayaProyek(idProyek: widget.listProyek.idProyek.toString());
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
              //duid
              _buildTotalProyek()
            ],
          ),
        ),
      ),
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
