import 'package:uuid/uuid.dart';

class Contacts {
  String? name;
  String? email;
  String? phoneNumber;
  String? country;
  final String uniqueScammerId;

  Contacts({
    this.name,
    this.email,
    this.phoneNumber,
    this.country,
    String? uniqueScammerId,
  }) : uniqueScammerId = uniqueScammerId ?? const Uuid().v4();

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
    name: json['name'],
    email: json['email'],
    phoneNumber: json['phoneNumber'],
    country: json['country'],
    uniqueScammerId: json['uniqueScammerId'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'country': country,
    'uniqueScammerId': uniqueScammerId,
  };

  @override
  String toString() => 'Contacts($name, $phoneNumber, $uniqueScammerId)';
}
