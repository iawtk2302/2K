import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/address.dart';
import '../../address/addressReponsitory.dart';

part 'address_profile_event.dart';
part 'address_profile_state.dart';

class AddressProfileBloc extends Bloc<AddressProfileEvent, AddressProfileState> {
  AddressProfileBloc() : super(AddressProfileLoading()) {
    on<LoadAddressProfile>((event, emit) async {
      emit(AddressProfileLoading());
      List<Province>listProvince=await AddressReponsitory().getProvince(); 
      List<District>listDistrict=await AddressReponsitory().getDistrict(event.province.provinceID!);
      List<Ward>listWard=await AddressReponsitory().getWard(event.district.districtID!);
      // List<Address>listAddress=await AddressReponsitory().getDataAddress();
      bool isCheck=await AddressReponsitory().checkHaveAddress();
      print(listProvince.toString());
      emit(AddressProfileLoaded(listProvince,listDistrict,listWard,isCheck));
    });
    on<Clear>((event, emit) async {
      emit(AddressProfileLoading());
      List<Province>listProvince=await AddressReponsitory().getProvince(); 
      List<District>listDistrict=[];
      List<Ward>listWard=[];
      // List<Address>listAddress=await AddressReponsitory().getDataAddress();
      bool isCheck=await AddressReponsitory().checkHaveAddress();
      print(listProvince.toString());
      emit(AddressProfileLoaded(listProvince,listDistrict,listWard,isCheck));
    });
    on<ChooseProvince>((event, emit) async {
      final state= this.state as AddressProfileLoaded;
      List<Province>listProvince=state.listProvince; 
      List<District>listDistrict=await AddressReponsitory().getDistrict(event.province.provinceID!);
      print(listDistrict.toString());
      List<Ward>listWard=[];
      bool isCheck=state.isCheck;
      emit(AddressProfileLoaded(listProvince,listDistrict,listWard,isCheck,));
    });
    on<ChooseDistrict>((event, emit) async {
      final state= this.state as AddressProfileLoaded;
      emit(AddressProfileLoading());
      List<Province>listProvince=state.listProvince; 
      List<District>listDistrict=state.listDistrict;
      List<Ward>listWard=await AddressReponsitory().getWard(event.district.districtID!);
      bool isCheck=state.isCheck;
      emit(AddressProfileLoaded(listProvince,listDistrict,listWard,isCheck,));
    });
    on<AddAddress>((event, emit) async {
      final state= this.state as AddressProfileLoaded;
      Address temp=Address(null,FirebaseAuth.instance.currentUser!.uid,event.name,event.phone,event.province.provinceName,event.province.provinceID,event.district.districtName,event.district.districtID,event.ward.wardName,event.ward.wardCode,event.detail,event.isDefault);
      await AddressReponsitory().addAddress(temp); 
      List<Province>listProvince=state.listProvince; 
      List<District>listDistrict=state.listDistrict;
      List<Ward>listWard=state.listWard;
      bool isCheck=state.isCheck;
      emit(AddressProfileLoaded(listProvince,listDistrict,listWard,isCheck));
    });
    on<UpdateAddress>((event, emit) async {
      final state= this.state as AddressProfileLoaded;
      await AddressReponsitory().updateAddress(event.address);
      emit(AddressProfileLoaded(state.listProvince,state.listDistrict,state.listWard,state.isCheck));
    });
  }
}
