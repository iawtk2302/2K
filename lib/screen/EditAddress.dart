import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/bloc/addressProfile/bloc/address_profile_bloc.dart';
import 'package:sneaker_app/model/address.dart';

import '../bloc/address/addressReponsitory.dart';
import '../widget/InfoInput.dart';
import '../widget/Loading.dart';
import '../widget/custom_button.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key, required this.address});
  final Address address;
  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
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
    // BlocProvider.of<AddressProfileBloc>(context).add(LoadAddressProfile());
    province=Province(int.parse(widget.address.provinceID.toString()),widget.address.province);
    district=District(int.parse(widget.address.districtID.toString()),widget.address.district);
    ward=Ward(widget.address.wardCode,widget.address.ward);
    isDefault=widget.address.isDefault!;
    _nameController.text=widget.address.name!;
    _phoneController.text=widget.address.phone!;
    _detailController.text=widget.address.detail!;
    BlocProvider.of<AddressProfileBloc>(context).add(LoadAddressProfile(district!,province!));
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AddressProfileBloc, AddressProfileState>(
      builder: (context, state) {
        if (state is AddressProfileLoading) {
          return Loading();
        } else if (state is AddressProfileLoaded) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  
                ),
                onPressed: () {
                  BlocProvider.of<AddressProfileBloc>(context).add(Clear());
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Update Address".tr,
               
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
                        hintText: "Name".tr,
                        controller: _nameController,
                        readOnly: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required".tr;
                          }
                          return null;
                        },
                      ),
                      InfoInput(
                          hintText: "Phone".tr,
                          controller: _phoneController,
                          readOnly: false,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required".tr;
                            }
                            if (!RegExp(r"(84|0[3|5|7|8|9])+([0-9]{8})")
                                .hasMatch(value)) {
                              return "Invalid phone".tr;
                            }
                            return null;
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                            width: size.width * 0.85,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Province>(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Province".tr),
                                  ),
                                  iconSize: 32,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  isExpanded: true,
                                  onChanged: (value) async{
                                    BlocProvider.of<AddressProfileBloc>(context).add(ChooseProvince(value!));
                                    print(value);
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
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<District>(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("District".tr),
                                  ),
                                  iconSize: 32,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  isExpanded: true,
                                  onChanged: (value) async{
                                    BlocProvider.of<AddressProfileBloc>(context).add(ChooseDistrict(value!));
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
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Ward>(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Ward".tr),
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
                        hintText: "Detail".tr,
                        controller: _detailController,
                        readOnly: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required".tr;
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: size.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(
                                'Set as default'.tr,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Switch(
                                activeColor: Theme.of(context).textTheme.bodyText1!.color,
                                onChanged:widget.address.isDefault!?null: (bool value) {
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
                      !widget.address.isDefault!?
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: CustomElevatedButton(
                            text: "Delete".tr,
                            onTap: () async{
                              await AddressReponsitory().removeAddress(widget.address);
                            }),
                      ):Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 25),
                        child: CustomElevatedButton(
                            text: "Submit".tr,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Address temp=Address(widget.address.idAddress, widget.address.idUser, _nameController.text, _phoneController.text, province!.provinceName.toString(), province!.provinceID, district!.districtName, district!.districtID, ward!.wardName, ward!.wardCode, _detailController.text,isDefault);
                              BlocProvider.of<AddressProfileBloc>(context).add(UpdateAddress(temp));
                              BlocProvider.of<AddressProfileBloc>(context).add(Clear());
                              Navigator.pop(context);
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
          return Container(
            color: Colors.white,
          );
        }
      },
    );
  }
}