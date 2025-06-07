import 'package:finance_app/models/expense_model.dart';
import 'package:finance_app/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FinService extends ChangeNotifier {
  Box<IncomeModel>? _incomBox;
  Box<ExpenseModel>? _expense;

  double _totalIncome = 0.0;
  double _totalExpense = 0.0;

  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;

  Future<void> openIncomBox() async {
    _incomBox = await Hive.openBox('income');
  }

  Future<void> openExpenseBox() async {
    _expense = await Hive.openBox('expense');
  }

  Future<void> addIncome(IncomeModel income) async {
    if (_incomBox == null) {
      await openIncomBox();
    }
    await _incomBox!.add(income);
    await calculatetotalIncome(income.uid);
    notifyListeners();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    if (_expense == null) {
      await openIncomBox();
    }
    await _expense!.add(expense);
    await calculatetotalExpense(expense.uid);
    notifyListeners();
  }

  Future<void> calculatetotalIncome(String uid) async {
    if (_incomBox == null) {
      await openIncomBox();
    }
    final List<IncomeModel> incomes = await getAllIncome(uid);
    _totalIncome = incomes.fold(
      0.0,
      (previousValue, income) => previousValue + income.amount,
    );
  }

  Future<List<IncomeModel>> getAllIncome(String uid) async {
    if (_incomBox == null) {
      await openIncomBox();
    }
    return _incomBox!.values.where((income) => income.uid == uid).toList();
  }

  Future<void> calculatetotalExpense(String uid) async {
    if (_expense == null) {
      await openExpenseBox();
    }
    final List<ExpenseModel> expenses = await getAllExpense(uid);
    _totalExpense = expenses.fold(
      0.0,
      (previousValue, expense) => previousValue + expense.amount,
    );
  }

  Future<List<ExpenseModel>> getAllExpense(String uid) async {
    if (_expense == null) {
      await openExpenseBox();
    }
    return _expense!.values.where((expense) => expense.uid == uid).toList();
  }
}
