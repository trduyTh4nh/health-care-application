import 'package:flutter/material.dart';

class DiseaseManagementAdminPage extends StatefulWidget {
  const DiseaseManagementAdminPage({super.key});

  @override
  State<DiseaseManagementAdminPage> createState() =>
      _DiseaseManagementAdminPageState();
}

class _DiseaseManagementAdminPageState
    extends State<DiseaseManagementAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý dịch bệnh"),
      ),
    );
  }
}
