import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginatedSearchBar extends StatelessWidget {
  final void Function(String) onSubmitted;
  const PaginatedSearchBar({@required this.onSubmitted});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 40,
          ),
          Expanded(
            flex: 8,
            child: TextField(
              onSubmitted: onSubmitted,
              style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(
                  fontSize: 40.sp,
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
