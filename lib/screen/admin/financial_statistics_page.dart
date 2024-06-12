import 'package:flutter/material.dart';

class FinancialStatisticsPage extends StatefulWidget {
  const FinancialStatisticsPage({super.key});

  @override
  State<FinancialStatisticsPage> createState() =>
      _financial_statisticsPageState();
}

class _financial_statisticsPageState extends State<FinancialStatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Thống kê tài chính"),
      ),
    );
  }
}
