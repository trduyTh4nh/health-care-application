import 'package:flutter/material.dart';

class WidgetPaymentMedicine extends StatefulWidget {
  const WidgetPaymentMedicine({super.key});

  @override
  State<WidgetPaymentMedicine> createState() => _WidgetPaymentMedicine();
}

class _WidgetPaymentMedicine extends State<WidgetPaymentMedicine> {
  String paymentMethod = 'Momo';
  String diaChi = "DiaChi1";
  @override
  Widget build(BuildContext context) {
    final sizeWight = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phương thức thanh toán"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                    value: "Visa",
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value!;
                      });
                    },
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGxsoe7iPccCnGraliGFCLCvbg3bO3PDtELQ&s"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Visa",
                          style: Theme.of(context).textTheme.titleMedium),
                      Text("******12"),
                    ],
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return showBottomSheet(sizeHeight: sizeHeight);
                  },
                );
              },
              child: Row(
                children: [
                  Icon(Icons.add),
                  Text("Thêm", style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
          Text("Địa chỉ giao hàng"),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Radio(
                      value: "Diachi1",
                      groupValue: diaChi,
                      onChanged: (value) {
                        setState(() {
                          diaChi = value!;
                        });
                      },
                    ),
                    Container(
                      width: sizeWight * 1.9 / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "100 đường Example, Thành phố Hồ Chí Minh, Việt Nam",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text("Địa chỉ 1"),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class showBottomSheet extends StatelessWidget {
  const showBottomSheet({
    super.key,
    required this.sizeHeight,
  });

  final double sizeHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 0.65 * sizeHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("Thêm địa chỉ mới"),
              ),
              Text("Thông tin liên hệ"),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 7),
                      ),
                    ]),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: "Họ và tên"),
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Số điện thoại"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Thông tin địa chỉ")
            ],
          ),
        ),
      ),
    );
  }
}
