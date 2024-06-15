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
                Text(
                  'Paracetamol 5mg',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 32),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Symbols.pill),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Số lượng: 40/40',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(Symbols.alarm),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '1 lần 3 viên',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Row(
                      children: [
                        const Icon(Symbols.local_dining_rounded),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Trước khi ăn',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Text(
                      'Lịch uống thuốc',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  // khứa này chắc xếp 3 mảng sáng trưa chiều xong tạo thành 1 mảng ủi vô column
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Text('Chi tiết lịch $index');
                  }, childCount: 5)),
                  const SliverToBoxAdapter(
                    child: Divider(),
                  ),
                  SliverToBoxAdapter(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Symbols.add),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Thêm thời gian',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      'Thông tin thuốc',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: const Divider(),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Text('Thuốc chi tiết $index');
                  }, childCount: 3)),
                  const SliverToBoxAdapter(
                    child: Divider(),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      'Toa thuốc',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                    ),
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

Widget timerWidget() {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(),
    child: InkWell(
      onTap: () {},
      child: Row(
        children: [
          const Icon(Symbols.alarm),
          
        ],
      ),
    ),
  );
}
