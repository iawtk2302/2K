import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/service/FirebaseService.dart';
import 'package:sneaker_app/widget/AuthButton.dart';
import 'package:sneaker_app/widget/Loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool validateEmail = true;
  bool validatePass = true;
  bool isChecked = false;
  late Box box;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    box = await Hive.openBox('login');
    getData();
  }

  void getData() async {
    if (box.get('email') != null && box.get('pass') != null) {
      _emailController.text = box.get('email');
      _passController.text = box.get('pass');
      setState(() {
        isChecked = box.get('remember');
      });
    }
  }

  rememberMe() {
    if (isChecked) {
      box.put('email', _emailController.text);
      box.put('pass', _passController.text);
      box.put('remember', isChecked);
    } else {
      box.put('email', null);
      box.put('pass', null);
      box.put('remember', isChecked);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? Scaffold(
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
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Login To Your Account",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: 1.5,
                                            color: Color(0xFFFAFAFA)),
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
                                    if (value!.isEmpty || value.length < 8) {
                                      return "Password at least 8 characters";
                                    }
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20),
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
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: isChecked,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              }),
                          const Text(
                            "Remember me",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: size.width * 0.08)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signInWithEmailPassword(
                                context,
                                _emailController.text.trim(),
                                _passController.text.trim());
                            rememberMe();
                          }
                        },
                        child: Container(
                          height: 50,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black),
                          child: const Center(
                              child: Text("Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.forgot);
                        },
                        child: const Text(
                          "Forgot the password?",
                          style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 15),
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
                            "Don't have an account? ",
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.register);
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))
        : const Loading();
  }

  signInWithEmailPassword(
      BuildContext context, String email, String password) async {
    // showDialog(
    //   context: context,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(
    //       color: Colors.black,
    //     ),
    //   ),
    // );
    setState(() {
      isLoading = true;
    });
    await FirebaseService().signInWithEmailPassword(email, password);
    // ignore: use_build_context_synchronously
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified) {
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
    } else {
      Navigator.of(context).pop();
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please verify your email!'),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

signInWithGG(BuildContext context) async {
  await FirebaseService().signInWithGoole();
  if (FirebaseAuth.instance.currentUser != null) {
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
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, Routes.main);
  }
}

signInWithFB(BuildContext context) async {
  await FirebaseService().signInWithFB();
  if (FirebaseAuth.instance.currentUser != null) {
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
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, Routes.main);
  }
}
