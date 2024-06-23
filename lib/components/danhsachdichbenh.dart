import 'package:app_well_mate/components/item_sick.dart';
import 'package:flutter/material.dart';

class Danhsachdichbenh extends StatefulWidget {
  const Danhsachdichbenh({
    super.key,
  });

  @override
  State<Danhsachdichbenh> createState() => _DanhsachdichbenhState();
}

class _DanhsachdichbenhState extends State<Danhsachdichbenh> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(hintText: "Tìm kiếm"),
              ),
              const SizedBox(
                height: 30,
              ),
              ItemSick(),
              ItemSick(),
              ItemSick(),
            ],
          ),
        ),
      ),
    );
  }
}
