import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';

class AutocompleteBasicExample extends StatelessWidget {
  bool isAdd;
  TextEditingController? coundTryController;
  final void Function(Map<String, dynamic>) onProvinceSelected;
  AutocompleteBasicExample(
      {super.key,
      required this.onProvinceSelected,
      required this.isAdd,
      this.coundTryController});

  static final List<Map<String, dynamic>> _kOptions = vietNemprovince;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((Map<String, dynamic> option) {
          return option['name']
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).map((option) => option['name'] as String);
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
        // Gọi hàm onProvinceSelected với province đã chọn
        final selectedProvince = _kOptions.firstWhere(
            (Map<String, dynamic> option) => option['name'] == selection);
        // Đặt các giá trị đã chọn vào các TextEditingController tương ứng
        onProvinceSelected(selectedProvince);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          validator: (nameAddress) =>
              nameAddress!.isEmpty ? "Vui lòng chọn thành phố" : null,
          controller: textEditingController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            labelText: "Nhập thành phố",
          ),
          onChanged: (text) {
            if (!isAdd && coundTryController != null) {
              coundTryController!.text = text;
              coundTryController!.selection = TextSelection.fromPosition(
                TextPosition(offset: coundTryController!.text.length),
              );
            }
          },
        );
      },
    );
  }
}
