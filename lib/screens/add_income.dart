import 'package:finance_app/constants/category.dart';
import 'package:finance_app/models/income_model.dart';
import 'package:finance_app/services/fin_service.dart';
import 'package:finance_app/widgets/custom_button.dart';
import 'package:finance_app/widgets/custom_text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
   late TextEditingController descriptionController;
  late TextEditingController amountController;

  final iCategory = incomeCategories;
  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    final finService = Provider.of<FinService>(context);
    final _incomeKey = GlobalKey<FormState>();
final String? id = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(title: Text("Add Income")),
      body: Form(
        key: _incomeKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCategory,
                  hint: Text("Select  Category"),
                  underline: SizedBox(),
                  items: iCategory.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextFormFields(
                 validator: (value){
                  if (value == null || value.isEmpty){
                    return "Enter description";
                  }
                },
                textEditingController: descriptionController,
                hintText: "Description",
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextFormFields(
                 keyboardType: TextInputType.numberWithOptions(),
                 validator: (value){
                  if (value == null || value.isEmpty){
                    return "Enter amount";
                  }
                },
                textEditingController: amountController,
                hintText: "Amount",
                obscureText: false,
              ),
            ),
            CustomButton(
              onPressed: () async {
                var uuid = Uuid().v1();
                if (_incomeKey.currentState?.validate() ?? false) {
                  IncomeModel income = IncomeModel(
                    id: uuid,
                    uid: id!,
                    amount: double.parse(amountController.text),
                    category: selectedCategory.toString(),
                    description: descriptionController.text,
                    createdAT: DateTime.now(),
                  );
                    await finService.addIncome(income);
                  Navigator.pop(context);

                }
              },
              subject: "Add Income",
            ),
          ],
        ),
      ),
    );
  }
}