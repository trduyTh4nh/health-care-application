import 'dart:convert';
import 'package:app_well_mate/screen/search/component_crawl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestcrawlTile extends StatefulWidget {
  TestcrawlTile({super.key, required this.keySearch});
  String keySearch;
  @override
  State<TestcrawlTile> createState() => _TestcrawlTileState();
}

class _TestcrawlTileState extends State<TestcrawlTile> {
  List<dynamic> diseases = [];
  bool isLoading = true;

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
        throw Exception('Failed to load disease info');
      }
    } catch (error) {
      log('Error nè: $error');
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            disease['title'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            disease['time'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 8.0),
                          if (disease['image'] != null)
                            Image.network(
                              disease['image'],
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 8.0),
                          Text(
                            disease['doctor'] ?? '',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontStyle: FontStyle.italic,
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
