part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class LoadAddress extends AddressEvent {
  const LoadAddress();

  @override
  List<Object> get props => [];
}

class ChooseProvince extends AddressEvent {
  const ChooseProvince(this.province);
  final Province province;
  @override
  List<Object> get props => [province];
}

class ChooseDistrict extends AddressEvent {
  const ChooseDistrict(this.district);
  final District district;
  @override
  List<Object> get props => [district];
}

class AddAddress extends AddressEvent {
  const AddAddress(this.name, this.phone, this.province, this.district, this.ward, this.detail, this.isDefault);
  final String name;
  final String phone;
  final Province province;
  final District district;
  final Ward ward;
  final String detail;
  final bool isDefault;
  @override
  List<Object> get props => [name,phone,province,district,ward,detail,isDefault];
}
