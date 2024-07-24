import 'dart:convert';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/screen/search/component_crawl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TestcrawlTile extends StatefulWidget {
  TestcrawlTile({super.key, required this.keySearch});
  String keySearch;
  @override
  State<TestcrawlTile> createState() => _TestcrawlTileState();
}

class _TestcrawlTileState extends State<TestcrawlTile> {
  List<dynamic> diseases = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchDiseaseInfo();
  }

  @override
  void didUpdateWidget(covariant TestcrawlTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.keySearch != oldWidget.keySearch) {
      fetchDiseaseInfo();
    }
  }

  Future<void> fetchDiseaseInfo() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.100.136:5000/get_title_disease?disease_name=${widget.keySearch}'));

      if (response.statusCode == 200) {
        setState(() {
          diseases = json.decode(response.body);
          log("Kết quả crawl");
          log(diseases);
          isLoading = false;
        });
      } else {
        diseases = [];
        throw Exception('Failed to load disease info');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      log('Error nè: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.flickr(
              leftDotColor: colorScheme.primary,
              rightDotColor: colorScheme.error,
              size: 48,
            ))
          : hasError
              ? const Center(child: Text("Không có thông tin tìm kiếm"))
              : ListView.builder(
                  itemCount: diseases.length,
                  itemBuilder: (context, index) {
                    final disease = diseases[index];
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComponentCrawl(
                                  position: index,
                                  keySearch: widget.keySearch,
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              if (disease['image'] != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    disease['image'],
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          2 /
                                          3,
                                      child: Text(
                                        disease['title'] ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      disease['time'] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey,
                                          ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      disease['doctor'] ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey,
                                          ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

void log(message) {
  print(message);
}
