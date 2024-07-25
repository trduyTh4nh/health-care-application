import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';

class itemDrugCartDetail extends StatelessWidget {
  itemDrugCartDetail(
      {super.key,
      required this.item,
      required this.value,
      required this.index,
      required this.setLoading});

  final DrugCartDetailModel item;
  var value;
  var index;
  final void Function(bool) setLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 4.0, top: 4.0, right: 4.0, bottom: 4.0),
          child: Row(
            children: [
              Checkbox(
                value: value.isChecked[index],
                onChanged: (bool? newValue) {
                  value.toggleCheck(index);
                },
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: NetworkImage(item.drug!.drugImage ?? ""),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      child: Text(item.drug!.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 4),
                    Text(convertCurrency(item.drug!.price!))
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Text(item.drug!.unit ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      // showDialog(context: context, builder: builder)
                      setLoading(true);

                      await value
                          .deleteDrugCartFromCart(item.idDrugCartDetail!);
                      setLoading(false);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.greyColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  iconSize: 15.0,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                  onPressed: () {
                    item.quantity == 1
                        ? showCustomSnackBar(
                            context, "Bạn không thể giảm thêm được nữa")
                        : value.updateQuantityDetial(
                            item.idDrugCartDetail!, -1);
                  },
                ),
                Text('${item.quantity}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  iconSize: 15.0,
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                    value.updateQuantityDetial(item.idDrugCartDetail!, 1);
                  },
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
