import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _seachController = TextEditingController();
  final FocusNode _focusTextField = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusTextField.addListener(() {
      setState(() {
        _isFocused = _focusTextField.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _seachController.dispose();
    _focusTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  focusNode: _focusTextField,
                  controller: _seachController,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Symbols.search, size: 32,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor, width: 2),
                      )),
                ),
              ), 
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                left: 40,
                top: _isFocused ? 0 : 35,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isFocused ? 1.0 : 0.5,
                  child: Text(
                    'Tìm kiếm',
                    style: TextStyle(
                      color: _isFocused ? AppColors.primaryColor : Colors.grey,
                      fontSize: _isFocused ? 12 : 16,
                      fontWeight:
                          _isFocused ? FontWeight.bold : FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
