class Customer{
   String? idUser;
   String? lastName;
   String? firstName;
   String? dateOfbirth;
   String? email;
   String? phone;
   String? gender;
   String? image;
  Customer({this.idUser, this.image, this.lastName,  this.firstName,  this.dateOfbirth,  this.email,  this.phone,  this.gender});
  Map<String, dynamic> toJson() => {
        'lastName': lastName,
        'firstName': firstName,
        'dateOfbirth': dateOfbirth,
        'email': email,
        'phone': phone,
        'gender': gender,
        'image': image,
        'idUser':idUser
      };
  Customer.fromJson(Map<String, dynamic> json){
        idUser: json['idUser'];
        image: json['image'];
        lastName: json['lastName'];
        firstName: json['firstName'];
        dateOfbirth: json['dateOfbirth'];
        email: json['email'];
        phone: json['phone'];
        gender: json['gender'];  
  }
}