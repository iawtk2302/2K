import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/bloc/address/address_bloc.dart';
import 'package:sneaker_app/bloc/address/addressReponsitory.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../bloc/address/address_state.dart';
import '../bloc/order/order_bloc.dart';
import '../widget/InfoInput.dart';
import '../widget/custom_button.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _detailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Province? province;
  District? district;
  Ward? ward;
  bool isDefault = false;

  @override
  void initState() {
    BlocProvider.of<AddressBloc>(context).add(LoadAddress());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is AddressLoading) {
          return Loading();
        } else if (state is AddressLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
                onPressed: () {
                  BlocProvider.of<OrderBloc>(context).add(LoadOrder());
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "New Address",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InfoInput(
                        hintText: "Name",
                        controller: _nameController,
                        readOnly: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                      InfoInput(
                          hintText: "Phone",
                          controller: _phoneController,
                          readOnly: false,
                          keyboardType: TextInputType.phone,
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
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                            width: size.width * 0.85,
                            height: 60,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Province>(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Province"),
                                  ),
                                  iconSize: 32,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  isExpanded: true,
                                  onChanged: (value) {
                                    BlocProvider.of<AddressBloc>(context)
                                        .add(ChooseProvince(value!));
                                    setState(() {
                                      province = value;
                                      district = null;
                                    });
                                  },
                                  value: province,
                                  items: state.listProvince
                                      .map<DropdownMenuItem<Province>>(
                                          (Province value) {
                                    return DropdownMenuItem<Province>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child:
                                            Text(value.provinceName.toString()),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                            width: size.width * 0.85,
                            height: 60,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<District>(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("District"),
                                  ),
                                  iconSize: 32,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  isExpanded: true,
                                  onChanged: (value) {
                                    BlocProvider.of<AddressBloc>(context)
                                        .add(ChooseDistrict(value!));
                                    setState(() {
                                      district = value;
                                      ward = null;
                                    });
                                  },
                                  value: district,
                                  items: state.listDistrict
                                      .map<DropdownMenuItem<District>>(
                                          (District value) {
                                    return DropdownMenuItem<District>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child:
                                            Text(value.districtName.toString()),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                            width: size.width * 0.85,
                            height: 60,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Ward>(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Ward"),
                                  ),
                                  iconSize: 32,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  isExpanded: true,
                                  onChanged: (value) {
                                    setState(() {
                                      ward = value!;
                                    });
                                  },
                                  value: ward,
                                  items: state.listWard
                                      .map<DropdownMenuItem<Ward>>(
                                          (Ward value) {
                                    return DropdownMenuItem<Ward>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(value.wardName.toString()),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),
                      ),
                      InfoInput(
                        hintText: "Detail",
                        controller: _detailController,
                        readOnly: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: SizedBox(
                          width: size.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Set as default',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Switch(
                                activeColor: Colors.black,
                                onChanged: (bool value) {
                                  setState(() {
                                    isDefault = value;
                                  });
                                },
                                value:
                                    state.isCheck == false ? true : isDefault,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                        child: CustomElevatedButton(
                            color: Colors.black,
                            text: "Submit",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AddressBloc>(context).add(
                                  AddAddress(
                                      _nameController.text,
                                      _phoneController.text,
                                      province!,
                                      district!,
                                      ward!,
                                      _detailController.text,
                                      state.isCheck == false
                                          ? true
                                          : isDefault));
                                          }
                            }),
                      )
                    ],
                  ),
                ),
              )),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
