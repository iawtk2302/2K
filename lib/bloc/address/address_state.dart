

import 'package:equatable/equatable.dart';

import 'addressReponsitory.dart';

abstract class AddressState extends Equatable {
  const AddressState();
  
  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  const AddressLoaded(this.listProvince, this.listDistrict, this.listWard, this.isCheck);
  final List<Province> listProvince;
  final List<District> listDistrict;
  final List<Ward> listWard;
  final bool isCheck;
  @override
  List<Object> get props => [listProvince,listDistrict,listWard];
}