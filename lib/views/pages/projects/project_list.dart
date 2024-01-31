import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/api/api_list_progress.dart';
import 'package:permata_architect_mobile_apps/poviders/list_proyek.dart';
import 'package:permata_architect_mobile_apps/poviders/search_list_proyek.dart';
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

  bool isSearching = false;

  void _onSearchSubmitted(String value) {
    Provider.of<SearchListProyek>(context, listen: false).searchlist(value);
    setState(() {
      isSearching = true; // Update state saat pencarian
    });
  }

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
                  onChanged: (String value) {
                    if (value == '') {
                      print("kosong");
                      setState(() {
                        isSearching = false;
                      });
                    } else {
                      print('value = $value');
                    }
                  },
                  onSubmiited: (String value) {
                    if (value != '') {
                      _onSearchSubmitted(value);
                    }
                  },
                  text: "Cari Proyek.."),
              isSearching
                  ? _buildSearchList() // Tampilkan hasil pencarian
                  : _buildListProyek()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchList() {
    return Consumer<SearchListProyek>(
      builder: (context, state, _) {
        if (state.state == ResultsCari.loading) {
          return const CircularProgressIndicator();
        } else if (state.state == ResultsCari.hasData) {
          return ListView.builder(
            itemCount: state.searchResults!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final datalist = state.searchResults![index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: CardListProject(
                  alamat: "${datalist.lokasiProyek}",
                  lokasi: "${datalist.keterangan}",
                  pemilik: "${datalist.namaPemilik}",
                  status: "${datalist.status}",
                ),
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
    );
  }

  Widget _buildListProyek() {
    return Consumer<ListProyekProvider>(
      builder: (context, state, _) {
        if (state.state == ResultListProyek.loading) {
          return const CircularProgressIndicator();
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
                  alamat: "${datalist.lokasiProyek}",
                  lokasi: "${datalist.keterangan}",
                  pemilik: "${datalist.namaPemilik}",
                  status: "${datalist.status}",
                ),
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
    );
  }
}
