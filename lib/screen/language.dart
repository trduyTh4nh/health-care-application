import 'package:app_well_mate/components/language_item.dart';
import 'package:app_well_mate/model/language_model.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  List<LanguageModel> langs = getLanguageList();
  String selectedLang = "vn";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Thay đổi ngôn ngữ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => LanguageItem(
                  data: langs[index],
                  selected: selectedLang,
                  onSelect: (p0) => setState(() {
                    selectedLang = p0;
                  }),
                ),
            separatorBuilder: (c, i) => Divider(
                  indent: 20,
                  endIndent: 20,
                ),
            itemCount: langs.length));
  }
}
