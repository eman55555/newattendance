import 'package:attendance/constants.dart';
import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Student_manager.dart';
import 'package:attendance/models/group.dart';
import 'package:attendance/models/groupmodelsimple.dart';
import 'package:attendance/screens/Single_Student.dart/components/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contacts_widget.dart';

class Student_details extends StatelessWidget {
  final String? stu_id;
  Student_details({
    Key? key,
    required this.size,
    this.stu_id,
  }) : super(key: key);

  final Size size;

  // List<String> teachers_Student = ['عبد المعز', 'احمد محمد'];
  void _modalBottomSheetMenu(
    BuildContext context,
    List<GroupModelSimple> groups,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 250.0,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kbackgroundColor1,
                      ),
                      child: Center(
                        child: Text(
                          'مجموعات الطالب',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'GE-bold',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: (groups == null || groups.isEmpty)
                            ? Center(
                                child: Container(
                                  child: Text(
                                    'لا يوجد مجموعات',
                                    style: TextStyle(fontFamily: 'GE-light'),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: groups.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Provider.of<AppStateManager>(context,
                                            listen: false)
                                        .goToSingleStudentAttend(true);
                                  },
                                  child: ListTile(
                                    trailing: Text(
                                      '${groups[index].name}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'GE-light',
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${groups[index].teacher!.name}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'GE-light',
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: kbackgroundColor3,
                                      radius: 10,
                                    ),
                                    title: Text(
                                      '${groups[index].subject!.name}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'GE-bold',
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: Consumer<StudentManager>(
        builder: (builder, studentmanager, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Name(
                  title: 'الاسم :',
                  size: size,
                  name: studentmanager.singleStudent!.name!),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          'رقم التليفون',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'GE-bold',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: size.width / 3,
                        child: Text(
                          studentmanager.singleStudent!.phone!,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Contacts_widget(size: size),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Text(
                      //رقم تليفون ولى الامر
                      'رقم تليفون ولى الامر',
                      style: TextStyle(fontSize: 16, fontFamily: 'GE-bold'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: size.width / 3,
                      child: Text(
                        studentmanager.singleStudent!.parentPhone!,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
              Contacts_widget(size: size),
              GestureDetector(
                onTap: () => _modalBottomSheetMenu(
                  context,
                  studentmanager.singleStudent!.groups!,
                ),
                child:
                    Name(size: size, name: 'عرض مجموعات الطالب', arrow: true),
              ),
              Name(
                  title: 'المحافظه :',
                  size: size,
                  name: studentmanager.singleStudent!.city!.name!),
              Name(
                title: 'المدرسه :',
                size: size,
                name: studentmanager.singleStudent!.school.toString(),
              ),
              Name(
                  title: 'الشعبه :',
                  size: size,
                  name: studentmanager.singleStudent!.studyType.toString()),
              Name(size: size, name: 'السداد'),
              Divider(
                thickness: 2,
              ),
              Name(
                  size: size,
                  name: studentmanager.singleStudent!.note == null
                      ? 'لا يوجد ملاحظات'
                      : studentmanager.singleStudent!.note.toString()),
            ],
          ),
        ),
      )),
    );
  }
}
