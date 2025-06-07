import 'package:finance_app/constants/colors.dart';
import 'package:finance_app/models/expense_model.dart';
import 'package:finance_app/models/income_model.dart';
import 'package:finance_app/models/user_models.dart';
import 'package:finance_app/screens/add_expense.dart';
import 'package:finance_app/screens/add_income.dart';
import 'package:finance_app/screens/home.dart';
import 'package:finance_app/screens/list_exp_transactions.dart';
import 'package:finance_app/screens/list_income_transaction.dart';
import 'package:finance_app/screens/login.dart';
import 'package:finance_app/screens/profile.dart';
import 'package:finance_app/screens/register.dart';
import 'package:finance_app/screens/splash_screen.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:finance_app/services/fin_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelsAdapter());
  Hive.registerAdapter(IncomeModelAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());

  await AuthService().openBox();
  await FinService().openExpenseBox();
  await FinService().openIncomBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => FinService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            displaySmall: TextStyle(color: Colors.white, fontSize: 17),
          ),
          scaffoldBackgroundColor: ScaffoldColor,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          'login': (context) => const Login(),
          'register': (context) => const Register(),
          'home': (context) => const Home(),
          'addExpense': (context) => AddExpense(),
          'addIncome': (context) => AddIncome(),
          'profile': (context) => Profile(),
          'listExpTransactions': (context) => ListExpTransactions(),
          'listIncomeTransactions': (context) => ListIncomeTransactions(),



        },
      ),
    );
  }
}
