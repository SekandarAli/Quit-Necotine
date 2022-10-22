import  'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Drawer%20Screen/drawer_screen.dart';
import 'package:nicotine/blocs/Goal/goal_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../Constant.dart';
import '../../blocs/User/user_bloc.dart';
import '../add_goal_screen.dart';
import '../my_activity.dart';
import 'calender_screen.dart';
import 'goals_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class DashBord extends StatefulWidget {
  DashBord({
    Key? key,
  }) : super(key: key);

  @override
  _DashBordState createState() => _DashBordState();
}

class _DashBordState extends State<DashBord>
    with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.home_filled,
    Icons.calendar_today_rounded,
    Icons.article,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
    BlocProvider.of<GoalBloc>(context).add(GetUserGoals());

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
     return  BlocProvider(

         create: (context) => UserBloc()..add(CheckIfLoggedIn()),
    child:  Theme(
      data: ThemeData.light(),
      child: Scaffold(
        // extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          actions: [
            // Icon(
            //   Icons.facebook_rounded,
            //   size: 25.sp,
            //   color: Colors.lightBlue,
            // ),
            // SizedBox(
            //   width: 4.w,
            // )
          ],
          leading: Padding(
            padding: EdgeInsets.only(left: 5.sp),
            child: Container(
              margin:
                  EdgeInsets.only(top: 1.h, bottom: 1.h, left: 1.w, right: 1.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.grid_view,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Monitor Your Activity ",
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
          ),
        ),
        drawer: Container(
          width: 60.w,
          child: Drawer(
            child: DrawerScreen(),
          ),
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Row(
              children: [
                if (_bottomNavIndex == 0) HomeScreen(),
                if (_bottomNavIndex == 1)
                  CalenderScreen(
                    show_appbar: false,
                  ),
                if (_bottomNavIndex == 2)
                  GoalsScreen(
                    show_appbar: false,
                  ),
                if (_bottomNavIndex == 3)
                  Container(
                    height: 110.h,
                    width: 100.w,
                    color: Colors.white,
                    child: ProfileScreen(
                      fromDrawer: false,
                    ),
                  ),
              ],
            ),
          ),
        ),
        // body: NavigationScreen(
        //   iconList[_bottomNavIndex],
        // ),
        floatingActionButton: ScaleTransition(
          scale: animation,
          child: FloatingActionButton(
            elevation: 8,
            backgroundColor: HexColor('#D61E3C'),
            child: Icon(
              Icons.add,
              size: 32.sp,
              color: HexColor('#FFFFFF'),
            ),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                    alignment: Alignment.bottomCenter,
                    backgroundColor: Colors.white,
                    // kLightColor,
                    titlePadding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Container(
                      height: 12.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // kLightColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSignupColor, width: 2.sp)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyActivity(),
                                ),
                              );
                            },
                            child: Text(
                              "Upload Your Activity",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 1.5.h),
                            height: 0.2.h,
                            width: 70.w,
                            color: kSignupColor,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddGoalScreen(),
                                  ));
                            },
                            child: Text(
                              "Add a New Goal",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    )),
              );
              // _animationController.reset();
              // _animationController.forward();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          elevation: 8,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? HexColor('#D61E3C') : Colors.grey.shade700;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 22.sp,
                  color: color,
                ),
              ],
            );
          },
          backgroundColor: Colors.white,
          // HexColor('#505050'),
          activeIndex: _bottomNavIndex,
          splashColor: HexColor('#D61E3C'),
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  NavigationScreen(this.iconData) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: CircularRevealAnimation(
          animation: animation,
          centerOffset: Offset(80, 80),
          maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
          child: Icon(
            Icons.email_outlined,
            color: HexColor('#FFA400'),
            size: 160,
          ),
        ),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
