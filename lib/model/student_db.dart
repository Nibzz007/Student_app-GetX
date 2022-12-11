import 'package:hive/hive.dart';
part 'student_db.g.dart';

@HiveType(typeId: 1)
class Student extends HiveObject {
  Student(
      {this.id,
      required this.image,
      required this.name,
      required this.age,
      required this.domain,
      required this.number});

      @HiveField(0)
      int? id;

      @HiveField(1)
      final String image;

      @HiveField(2)
      final String name;

      @HiveField(3)
      final String age;

      @HiveField(4)
      final String domain;

      @HiveField(5)
      final String number;


}
