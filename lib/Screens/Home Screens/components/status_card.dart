import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Components/snackBar.dart';
import 'package:sizer/sizer.dart';

import '../goals_screen.dart';
import 'cancel_goal_screen.dart';

class StatusCard extends StatelessWidget {
  final String status;
  final String goal;

  const StatusCard({Key? key, required this.status, required this.goal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == "Cancel") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CancelGoalsScreen(
                        show_appbar: true,
                        from_cancel: status == "Cancel" ? true : false,
                      )));
          // ScaffoldMessenger.of(context).showSnackBar(showSnackbar(
          //     "Please click on the delete icon on your goals to cancel a goal."));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GoalsScreen(
                        show_appbar: true,
                        from_cancel: status == "Cancel" ? true : false,
                      )));
        }
      },
      child: Container(
        margin: EdgeInsets.all(2.w),
        height: 14.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kSignupColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 10.sp, right: 7.sp, top: 5.h),
          title: Text(
            status,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
            ),
          ),
          subtitle: Text(
            "$goal Goals",
            // status != "Cancel" ? "${goal} Goals" : " ",
            style: TextStyle(color: Colors.white, fontSize: 12.sp, height: 2),
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
