import 'package:flutter/material.dart';

class UserManagementAdmin extends StatefulWidget {
  const UserManagementAdmin({super.key});

  @override
  State<UserManagementAdmin> createState() => _UserManagementAdminState();
}

class _UserManagementAdminState extends State<UserManagementAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Quản lý người dùng"),
      ),
    );
  }
}
