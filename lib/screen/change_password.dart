import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SvgPicture.asset(
                'assets/images/forgot_password.svg',
                height: 400,
                // color: Colors.black,
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 40),
            //   child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         "Forgot",
            //         style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            //       )),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 40),
            //   child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: Text("Password",
            //           style: TextStyle(
            //               fontSize: 32, fontWeight: FontWeight.w700))),
            // ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Create Your New Password",
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
                child: Column(
                  children: [
                    TextFormField(
                      controller: _newPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid password";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "New Password",
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1.5,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1.5, color: Color(0xFFFAFAFA)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF)),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid password";
                        }
                        return null;
                      },
                      // keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Confirm New Password",
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1.5,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1.5, color: Color(0xFFFAFAFA)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 25,
              ),
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                    );
                  }
                },
                child: Container(
                  child: Center(
                      child: Text("Update Password",
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
            const SizedBox(
              height: 16,
            )
          ]),
        ),
      ),
    );
  }
}
