import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/poviders/list_proyek.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:provider/provider.dart';

import '../../../repository/res/color_libraries.dart';
import '../../components/card/card_list_project.dart';
import '../../components/textfield/textfield_search.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final TextEditingController _controllerSearchName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lokasi Proyek",
          style: headerFontMenu,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: ListColor.gray200,
            height: 1.0,
          ),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              TextFieldSearchWidget(
                  controller: _controllerSearchName,
                  keyboardType: TextInputType.name,
                  text: "Cari Proyek.."),
              Consumer<ListProyekProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultListProyek.loading) {
                    return CircularProgressIndicator();
                  } else if (state.state == ResultListProyek.hasData) {
                    return ListView.builder(
                      itemCount: state.listProyek.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final datalist = state.listProyek[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: CardListProject(
                            alamat: "${datalist.keterangan}",
                            lokasi: "${datalist.lokasiProyek}",
                            pemilik: "${datalist.namaPemilik}",
                            status: "${datalist.status}",
                          ),
                        );
                      },
                    );
                  } else {
                    return Text("data");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
