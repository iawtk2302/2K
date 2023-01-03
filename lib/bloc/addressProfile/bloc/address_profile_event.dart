part of 'address_profile_bloc.dart';

abstract class AddressProfileEvent extends Equatable {
  const AddressProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadAddressProfile extends AddressProfileEvent {
  const LoadAddressProfile(this.district, this.province);
  final District district;
  final Province province;
  @override
  List<Object> get props => [];
}

class Clear extends AddressProfileEvent {
  const Clear();
  @override
  List<Object> get props => [];
}


class ChooseProvince extends AddressProfileEvent {
  const ChooseProvince(this.province);
  final Province province;
  @override
  List<Object> get props => [province];
}

class ChooseDistrict extends AddressProfileEvent {
  const ChooseDistrict(this.district);
  final District district;
  @override
  List<Object> get props => [district];
}

class AddAddress extends AddressProfileEvent {
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

class UpdateAddress extends AddressProfileEvent{
  const UpdateAddress(this.address);
  final Address address;
  @override
  List<Object> get props => [address];
}