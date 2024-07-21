import 'dart:convert';

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
  List<User> listUsers = DataUsers().users;
  List<User> filteredUsers = [];
  TextEditingController searchUserController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    //_loadUsers();
    loadData().then((users) {
      setState(() {
        listUsers = users;
        filteredUsers = listUsers;
      });
    });
    searchUserController.addListener(filterUsers);
  }

  Future<List<User>> loadData() async {
    String data = '''
      [
        {
            "idUser": 1,
            "email": "phat@gmail.com",
            "password": "12345678",
            "role": "user",
            "userName": "Hoang Phat",
            "imgUser": "https://cdn.pixabay.com/photo/2021/12/21/08/29/owl-6884773_1280.jpg"
        },
        {
            "idUser": 2,
            "email": "quang@gmail.com",
            "password": "12345678",
            "role": "user",
            "userName": "Tri Quang",
            "imgUser": "https://cdn.pixabay.com/photo/2014/01/12/22/56/owl-243129_1280.jpg"
        },
        {
            "idUser": 3,
            "email": "thanh@gmail.com",
            "password": "12345678",
            "role": "user",
            "userName": "Duy Thanh",
            "imgUser": "https://cdn.pixabay.com/photo/2021/12/21/08/29/owl-6884773_1280.jpg"
        },
        {
            "idUser": 4,
            "email": "Duy@gmail.com",
            "password": "12345678",
            "role": "user",
            "userName": "Thanh Duy",
            "imgUser": "https://cdn.pixabay.com/photo/2014/01/12/22/56/owl-243129_1280.jpg"
        },
        {
            "idUser": 5,
            "email": "Tuany@gmail.com",
            "password": "12345678",
            "role": "user",
            "userName": "Anh Tuan",
            "imgUser": "https://cdn.pixabay.com/photo/2014/01/12/22/56/owl-243129_1280.jpg"
        },
        {
            "idUser": 6,
            "email": "Vinh@gmail.com",
            "password": "12345678",
            "role": "user",
            "userName": "Duc Vinh",
            "imgUser": "assets/images/info.svg"
        }
      ]
    ''';
    List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => User.fromJson(json)).toList();
  }

  @override
  void dispose() {
    searchUserController.dispose();
    super.dispose();
  }

  // Future<void> _loadUsers() async {
  //   DataUsers dataUsers = DataUsers();
  //   await dataUsers.loadUsersFromJson();
  //   setState(() {
  //     listUsers = dataUsers.users;
  //     filteredUsers = listUsers;
  //     isLoading = false;
  //   });
  // }

  // Loc de tim kiem user
  void filterUsers() {
    String query = searchUserController.text.toLowerCase();
    setState(() {
      filteredUsers = listUsers.where((user) {
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
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      // var itemUser = filteredUsers[index];
                      // return ItemUserProfile(users: itemUser);
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserProfilePage(),
                                ));
                          },
                          child: itemUserProfile(users: filteredUsers[index]));
                    },
                  ),
                )),
              ],
            ),
    );
  }
}
