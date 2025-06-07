import 'package:finance_app/constants/colors.dart';
import 'package:finance_app/models/user_models.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:finance_app/services/fin_service.dart';
import 'package:finance_app/widgets/custom_divider.dart';
import 'package:finance_app/widgets/dashboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final finService = Provider.of<FinService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: FutureBuilder<UserModels?>(
        future: authService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              print(snapshot);
              final user = snapshot.data;
              print(user?.id);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<FinService>(
                  context,
                  listen: false,
                ).calculatetotalExpense(user!.id);
              });
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "Welcome!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                "${user!.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                'profile',
                                arguments: [user.id, user.name, user.email],
                              );
                            },
                            child: CircleAvatar(
                              radius: 24,
                              child: Text(
                                "${user!.name[0].toUpperCase()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomDivider(
                      height: 1.3,
                      color: Colors.deepOrange,
                      thickness: 3,
                    ),

                    Dashboard(
                      onIncomeTap: () {
                        Navigator.pushNamed(context, 'listIncomeTransactions',arguments: finService.totalIncome);

                      },
                      onExpenseTap: () {
                        Navigator.pushNamed(context, 'listExpTransactions',arguments: finService.totalExpense);
                      },
                      incomeChild: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Income",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${finService.totalIncome}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      expenseChild: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Expense",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${finService.totalExpense}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Dashboard(
                      onIncomeTap: () {
                        Navigator.pushNamed(
                          context,
                          'addIncome',
                          arguments: user.id,
                        ).then((_) {
                          Provider.of<FinService>(
                            context,
                            listen: false,
                          ).calculatetotalIncome(user.id);
                        });
                      },
                      onExpenseTap: () {
                        Navigator.pushNamed(
                          context,
                          'addExpense',
                          arguments: user.id,
                        ).then((_) {
                          Provider.of<FinService>(
                            context,
                            listen: false,
                          ).calculatetotalExpense(user.id);
                        });
                      },
                      incomeChild: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Add Income",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                      expenseChild: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Add Expense",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Income vs Expense",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          AspectRatio(
                            aspectRatio: 1.3,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    radius: 50,
                                    titleStyle: TextStyle(color: Colors.white),

                                    color: chartColor1,
                                    value: finService.totalExpense,
                                    title: "Expense",
                                  ),
                                  PieChartSectionData(
                                    radius: 50,
                                    titleStyle: TextStyle(color: Colors.white),
                                    color: chartColor2,
                                    value: finService.totalIncome,
                                    title: "Income",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
