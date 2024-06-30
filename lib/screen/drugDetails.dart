import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:app_well_mate/screen/drug/add_drug.dart';
import 'package:app_well_mate/screen/drug/medicine_order/medicines_order_main.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

class Drugdetails extends StatefulWidget {
  const Drugdetails({super.key});

  @override
  State<Drugdetails> createState() => _DrugdetailsState();
}

class _DrugdetailsState extends State<Drugdetails> {
  @override
  Widget build(BuildContext context) {
    AddPageProvider prod = AddPageProvider();
    prod.prescriptionDetail!.quantity = 1;
    prod.prescriptionDetail!.drug =
        DrugModel(name: "Paradol Extra", unit: "Viên");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Chi tiết thuốc",
              style: TextStyle(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/panadol.png'),
                  SizedBox(height: 16.0),
                  Text(
                    'Panadol Extra (Đỏ)',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Thuốc kê đơn • Không có trong toa',
                          style: Theme.of(context).textTheme.labelMedium),
                      SizedBox(width: 4),
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: colorScheme.primary,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giá tiền',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '8000đ / Vỉ',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MedicinesOrder(),
                                ));
                          },
                          child: Text('Mua'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ), // Button color
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // Space between buttons
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 0.0), // Add padding on the right
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle add to stock action
                            },
                            child: Text(
                              'Thêm vào kho thuốc',
                              textAlign: TextAlign.center,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.greyColor,
                              foregroundColor: Colors.black, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ), // Button color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        // Add padding on the right
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddDrugPage(
                                    addPageProdiver: prod,
                                  ),
                                ));
                          },
                          child: Text(
                            'Thêm vào toa thuốc',
                            textAlign: TextAlign.center,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greyColor,
                            foregroundColor: Colors.black, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ), // Button color
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  Text(
                    'Miêu tả',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Risus duis auctor gravida turpis. Turpis risus sem donec purus a est elementum curabitur. Orci est iaculis consectetur morbi euismod. Faucibus tortor libero pretium tincidunt tristique nulla curabitur quam cursus.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Thành phần',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Risus duis auctor gravida turpis. Turpis risus sem donec purus a est elementum curabitur. Orci est iaculis consectetur morbi euismod. Faucibus tortor libero pretium tincidunt tristique nulla curabitur quam cursus.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Chỉ định',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Risus duis auctor gravida turpis. Turpis risus sem donec purus a est elementum curabitur. Orci est iaculis consectetur morbi euismod. Faucibus tortor libero pretium tincidunt tristique nulla curabitur quam cursus.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Chống chỉ định',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Risus duis auctor gravida turpis. Turpis risus sem donec purus a est elementum curabitur. Orci est iaculis consectetur morbi euismod. Faucibus tortor libero pretium tincidunt tristique nulla curabitur quam cursus.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tác dụng phụ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Risus duis auctor gravida turpis. Turpis risus sem donec purus a est elementum curabitur. Orci est iaculis consectetur morbi euismod. Faucibus tortor libero pretium tincidunt tristique nulla curabitur quam cursus.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
