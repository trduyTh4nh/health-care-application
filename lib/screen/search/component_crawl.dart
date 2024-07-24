import 'dart:convert';
import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff6a94ff), Colors.white],
          )),
          // height: MediaQuery.of(context).size.height * 1 / 2,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorScheme.surface.withAlpha(100),
            title: const Text('Thông tin bệnh'),
          ),
          body: isLoading
              ? Center(
                  child: LoadingAnimationWidget.flickr(
                  leftDotColor: colorScheme.primary,
                  rightDotColor: colorScheme.error,
                  size: 48,
                ))
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final disease = diseases[widget.position];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              if (disease['image'] != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    disease['image'],
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 1 / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        disease['title'] ?? 'Không có tiêu đề',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        disease['doctor'] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontStyle: FontStyle.italic,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              disease['description'] ?? 'Không có mô tả',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
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
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        paragraph,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  );
                                })).toList(),
                                const SizedBox(height: 8.0),
                              ],
                              if (item['h3_p'] != null) ...[
                                ...((item['h3_p'] as List<dynamic>)
                                    .map((h3_p_item) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          h3_p_item['h3'] ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      ...((h3_p_item['p'] as List<dynamic>)
                                          .map((paragraph) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Text(
                                            paragraph,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
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
        ),
      ],
    );
  }
}

void log(message) {
  print(message);
}
