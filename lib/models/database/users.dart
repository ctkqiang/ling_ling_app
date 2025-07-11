class Users {
  final int id;
  final String name;

  Users({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(id: map['id'], name: map['name']);
  }

  @override
  String toString() {
    return 'Users(id: $id, name: $name)';
  }
}
