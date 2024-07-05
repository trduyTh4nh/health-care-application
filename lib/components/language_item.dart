import 'package:app_well_mate/model/language_model.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({super.key, required this.data, this.selected, this.onSelect});
  final LanguageModel data;
  final String? selected;
  final void Function(String)? onSelect;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect == null ? () {} : () {
        onSelect!(data.code!);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Center(child: Text(data.flag ?? "🇺🇳", style: Theme.of(context).textTheme.titleLarge,))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name ?? "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(data.nativeName ?? "")
                      ],
                    )
                  ],
                ),
              ),
              selected == data.code ? const Icon(Icons.check) : const SizedBox()
            ],
          )),
    );
  }
}
