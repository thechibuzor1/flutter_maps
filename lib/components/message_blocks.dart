import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_flutter/models/demo_text.dart';

class MessageBlocks extends StatelessWidget {
  final DemoText item;

  const MessageBlocks({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          item.user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 16.h,
            left: 16.w,
            right: 16.w,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: item.user ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            item.text,
            style: TextStyle(
              fontSize: 15.sp,
              color: item.user ? Colors.white : Colors.black87,
            ),
          ),
        ),
        if (item.user)
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 4.h),
            child: Text(
              'Delivered',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ),
      ],
    );
  }
}
