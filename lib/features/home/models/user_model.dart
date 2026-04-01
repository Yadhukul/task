import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  String? imagePath;

  @HiveField(3)
  DateTime createdAt;

  UserModel({
    required this.name,
    required this.age,
    this.imagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  UserModel copyWith({
    String? name,
    int? age,
    String? imagePath,
    DateTime? createdAt,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
