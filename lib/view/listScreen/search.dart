import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/constants/size/sizedBox.dart';
import 'package:student_app/constants/style/style.dart';
import 'package:student_app/controller/student_controller.dart';
import 'package:student_app/model/student_db.dart';
import 'package:student_app/view/studentDetails/student_details.dart';

final StudentController scontroller = Get.put(StudentController());

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Student> searched = scontroller.list
        .where(
          (element) => element.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return Scaffold(
      body: searched.isEmpty
          ? const Center(
              child: Text('No data found'),
            )
          : Column(
              children: [
                kHeight25,
                ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: FileImage(
                            File(searched[index].image),
                          ),
                          child: Container(
                            height: 150,
                          ),
                        ),
                        onTap: (() {
                          Get.to(
                            () => ScreenStudentDetails(
                              index: index,
                              dataList: searched[index],
                            ),
                          );
                        }),
                        title: Text(searched[index].name),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 2,
                    );
                  },
                  itemCount: searched.length,
                ),
              ],
            ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Student> searched = scontroller.list
        .where(
          (element) => element.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return Scaffold(
      body: searched.isEmpty
          ? const Center(
              child: Text('No data found'),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: FileImage(
                          File(searched[index].image),
                        ),
                        child: Container(
                          height: 150,
                        ),
                      ),
                      onTap: (() {
                        Get.to(
                          () => ScreenStudentDetails(
                            index: index,
                            dataList: searched[index],
                          ),
                        );
                      }),
                      title: Text(
                        searched[index].name,
                        style: studentListTitleStyle,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
                itemCount: searched.length,
              ),
            ),
    );
  }
}
