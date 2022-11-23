import 'package:equatable/equatable.dart';

class Address extends Equatable{
  Address(this.idAddress, this.idUser, this.name, this.phone, this.province, this.provinceID, this.district, this.districtID, this.ward, this.wardCode, this.detail, this.isDefault);

  Address.fromJson(Map<String, dynamic> json){
        idAddress=json['idAddress'];
        idUser= json['idUser'];
        name= json['name'];
        phone= json['phone'];
        province= json['province'];
        provinceID= json['provinceID'];
        district= json['district'];
        districtID= json['districtID'];
        ward= json['ward'];
        wardCode= json['wardCode'];
        detail= json['detail'];
        isDefault= json['isDefault'];
  }
  String? idAddress;
  String? idUser;
  String? name;
  String? phone;
  String? province;
  int? provinceID;
  String? district;
  int? districtID;
  String? ward;
  String? wardCode;
  String? detail;
  bool? isDefault;

  Map<String, Object?> toJson() {
    return {
      'idAddress':idAddress,
      'idUser': idUser,
      'name': name,
      'phone': phone,
      'province': province,
      'provinceID': provinceID,
      'district': district,
      'districtID': districtID,
      'ward': ward,
      'wardCode': wardCode,
      'detail': detail,
      'isDefault': isDefault
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [idAddress,idUser,name,phone,province,provinceID,district,districtID,ward,wardCode,detail,isDefault];
}
