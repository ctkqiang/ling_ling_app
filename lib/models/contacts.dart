class Contacts {
  String? name;
  String? email;
  String? phoneNumber;
  String? country;

  Contacts({this.name, this.email, this.phoneNumber, this.country});

  Contacts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['country'] = country;
    return data;
  }
}
