import 'package:hive/hive.dart';
part 'income_model.g.dart';

@HiveType(typeId: 2)
class IncomeModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String uid;
  @HiveField(2)
  late double amount;
  @HiveField(3)
  late String category;
  @HiveField(4)
  late String description;
  @HiveField(5)
  late DateTime createdAT;

  IncomeModel({
    required this.id,
    required this.uid,
    required this.amount,
    required this.category,
    required this.description,
    required this.createdAT,
  });
}
