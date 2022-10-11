import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sneaker_app/service/FirebaseService.dart';
import 'package:sneaker_app/widget/CustomButton.dart';
import 'package:sneaker_app/widget/InfoInput.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/User.dart';
import '../router/routes.dart';

class FillProfilePage extends StatefulWidget {
  const FillProfilePage({super.key});

  @override
  State<FillProfilePage> createState() => _FillProfilePageState();
}

const List<String> gender = <String>['Male', 'Female'];

class _FillProfilePageState extends State<FillProfilePage> {
  String dropdownValue = gender.first;
  File? _file;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dateOfbirth = "Date of Birth";
  final storage = FirebaseStorage.instance.ref();
  final id = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: _goback,
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 42,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Fill Your Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        backgroundImage: _file == null
                            ? const AssetImage("assets/images/emptyAvatar1.jpg")
                            : Image.file(
                                _file!,
                                fit: BoxFit.cover,
                              ).image,
                      ),
                    ),
                    Positioned(
                        right: 25,
                        bottom: 30,
                        child: InkWell(
                          onTap: _editAvatar,
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Icon(Icons.edit,
                                  color: Colors.white, size: 20),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ))
                  ],
                ),
                InfoInput(
                  hintText: "First Name",
                  controller: _firstNameController,
                  readOnly: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                InfoInput(
                  hintText: "Last Name",
                  controller: _lastNameController,
                  readOnly: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),
                InfoInput(
                  hintText: dateOfbirth,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: _getDateOfBirth,
                  ),
                  enabled: true,
                  readOnly: true,
                ),
                InfoInput(
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const IconButton(
                    icon: Icon(Icons.email),
                    onPressed: null,
                  ),
                  readOnly: false,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                ),
                InfoInput(
                  hintText: "Phone",
                  readOnly: false,
                  suffixIcon: const IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: null,
                  ),
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    if (!RegExp(r"(84|0[3|5|7|8|9])+([0-9]{8})")
                        .hasMatch(value)) {
                      return "Invalid phone";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      width: size.width * 0.85,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            iconSize: 32,
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            value: dropdownValue,
                            items: gender
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "Submit",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _submit();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editAvatar() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    height: 6,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const Text(
                  "Upload Photo",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Text("Choose Your Profile Picture"),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "Take Photo",
                  onTap: _getImageCamera,
                ),
                CustomButton(
                  text: "Choose From Library",
                  onTap: _getImageGallery,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _getImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTempory = File(image.path);
    setState(() {
      _file = imageTempory;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future _getImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTempory = File(image.path);
    setState(() {
      _file = imageTempory;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future _getDateOfBirth() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: Colors.black,
                  ),
            ),
            child: child!);
      },
    );
    if (date == null) {
      return;
    } else {
      setState(() {
        dateOfbirth = '${date.day}/${date.month}/${date.year}';
      });
    }
  }

  Future _submit() async {
    try {
      final task = await storage.child("$id.jpg").putFile(_file!);
      final linkImage = await task.ref.getDownloadURL();
      final user = Customer(
          id: id,
          dateOfbirth: dateOfbirth,
          email: _emailController.text.trim(),
          firstName: _firstNameController.text.trim(),
          gender: dropdownValue,
          image: linkImage,
          lastName: _lastNameController.text.trim(),
          phone: _phoneController.text);
      await firestore.collection('User').doc(id).set(user.toJson());
      Navigator.pushReplacementNamed(context, Routes.main);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future _goback() async {
    await FirebaseService().signOut();
    Navigator.pushReplacementNamed(context, Routes.login);
  }
}
