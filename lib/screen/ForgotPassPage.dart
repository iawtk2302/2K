import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneaker_app/service/FirebaseService.dart';

import '../router/routes.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.login);
          },
          child: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 42
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset("assets/images/forgot.png"),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Forgot",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Password",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700))),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Don't worry! It happen. Please enter the address associated with your account.",
                      style: TextStyle(fontSize: 16))),
            ),
            const SizedBox(height: 50),
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ThemeData().colorScheme.copyWith(
                      primary: Colors.black,
                    ),
              ),
              child: SizedBox(
                width: size.width * 0.8,
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Email",
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1.5, color: Color(0xFFFAFAFA)),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFAFAFA)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                  padding: const EdgeInsets.only(top: 25,),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.black),),);
                        FirebaseService().resetPass(_emailController.text.trim(), context);
                        Navigator.pushReplacementNamed(context, Routes.login);
                      }
                    },
                    child: Container(                
                      child: Center(
                          child: Text("Reset Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white))),
                      height: 50,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black),
                    ),
                  ),
                ),
          ]),
        ),
      ),
    );
  }
}
