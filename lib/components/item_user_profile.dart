import 'package:app_well_mate/model/user.dart';
import 'package:flutter/material.dart';

enum UserEditOption { delete, edit }

// ignore: must_be_immutable
class itemUserProfile extends StatelessWidget {
  User users;
  itemUserProfile({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: sizeHeight * 0.15,
        width: sizeWidht,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: _loadImage(users.imgUser ?? "")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            users.userName ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(
                            children: [
                              Text(
                                "Tạo ngày ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                "15-06-2024",
                                style: Theme.of(context).textTheme.labelMedium,
                              )
                            ],
                          ),
                          Text(
                            "#1439104",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                PopupMenuButton(
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                        value: UserEditOption.edit, child: Text("Chỉnh sửa")),
                    PopupMenuItem(
                        value: UserEditOption.delete, child: Text("Xóa")),
                  ],
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

// Hàm để tải hình ảnh
Widget _loadImage(String? imgUrl) {
  if (imgUrl == null || imgUrl.isEmpty) {
    // Nếu URL hình ảnh không hợp lệ, sử dụng một placeholder
    return const Icon(Icons.image_not_supported);
  } else if (imgUrl.startsWith('http') || imgUrl.startsWith('https')) {
    // Sử dụng Image.network nếu đó là một URL hợp lệ
    return Image.network(
      imgUrl,
      errorBuilder: (context, error, stackTrace) {
        // Hiển thị một icon placeholder nếu có lỗi xảy ra khi tải hình ảnh
        return const Icon(Icons.image_not_supported);
      },
    );
  } else {
    // Nếu không phải URL, giả sử là đường dẫn cục bộ và sử dụng Image.asset
    return Image.asset(imgUrl);
  }
}
