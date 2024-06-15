import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/disease_model.dart';
import 'package:app_well_mate/screen/search/search_detail.dart';
import 'package:app_well_mate/screen/search/search_detail_rewrite.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  int countResultSearch = 0;
  List<DiseaseModel> _listDisease = [];
  List<DiseaseModel> _originalList = [];
  bool check_flash_option = true;
  @override
  void initState() {
    super.initState();
    _originalList = allDisease;
    check_flash_option = true;
    // _listDisease = List.from(_originalList);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void searchDisease(String query) {
    if (query.isEmpty) {
      setState(() {
        check_flash_option = true;
        _listDisease = [];
        countResultSearch = 0;
      });
      return;
    }

    final suggestions = _originalList.where((disease) {
      final diseaseTitle = disease.title!.toLowerCase();
      final input = query.toLowerCase();

      return diseaseTitle.contains(input);
    }).toList();

    setState(() {
      _listDisease = suggestions;
      check_flash_option = false;
      countResultSearch = suggestions.length;
    });
  }

  var recentDisease = ['Đau đầu', 'Đau bụng', 'Đau dạ dày', 'Thuốc sổ'];

  int checkClick = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            TextField(
              onChanged: searchDisease,
              controller: _searchController,
              decoration: InputDecoration(
                label: Text(
                  'Tìm kiếm',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  size: 32,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: countResultSearch > 0
                ? Text('Kết quả tìm kiếm: $countResultSearch')
                : const Text(''),
          ),
          check_flash_option
              ? Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentDisease.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F8FD),
                          border: Border.all(
                              width: 1,
                              color: index == checkClick
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color.fromARGB(255, 210, 210, 210)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextButton(
                          child: Text(
                            recentDisease[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(),
                          ),
                          onPressed: () {
                            setState(() {
                              checkClick = index;
                            });
                          },
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: ListView.builder(
              itemCount: _listDisease.length,
              itemBuilder: (context, index) {
                final disease = _listDisease[index];
                return ListTile(
                  leading: const Icon(Icons.search),
                  title: Text(disease.title!),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchDetailReWritePage(disease: disease),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
