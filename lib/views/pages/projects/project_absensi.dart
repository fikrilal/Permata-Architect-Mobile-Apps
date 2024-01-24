import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';

class ProjectAbsensi extends StatefulWidget {
  const ProjectAbsensi({super.key});

  @override
  State<ProjectAbsensi> createState() => _ProjectAbsensiState();
}

class _ProjectAbsensiState extends State<ProjectAbsensi> {
  String? initialValue;
  List<String> absensi = ['Masuk', 'Setengah Hari', 'Tidak Masuk'];

  List<String> namaPegawai = ['Adit', 'Sopo', 'Jarwo', 'Kamal'];
  List<String> absensiKehadiran = [
    'Masuk',
    'Setengah Hari',
    'Tidak Masuk',
    'Masuk'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Absensi",
          style: headerFontMenu.copyWith(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Hicons.left_1_light_outline)),
        surfaceTintColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: namaPegawai.length,
        itemBuilder: (context, index) {
          return listNama(
              name: namaPegawai[index],
              valueName: absensiKehadiran[index],
              index: index);
        },
      ),
    );
  }

  Widget listNama({String? name, String? valueName, int? index}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$name",
                style: regularFont,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Text(
                    'Kehadiran',
                    style: regularFont,
                  ),
                  items: absensi
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            alignment: Alignment.centerRight,
                            child: Text(
                              item,
                              textAlign: TextAlign.end,
                              style: regularFont,
                            ),
                          ))
                      .toList(),
                  value: valueName,
                  alignment: Alignment.centerRight,
                  onChanged: (String? value) {
                    setState(() {
                      absensiKehadiran[index!] = value ?? '';
                      print(absensiKehadiran[index]);
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    height: 40,
                    width: 150,
                  ),
                  iconStyleData: const IconStyleData(
                      icon: Icon(
                    Hicons.down_2_bold,
                    size: 24,
                  )),
                  dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 150,
                      direction: DropdownDirection.right),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
