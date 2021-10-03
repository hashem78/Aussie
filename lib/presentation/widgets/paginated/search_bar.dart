import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/util/functions.dart';

class PaginatedSearchBar extends StatelessWidget {
  final void Function(String) onSubmitted;
  const PaginatedSearchBar({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 40,
          ),
          Expanded(
            flex: 8,
            child: TextField(
              onSubmitted: onSubmitted,
              style: TextStyle(fontSize: 70.sp, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: getTranslation(context, "searchTitle"),
                hintStyle: TextStyle(
                  fontSize: 70.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.withOpacity(.7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
