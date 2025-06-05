import 'package:hive/hive.dart';

part 'user_models.g.dart';

@HiveType(typeId: 0)
class UserModels extends HiveObject {
  @HiveField(0)
  late String email;
  @HiveField(1)
  late String password;
  @HiveField(2)
  late String name;
  @HiveField(3)
  late String phonenumber;
  @HiveField(4)
  late int status;

  UserModels({
    required this.email,
    required this.name,
    required this.password,
    required this.phonenumber,
    required this.status,
  });
}
