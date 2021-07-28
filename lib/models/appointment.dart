import 'package:attendance/models/student.dart';

class AppointmentModel {
  int? id;
  String? time;
  String? date;
  List<StudentModel>? students;

  AppointmentModel({this.id, this.time, this.students});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    date = json['date'];
    students = List<StudentModel>.from(
      json['students'].map(
        (model) => StudentModel.fromJson(model),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['date'] = this.date;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
