import 'package:flutter/material.dart';

class ItemSick extends StatelessWidget {
  const ItemSick({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sốt xuất huyết",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "45% người bệnh",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                Icon(Icons.more_horiz),
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
