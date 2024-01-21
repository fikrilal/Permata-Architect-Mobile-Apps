import 'package:flutter/material.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_email_pass.dart';

import '../../../repository/res/font_style.dart';
import '../../components/button/button_primary.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerName = TextEditingController();
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
                "Selamat Datang Kembali!",
                style: headerFontSignInUp.copyWith(fontSize: 30.0),
              ),
              Text(
                "Masuk kembali ke akunmu, dan nikmati fitur lengkap dari nail.it!",
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
              EmailPassTextfield(
                  "Email Kamu", "", false, _controllerName, Colors.blue),
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
              EmailPassTextfield(
                  "Kata Sandi Kamu", "", false, _controllerName, Colors.blue),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Lupa Kata Sandi?",
                  style: textPassword.copyWith(fontSize: 18.0),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              primaryButton(text: "text", onPressed: () {}),
              Expanded(child: Container()),
              Text("data")
            ],
          ),
        ),
      ),
    );
  }
}
