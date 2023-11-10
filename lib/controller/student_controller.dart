import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/model/student_db.dart';
import '../main.dart';

class StudentController extends GetxController {
  @override
  void onReady() {
    list.clear();
    list.addAll(studentDb.values);
    update();
    super.onReady();
  }

  String? pickedImage;
  String? pickedImageFromGallery;
  List<Student> list = <Student>[];

  Future<void> getCamera() async {
    final XFile? images =
        await ImagePicker().pickImage(source: ImageSource.camera);
    pickedImageFromGallery = images!.path;
    update();
  }

  Future<void> getGallery() async {
    final XFile? images =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    pickedImageFromGallery = images!.path;
    update();
  }

  Future<void> addStudentList(Student data) async {
    final int id = await studentDb.add(data);
    final Student studentData = Student(
      id: id,
      image: data.image,
      name: data.name,
      age: data.age,
      domain: data.domain,
      number: data.number,
    );
    await studentDb.put(id, studentData);
    list.add(studentData);
    update();
  }

  void deleteStudent(id, index) {
    studentDb.delete(id);
    list.removeAt(index);
    update();
  }

  Future<void> updateStudent(Student edit, int index) async {
    await studentDb.put(studentController.list[index].id, edit);
    list.removeAt(index);
    list.insert(index, edit);
    update();
  }
}
