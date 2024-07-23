import 'dart:developer';

import 'package:app_well_mate/model/disease_model.dart';
import 'package:app_well_mate/screen/search/search_detail_rewrite.dart';
import 'package:app_well_mate/screen/search/testcrawl_tile.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';

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
  bool isSeach = false;
  bool isLoading = false;

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
    // Implement your search logic here
  }

  Key testCrawlTileKey = UniqueKey();

  void handleSearchButtonClick() {
    setState(() {
      isLoading = true;
      isSeach = false;
      testCrawlTileKey = UniqueKey();
    });

    Future.delayed(const Duration(seconds: 0, milliseconds: 100), () {
      setState(() {
        isLoading = false;
        isSeach = true;
      });
    });
  }

  var recentDisease = ['Đau đầu', 'Đau bụng', 'Đau dạ dày', 'Thuốc sổ'];

  int checkClick = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: searchDisease,
                controller: _searchController,
                decoration: InputDecoration(
                  label: Text(
                    'Tìm kiếm',
                    style: Theme.of(context).textTheme.bodyLarge,
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
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: handleSearchButtonClick,
              child: const Icon(Icons.search),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSeach
                    ? Expanded(
                        child: TestcrawlTile(
                          keySearch: _searchController.text,
                        ),
                      )
                    : const SizedBox(
                        child: Text('Không có kết quả nào được tìm thấy!'),
                      ),
              ],
            ),
    );
  }
}




   // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          //   child: countResultSearch > 0
          //       ? Text('Kết quả tìm kiếm: $countResultSearch')
          //       : const Text(''),
          // ),
          // check_flash_option
          //     ? Container(
          //         height: 40,
          //         padding: const EdgeInsets.symmetric(horizontal: 16),
          //         child: ListView.builder(
          //           scrollDirection: Axis.horizontal,
          //           itemCount: recentDisease.length,
          //           itemBuilder: (context, index) {
          //             return Container(
          //               margin: const EdgeInsets.symmetric(horizontal: 6.0),
          //               decoration: BoxDecoration(
          //                 color: const Color(0xffF6F8FD),
          //                 border: Border.all(
          //                     width: 1,
          //                     color: index == checkClick
          //                         ? Theme.of(context).colorScheme.primary
          //                         : const Color.fromARGB(255, 210, 210, 210)),
          //                 borderRadius: BorderRadius.circular(8.0),
          //               ),
          //               child: TextButton(
          //                 child: Text(
          //                   recentDisease[index],
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .bodyMedium!
          //                       .copyWith(),
          //                 ),
          //                 onPressed: () {
          //                   setState(() {
          //                     checkClick = index;
          //                   });
          //                 },
          //               ),
          //             );
          //           },
          //         ),
          //       )
          //     : const SizedBox(),
// ListView.builder(
//               itemCount: _listDisease.length,
//               itemBuilder: (context, index) {
//                 final disease = _listDisease[index];
//                 return ListTile(
//                   leading: const Icon(Icons.search),
//                   title: Text(disease.title!),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           SearchDetailReWritePage(disease: disease),
//                     ),
//                   ),
//                 );
//               },
//             ),