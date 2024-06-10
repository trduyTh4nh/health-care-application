import 'package:flutter/material.dart';

class HospitalManagementAdminPage extends StatefulWidget {
  const HospitalManagementAdminPage({super.key});

  @override
  State<HospitalManagementAdminPage> createState() =>
      _HospitalManagementAdminPageState();
}

class _HospitalManagementAdminPageState
    extends State<HospitalManagementAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý bệnh viện"),
      ),
    );
  }
}
