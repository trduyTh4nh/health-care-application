import 'dart:convert';

import 'package:app_well_mate/api/user/user_admin_repo.dart';
import 'package:app_well_mate/components/item_user_profile.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/user.dart';
import 'package:app_well_mate/screen/admin/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class UserManagementAdmin extends StatefulWidget {
  const UserManagementAdmin({super.key});

  @override
  State<UserManagementAdmin> createState() => _UserManagementAdminState();
}

class _UserManagementAdminState extends State<UserManagementAdmin> {
  List<User> lstUsers = [];
  List<User> fillUser = [];
  TextEditingController searchUserController = TextEditingController();
  bool isLoading = false;
  final ManagementUserAdminRepo adminUserRepo = ManagementUserAdminRepo();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadUsers();
    searchUserController.addListener(filterUsers);
  }

  Future<void> loadUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      lstUsers = await adminUserRepo.getAllUser();
      fillUser = lstUsers;
    } catch (error) {
      print('Error loading users: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    searchUserController.dispose();
    super.dispose();
  }

  void filterUsers() {
    String query = searchUserController.text.toLowerCase();
    setState(() {
      fillUser = lstUsers.where((user) {
        return user.userName!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Quản lý người dùng"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Symbols.notifications))
        ],
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: colorScheme.primary,
                rightDotColor: colorScheme.error,
                size: 48,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: TextField(
                    controller: searchUserController,
                    decoration: const InputDecoration(
                        hintText: 'Tìm kiếm',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 165, 165, 165),
                        ),
                        suffixIcon: Icon(Symbols.search)),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: fillUser.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfilePage(
                                    user: fillUser[index],
                                  ),
                                ));
                          },
                          child: itemUserProfile(users: lstUsers[index]));
                    },
                  ),
                )),
              ],
            ),
    );
  }
}
