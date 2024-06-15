import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class DrugInfoPage extends StatefulWidget {
  const DrugInfoPage({super.key});

  @override
  State<DrugInfoPage> createState() => _DrugInfoPageState();
}

class _DrugInfoPageState extends State<DrugInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Symbols.more_horiz))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: const Padding(
                    padding: EdgeInsets.all(25),
                    child: Icon(
                      Symbols.pill,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                Text('Paracetamol 5mg'),
                Row(
                  children: [
                    Icon(Symbols.pill),
                    const SizedBox(width: 16,),
                    Text('Số lượng: 40/40')
                  ],
                )
                
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Text(
                      'Lịch uống thuốc',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  // khứa này chắc xếp 3 mảng sáng trưa chiều xong tạo thành 1 mảng ủi vô column
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Text('Chi tiết lịch $index');
                  }, childCount: 5)),
                  SliverToBoxAdapter(
                    child: const Divider(),
                  ),
                  SliverToBoxAdapter(
                    child: Text('More time'),
                  ),
                  SliverToBoxAdapter(
                    child: Text('Thông tin thuốc'),
                  ),
                  SliverToBoxAdapter(
                    child: const Divider(),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Text('Thuốc chi tiết $index');
                  }, childCount: 3)),
                  SliverToBoxAdapter(
                    child: const Divider(),
                  ),
                  SliverToBoxAdapter(
                    child: Text('Toa thuốc'),
                  ),
                  SliverToBoxAdapter(
                    child: Text('Component toa thuốc'),
                  ),
                ],
              ),
            )
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      backgroundColor: AppColor.smoker),
                  label: Text(
                    'Báo lại cho tôi sau 10 phút',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  icon: const Icon(
                    Symbols.snooze,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                  ),
                  label: Text(
                    'Đánh dấu đã uống',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  icon: const Icon(
                    Symbols.check,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ));
  }
}
