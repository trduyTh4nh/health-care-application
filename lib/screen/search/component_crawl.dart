import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComponentCrawl extends StatefulWidget {
  const ComponentCrawl(
      {super.key, required this.position, required this.keySearch});
  final int position;
  final String keySearch;
  @override
  State<ComponentCrawl> createState() => _ComponentCrawlState();
}

class _ComponentCrawlState extends State<ComponentCrawl> {
  List<dynamic> diseases = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchDiseaseInfo(widget.keySearch);
  }

  @override
  void didUpdateWidget(ComponentCrawl oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.keySearch != oldWidget.keySearch) {
      fetchDiseaseInfo(widget.keySearch);
    }
  }

  Future<void> fetchDiseaseInfo(String keySearch) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'http://192.168.100.136:5000/get_disease?disease_name=$keySearch'));

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
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin bệnh'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                final disease = diseases[widget.position!];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        disease['title'] ?? 'Không có tiêu đề',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8.0),
                      if (disease['image'] != null)
                        Image.network(
                          disease['image'],
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      Text(
                        disease['doctor'] ?? '',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        disease['description'] ?? 'Không có mô tả',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                      ),
                      const SizedBox(height: 16.0),
                      if (disease['data'] != null) ...[
                        // Hiển thị thông tin từ `data`
                        for (var item in disease['data']) ...[
                          Text(
                            item['h2'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          if (item['h2_p'] != null) ...[
                            ...((item['h2_p'] as List<dynamic>)
                                .map((paragraph) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  paragraph,
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                              );
                            })).toList(),
                            const SizedBox(height: 8.0),
                          ],
                          if (item['h3_p'] != null) ...[
                            ...((item['h3_p'] as List<dynamic>)
                                .map((h3_p_item) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    h3_p_item['h3'] ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  ...((h3_p_item['p'] as List<dynamic>)
                                      .map((paragraph) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Text(
                                        paragraph,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    );
                                  })).toList(),
                                  const SizedBox(height: 8.0),
                                ],
                              );
                            })).toList(),
                          ],
                        ],
                      ],
                    ],
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
