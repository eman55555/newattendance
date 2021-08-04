import 'year.dart';

class SubjectModelSimple {
  int? id;
  String? name;

  SubjectModelSimple({this.id, this.name});

  SubjectModelSimple.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}
