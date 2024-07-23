import 'package:app_well_mate/model/disease_model.dart';
import 'package:app_well_mate/style/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class SearchDetailPage extends StatefulWidget {
  const SearchDetailPage({super.key, required this.disease});
  final DiseaseModel disease;

  @override
  State<SearchDetailPage> createState() => _SearchDetailPageState();
}

class _SearchDetailPageState extends State<SearchDetailPage> {
  bool isShowInfo = false;
  @override
  void initState() {
    super.initState();
    isShowInfo = true;
  }

  @override
  Widget build(BuildContext context) {
    final disease = widget.disease;

    //List<DiseaseDetail> disease_details = disease.details!;
    DateTime time = disease.time!;
    DateFormat format = DateFormat('yyyy-MM-dd');
    String formatedDate = format.format(time);
    return Scaffold(
      appBar: AppBar(
        title: Text(disease.title!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.bookmark),
          ),
        ],
      ),
      body: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation =
                      Tween<Offset>(begin: const Offset(0, 0), end: Offset.zero)
                          .animate(animation);
        
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                child: isShowInfo
                    ? Column(
                        key: const ValueKey<int>(1),
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Ngày đăng: ',
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      formatedDate,
                                      style:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Bác sĩ: ',
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      disease.doctor!,
                                      style:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tổng quan',
                                  style: AppStyle.titleSearchStyle,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  disease.overview!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nguyên nhân',
                                  style: AppStyle.titleSearchStyle,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  disease.reason!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mô tả',
                                  style: AppStyle.titleSearchStyle,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  disease.description!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(
                        key: ValueKey<int>(0),
                      ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all<Size>(
                         const Size(20, 20)), 
                      padding: WidgetStateProperty.all<EdgeInsets>(
                         const EdgeInsets.all(8.0)), 
                    ),
                    child: Icon(
                        isShowInfo ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                    onPressed: () {
                      setState(() {
                        isShowInfo = !isShowInfo;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: disease.details!.length,
                  itemBuilder: (context, index) {
                    DiseaseDetail result = disease.details![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          result.titleDetail!,
                          style: AppStyle.titleSearchStyle,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          result.contentDetail!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        (result.imageDetail != null)
                            ? Image.network(
                                result.imageDetail!,
                                scale: 0.8,
                                errorBuilder: (context, error, stackTrace) {
                                  return const SizedBox();
                                },
                              )
                            : const SizedBox(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
