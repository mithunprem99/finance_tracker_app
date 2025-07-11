import 'package:finance_app/models/expense_model.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:finance_app/services/fin_service.dart';
import 'package:finance_app/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListExpTransactions extends StatefulWidget {
  const ListExpTransactions({super.key});

  @override
  State<ListExpTransactions> createState() => _ListExpTransactionsState();
}

class _ListExpTransactionsState extends State<ListExpTransactions> {
  @override
  Widget build(BuildContext context) {
    final double totalExpense =
        ModalRoute.of(context)!.settings.arguments as double;
    final finService = Provider.of<FinService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("All Expenses")),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: authService.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                final userData = snapshot.data!;
                return FutureBuilder<List<ExpenseModel>>(
                  future: finService.getAllExpense(userData.id),

                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData) {
                        final List<ExpenseModel> expenses = snapshot.data!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Expense $totalExpense",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            CustomDivider(),
                            const SizedBox(height: 10),
                            Expanded(
                              child: ListView.builder(
                                itemCount: expenses.length,
                                itemBuilder: (context, index) {
                                  final expense = expenses[index];
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,

                                          builder: (context) {
                                            return Container(
                                              height: 150,
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("${expense.category}"),
                                                  Text(
                                                    "${expense.description}",
                                                  ),
                                                  Text("${expense.amount}"),
                                                  Text("${expense.createdAT}"),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      title: Text(
                                        expense.category,
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                      subtitle: Text(
                                        expense.amount.toString(),
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                );
              }
              return Center();
            }
          },
        ),
      ),
    );
  }
}
