import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabItem extends StatelessWidget {
  final index;
  final String title;
  final int count;

  const TabItem({
    super.key,
    required this.index,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (index == 0)
            Image.asset(
              'assets/icons/star.png',
              width: 24,
              height: 24,
            ),
          if (index == 0)
            const SizedBox(width: 8),
          Text(title),
          const SizedBox(width: 8),
          if(count != 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
