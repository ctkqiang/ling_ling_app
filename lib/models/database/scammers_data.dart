class ScammersData {
  final int? id;
  final String name;
  final String phoneNumber;
  final String reporter;
  final String date;
  final int vote;

  ScammersData({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.reporter,
    required this.date,
    required this.vote,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'reporter': reporter,
      'date': date,
      'vote': vote,
    };
  }

  factory ScammersData.fromMap(Map<String, dynamic> map) {
    return ScammersData(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      reporter: map['reporter'],
      date: map['date'],
      vote: map['vote'],
    );
  }

  List<ScammersData> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => ScammersData.fromMap(map)).toList();
  }
}
