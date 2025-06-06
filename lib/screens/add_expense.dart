import 'package:finance_app/constants/category.dart';
import 'package:finance_app/widgets/custom_text_form_fields.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  TextEditingController categoryEditingController;
   AddExpense({super.key, required this.categoryEditingController});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final eCategory = expenseCategories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        
      ),
    );
  }
}