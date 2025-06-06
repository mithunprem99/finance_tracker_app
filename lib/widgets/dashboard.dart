import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final VoidCallback onIncomeTap;
  final VoidCallback onExpenseTap;
  final Widget incomeChild;
  final Widget expenseChild;
  Dashboard({
    super.key,
    required this.onIncomeTap,
    required this.onExpenseTap,
     required this.incomeChild,
    required this.expenseChild,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
   Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.deepOrangeAccent, Colors.teal],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Expense side
          Expanded(
            child: GestureDetector(
              onTap: widget.onExpenseTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(child: widget.expenseChild),
              ),
            ),
          ),

          // Divider
          Container(
            width: 2,
            height: 50,
            color: Colors.yellowAccent,
          ),

          // Income side
          Expanded(
            child: GestureDetector(
              onTap: widget.onIncomeTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(child: widget.incomeChild),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
