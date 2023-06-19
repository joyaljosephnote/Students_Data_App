import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String mobileNumber;

  @HiveField(4)
  final String images;

  StudentModel(
      {this.id,
      required this.name,
      required this.age,
      required this.mobileNumber,
      required this.images});
}
