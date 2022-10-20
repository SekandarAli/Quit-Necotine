import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/Constant.dart';
import 'package:sizer/sizer.dart';

import 'goal_history.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int chek = 1;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: 80.h,
        width: 100.w,
        // color: color,
        child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: kSignupColor,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 25.sp),
                  tabs: [
                    Tab(child: tab_style("All", 1)),
                    Tab(child: tab_style("Running", 2)),
                    Tab(child: tab_style("Completed", 3)),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        GoalsHistory(tabKey: 1),
                        GoalsHistory(tabKey: 2),
                        GoalsHistory(tabKey: 3),
                      ]),
                ),
              ],
            )),
      ),
    );
  }

  Widget tab_style(String title, int indx) {
    return Container(
      height: 10.h,
      // width: 100.w,
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.black12, width: 1),
          color: Colors.white,
          // color: Color(0xffF8DB08),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
