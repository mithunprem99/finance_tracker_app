import 'package:finance_app/constants/colors.dart';
import 'package:finance_app/models/user_models.dart';
import 'package:finance_app/services/auth_service.dart';
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
                      ],
                    ),
                    CustomDivider(
                      height: 1.3,
                      color: Colors.deepOrange,
                      thickness: 3,
                    ),

                    Dashboard(
                      onIncomeTap: () {
                        print("tap 1");
                      },
                      onExpenseTap: () {
                        print("tap 2");
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
                            "₹12,000",
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
                            "₹3,500",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Dashboard(
                      onIncomeTap: () {
                        print("tap 1");
                      },
                      onExpenseTap: () {
                        print("tap 2");
                      },
                      incomeChild: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Add Income",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "₹12,000",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
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
                          Text(
                            "₹3,500",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
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
                                    value: 80,
                                    title: "Expense",
                                  ),
                                  PieChartSectionData(
                                    radius: 50,
                                    titleStyle: TextStyle(color: Colors.white),
                                    color: chartColor2,
                                    value: 50,
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
