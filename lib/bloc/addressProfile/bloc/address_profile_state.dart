part of 'address_profile_bloc.dart';

abstract class AddressProfileState extends Equatable {
  const AddressProfileState();
  
  @override
  List<Object> get props => [];
}

class AddressProfileInitial extends AddressProfileState {}

class AddressLoading extends AddressProfileState {}

class AddressLoaded extends AddressProfileState {
  const AddressLoaded(this.listProvince, this.listDistrict, this.listWard, this.isCheck);
  final List<Province> listProvince;
  final List<District> listDistrict;
  final List<Ward> listWard;
  final bool isCheck;
  @override
  List<Object> get props => [listProvince,listDistrict,listWard];
}