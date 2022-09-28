import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../router/routes.dart';
import '../service/FirebaseService.dart';
import '../widget/AuthButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool isHiddenPassword = true;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Logo_Light.png",
                  height: 200,
                  width: 200,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom:30),
                  child: Text("Create Your Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                                if(value == null ||value.isEmpty ||!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
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
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 20),
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
                        Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ThemeData().colorScheme.copyWith(
                                  primary: Colors.black,
                                ),
                          ),
                          child: SizedBox(
                            width: size.width * 0.8,
                            child: TextFormField(
                              controller: _passController,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 8){
                                  return "Password at least 8 characters";
                                }
                              },
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Password",
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isHiddenPassword = !isHiddenPassword;
                                      });
                                    },
                                    child: Icon(
                                      isHiddenPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
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
                                  fillColor: const Color(0xFFFAFAFA),
                                  ),
                              obscureText: isHiddenPassword,
                              obscuringCharacter: '●',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ThemeData().colorScheme.copyWith(
                                  primary: Colors.black,
                                ),
                          ),
                          child: SizedBox(
                            width: size.width * 0.8,
                            child: TextFormField(
                              controller: _confirmPassController,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 8){
                                  return "Password at least 8 characters";
                                }
                                else if(value!=_passController.text){
                                  return "The password confirmation does not match";
                                }
                              },
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Confirm Password",
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isHiddenPassword = !isHiddenPassword;
                                      });
                                    },
                                    child: Icon(
                                      isHiddenPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
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
                                  fillColor: const Color(0xFFFAFAFA),
                                  ),
                              obscureText: isHiddenPassword,
                              obscuringCharacter: '●',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () async{
                      if (_formKey.currentState!.validate()) {
                        showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.black),),);
                        FirebaseService().createAccount(_emailController.text, _passController.text, context);
                      }
                    },
                    child: Container(                
                      child: Center(
                          child: Text("Sign Up",
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 1,
                        width: 80,
                        color: const Color(0xFF616161),
                      ),
                      const Text(
                        "Or continue with",
                        style: TextStyle(color: Color(0xFF616161)),
                      ),
                      Container(
                        height: 1,
                        width: 80,
                        color: const Color(0xFF616161),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthButton(
                        image: "assets/images/logoGG.png",
                        onTap: () => signInWithGG(context),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      AuthButton(
                        image: "assets/images/logoFB.png",
                        onTap: () => signInWithFB(context),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
signInWithGG(BuildContext context) async {
  await FirebaseService().signInWithGoole();
  if (FirebaseAuth.instance.currentUser != null)
    {
    // await FirebaseFirestore.instance
    // .collection('User')
    // .doc(FirebaseAuth.instance.currentUser!.uid)
    // .get()
    // .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Document data: ${documentSnapshot.data()}');
    //     Navigator.pushReplacementNamed(context, Routes.main);
    //   } else {
    //     Navigator.pushReplacementNamed(context, Routes.fillProfilePage);
    //   }
    // });
    Navigator.pushReplacementNamed(context, Routes.main);
  }
}

signInWithFB(BuildContext context) async {
  await FirebaseService().signInWithFB();
  if (FirebaseAuth.instance.currentUser != null){
    // await FirebaseFirestore.instance
    // .collection('User')
    // .doc(FirebaseAuth.instance.currentUser!.uid)
    // .get()
    // .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Document data: ${documentSnapshot.data()}');
    //     Navigator.pushReplacementNamed(context, Routes.main);
    //   } else {
    //     Navigator.pushReplacementNamed(context, Routes.fillProfilePage);
    //   }
    // });
    Navigator.pushReplacementNamed(context, Routes.main);
  }
}