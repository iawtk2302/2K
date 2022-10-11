class Customer{
  final String id;
  final String lastName;
  final String firstName;
  final String dateOfbirth;
  final String email;
  final String phone;
  final String gender;
  final String image;
  Customer({required this.id,required this.image,required this.lastName, required this.firstName, required this.dateOfbirth, required this.email, required this.phone, required this.gender});
  Map<String, dynamic> toJson() => {
        'lastName': lastName,
        'firstName': firstName,
        'dateOfbirth': dateOfbirth,
        'email': email,
        'phone': phone,
        'gender': gender,
        'image': image,
      };
}