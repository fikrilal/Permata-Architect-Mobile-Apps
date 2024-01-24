import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/button/button_primary.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_primary.dart';

class ProjectKasbon extends StatefulWidget {
  const ProjectKasbon({super.key});

  @override
  State<ProjectKasbon> createState() => _ProjectKasbonState();
}

class _ProjectKasbonState extends State<ProjectKasbon> {
  final TextEditingController _controllerHarga = TextEditingController();
  final TextEditingController _controllerSearchName = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kasbon",
          style: headerTextField.copyWith(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Hicons.left_1_light_outline)),
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          textFieldSearch(
              controller: _controllerSearchName,
              keyboardType: TextInputType.name,
              text: "Cari Pekerja.."),
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return lisKasbon(
                  name: "Muhammad Al-kahfi", kasbonPrice: "28.000");
            },
          ),
        ]),
      )),
    );
  }

  Widget lisKasbon({String? name, String? kasbonPrice}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "$name",
            style: headerTextField.copyWith(fontSize: 20),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          subtitle: Text(
            "Kasbon: Rp. $kasbonPrice",
            style: subHeaderFont.copyWith(fontSize: 18),
          ),
          trailing: IconButton(
              onPressed: () {
                showAction();
              },
              icon: const Icon(
                Hicons.right_2_light_outline,
                size: 24,
              )),
        ),
        const Divider()
      ],
    );
  }

  Widget textFieldSearch(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      String? text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        enableSuggestions: true,
        autocorrect: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        cursorColor: ListColor.primary,
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: ListColor.gray700, // Warna teks dalam TextField
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ListColor.gray200,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ListColor.primary,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ListColor.primary,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1,
            ),
          ),
          labelText: text,
          prefixIcon: Container(
            width: 54,
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Icon(Hicons.search_2_light_outline),
            ),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: ListColor.gray500,
          ),
          filled: false,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  void showAction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        // Return a widget that you want to show in your bottom sheet.
        return Container(
          height: 366,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 130),
                  child: Divider(
                    thickness: 2.0,
                    color: ListColor.gray300,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Kurangi Kasbon',
                  style: headerFontMenu.copyWith(fontSize: 24),
                ),
                Text(
                  "Kurangi nominal kasbon untuk Mohammad Al-Kahfi",
                  style: subHeaderFont.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                textFieldForm(
                    controller: _controllerHarga,
                    text: "Rp. ",
                    header: "Nominal",
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 15,
                ),
                primaryButton(text: "Simpan", onPressed: () {})
              ],
            ),
          ),
        );
      },
    );
  }
}
