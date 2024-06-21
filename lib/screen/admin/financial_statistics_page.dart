import 'package:flutter/material.dart';

class FinancialStatisticsPage extends StatefulWidget {
  const FinancialStatisticsPage({super.key});

  @override
  State<FinancialStatisticsPage> createState() =>
      _financial_statisticsPageState();
}

class _financial_statisticsPageState extends State<FinancialStatisticsPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Thống kê tài chính"),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            text: "Doanh thu",
          ),
          Tab(
            text: "Lợi nhuận",
          )
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: Text("It's cloudy here"),
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}
