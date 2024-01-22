import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_email_pass.dart';

import '../../../repository/res/font_style.dart';
import '../../components/button/button_primary.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "PermataArchitect",
                style: headerFontSignInUp.copyWith(fontSize: 30.0),
              ),
              Text(
                "Selamat datang kembali! Masuk menggunakan akun yang terdaftar di Permata Architect",
                style: subHeaderFont.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Email",
                style: headerTextField.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              EmailPassField(
                  text: "Email Kamu",
                  svgIconPath: "assets/icons/icons_mail.svg",
                  controller: _controllerEmail,
                  iconColor: ListColor.gray500,
                  isPasswordType: false),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Kata Sandi",
                style: headerTextField.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              EmailPassField(
                  text: "Kata Sandi Kamu",
                  svgIconPath: "assets/icons/icons_password.svg",
                  controller: _controllerPassword,
                  iconColor: ListColor.gray500,
                  isPasswordType: true),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Lupa Kata Sandi?",
                  style: textGreen.copyWith(fontSize: 18.0),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              primaryButton(
                  text: "Masuk",
                  onPressed: () {
                    String emailInput = _controllerEmail.text;
                    String passwordInput = _controllerPassword.text;

                    print(
                        "Email Kamu $emailInput dan password kamu $passwordInput");
                    context.go("/DashboardPage");
                  }),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  print("fungsi daftar here!!");
                },
                child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum Punya Akun?",
                          style: regularFont.copyWith(color: ListColor.gray500),
                        ),
                        Text(
                          " Daftar",
                          style: textGreen.copyWith(fontSize: 18),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
