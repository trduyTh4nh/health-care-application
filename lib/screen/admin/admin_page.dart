import 'package:app_well_mate/screen/admin/disease_management_page.dart';
import 'package:app_well_mate/screen/admin/financial_statistics_page.dart';
import 'package:app_well_mate/screen/admin/hospital_management_page.dart';
import 'package:app_well_mate/screen/admin/user_management_page.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedPage = 0;

  final List<Widget> _listPage = [
    const FinancialStatisticsPage(),
    const UserManagementAdmin(),
    const HospitalManagementAdminPage(),
    const DiseaseManagementAdminPage(),
  ];

  void _onTap(index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Symbols.area_chart),
            label: "Thống kê tài chính",
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.account_circle),
            label: "Quản lý người dùng",
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.corporate_fare),
            label: "Quản lý bệnh viện",
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.stethoscope),
            label: "Quản lý dịch bệnh",
          ),
        ],
        currentIndex: _selectedPage,
        onTap: _onTap,
      ),
      body: _listPage[_selectedPage],
    );
  }
}
