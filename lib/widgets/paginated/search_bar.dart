import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginatedSearchBar extends StatelessWidget {
  final void Function(String) onChanged;
  const PaginatedSearchBar({@required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 40,
            color: Colors.white,
          ),
          Expanded(
            flex: 8,
            child: TextField(
              onChanged: onChanged,
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
