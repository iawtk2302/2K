import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/bloc/address/addressReponsitory.dart';
import 'package:sneaker_app/bloc/address/address_bloc.dart';
import 'package:sneaker_app/bloc/addressProfile/bloc/address_profile_bloc.dart';
import 'package:sneaker_app/screen/EditAddress.dart';
import 'package:sneaker_app/widget/CustomAppBar.dart';
import 'package:sneaker_app/widget/ItemAddress.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/custom_button.dart';

import '../model/address.dart';
import '../router/routes.dart';

class ChooseAddressProfilePage extends StatefulWidget {
  const ChooseAddressProfilePage({super.key});

  @override
  State<ChooseAddressProfilePage> createState() => _ChooseAddressProfilePageState();
}

class _ChooseAddressProfilePageState extends State<ChooseAddressProfilePage> {
  @override
  void initState() {
   
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Stream<QuerySnapshot> collectionStream = FirebaseFirestore.instance.collection('Address').snapshots();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "Shipping Address".tr,onTap: (){
        // BlocProvider.of<OrderBloc>(context).add(ChooseAddress(address!));
        Navigator.pop(context);
      },),
      body:StreamBuilder<QuerySnapshot>(
        stream: collectionStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) { 
          if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          List<Address> temp= snapshot.data!.docs.where((element) => element.get("idUser")==FirebaseAuth.instance.currentUser!.uid).map((DocumentSnapshot e) {
            Map<String, dynamic> temp = e.data()! as Map<String, dynamic>;
            return Address.fromJson(temp);
          }).toList()..sort((a, b) {
            if(a.isDefault!){
              return 0;
            }
            else {
              return 1;
            }
          },);
          return SingleChildScrollView(
                child: Container(
                  // color: Color(0xFFFBFBFB),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: temp.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: ItemAddress(
                                address: temp[index],
                                icon: IconButton(icon:
                                 Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.pushNamed(context, Routes.editAddress,arguments: temp[index]);
                                  },
                                ),
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CustomElevatedButton(
                          text: "Add New Address".tr,
                          onTap: () {
                            Navigator.pushNamed(context, Routes.addAddress);
                          },
                          color: Color(0xFFE6E6E6),
                          colorText: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
        }
        return Container();
         },
      
      )
    );
  }
}
