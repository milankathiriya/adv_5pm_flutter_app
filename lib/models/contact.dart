import 'dart:io';

class Contact {
  String fullName;
  String email;
  String phoneNumber;
  File? image;

  Contact({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.image,
  });
}
