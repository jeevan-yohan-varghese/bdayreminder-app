class Person {
  String name;
  String dob;
  String id;

  Person({required this.name, required this.dob, required this.id});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(name: json['name'], dob: json['dob'], id: json['_id']);
  }
}
