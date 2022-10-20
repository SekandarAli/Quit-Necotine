import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nicotine/Screens/Components/snackBar.dart';
import 'package:sizer/sizer.dart';

import 'custom_appbar.dart';
import 'goal_history.dart';

class CancelGoalsScreen extends StatelessWidget {
  final bool show_appbar;
  final bool from_cancel;

  const CancelGoalsScreen(
      {Key? key, required this.show_appbar, this.from_cancel = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: Column(
          children: [
            if (show_appbar == true)
              const CustomAppBar(
                title: "Cancelled Goals",
                icon: Icons.search_rounded,
              ),
            // SizedBox(height: 3.h,),
            GoalsHistory(tabKey: 3),
          ],
        ),
      ),
    );
  }
}
