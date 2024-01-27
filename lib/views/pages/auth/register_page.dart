import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permata_architect_mobile_apps/poviders/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../repository/res/color_libraries.dart';
import '../../../repository/res/font_style.dart';
import '../../components/appbar/custom_appbar.dart';
import '../../components/button/button_primary.dart';
import '../../components/textfield/textfield_email_pass.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daftarkan Dirimu!",
                style: headerFontSignInUp.copyWith(fontSize: 24.0),
              ),
              Text(
                "Selesaikan proses registrasi agar kamu dapat masuk ke dalam aplikasi dan dapat menggunakan fitur sepenuhnya!",
                style: subHeaderFont.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Nama",
                style: headerTextField.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              EmailPassField(
                  text: "Nama Kamu",
                  svgIconPath: "assets/icons/icons_mail.svg",
                  controller: _controllerName,
                  iconColor: ListColor.gray500,
                  isPasswordType: false),
              const SizedBox(
                height: 5,
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
              const SizedBox(
                height: 20,
              ),
              primaryButton(
                  text: "Daftar",
                  onPressed: () async {
                    String emailInput = _controllerEmail.text;
                    String passwordInput = _controllerPassword.text;
                    String nameInput = _controllerName.text;

                    bool resultRegister = await authProvider.accountRegister(
                        email: emailInput,
                        password: passwordInput,
                        name: nameInput);

                    if (resultRegister) {
                      // ignore: use_build_context_synchronously
                      context.go("/LoginPage");
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Gagal Register",
                          style: regularFont.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  }),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  context.go("/LoginPage");
                },
                child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah Punya Akun?",
                          style: regularFont.copyWith(color: ListColor.gray500),
                        ),
                        Text(
                          " Login",
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
