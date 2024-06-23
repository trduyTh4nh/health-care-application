import 'package:app_well_mate/components/admin_component/income.dart';
import 'package:app_well_mate/components/admin_component/return.dart';
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
        title: const Text("Thống kê tài chính"),
        bottom: TabBar(controller: _tabController, tabs: const [
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
          IncomePage(),
          Center(
            child: ReturnPage(),
          ),
        ],
      ),
    );
  }
}
