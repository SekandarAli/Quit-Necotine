import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Forum/forum_screen.dart';
import 'package:nicotine/Screens/Home%20Screens/calender_screen.dart';
import 'package:nicotine/Screens/Home%20Screens/dash_bord.dart';
import 'package:nicotine/Screens/Home%20Screens/goals_screen.dart';
import 'package:nicotine/Screens/Home%20Screens/profile_screen.dart';
import 'package:nicotine/Screens/ServiceProvider/service_provider_screen.dart';
import 'package:nicotine/Screens/Shop%20Screen/shop_screen.dart';
import 'package:nicotine/resources/firebase_services/auth_methods.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/User/user_bloc.dart';
import '../../pedometer/screens/pedometer.dart';
import '../auth_screens/login_screen.dart';
import '../my_activity.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      // width: 40.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 6.h,
          ),
          Container(
            height: 15.h,
            width: 40.w,
            child: Image.asset("assets/Quitnicotine1.png"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DashBord()));
            },
            child: Container(
                width: 48.w,
                child: Text(
                  "Monitor Your Activity",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForumScreen(),
                ),
              );
            },
            child: Container(
                width: 48.w,
                child: Text(
                  "Forum",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          GestureDetector(
            //MyActivity
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyActivity(),
                ),
              );
            },
            child: Container(
                width: 48.w,
                child: Text(
                  "My Activity",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          GestureDetector(
            //GoalsScreen(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoalsScreen(
                    show_appbar: true,
                  ),
                ),
              );
            },
            child: Container(
                width: 48.w,
                child: Text(
                  "My Goal",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PedoMeter()),
              );
            },
            child: Container(
                width: 48.w,
                child: Text(
                  "Walk Steps",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalenderScreen(
                          show_appbar: true,
                        )),
              );
            },
            child: Container(
                width: 48.w,
                child: Text(
                  "Calendar",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopScreen()),
              );
            },
            child: Container(
                width: 48.w,
                child: Text(
                  "Shop",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServiceProvider()),
              );
            },
            child: Container(
                width: 48.w,
                child: Text(
                  "Service Provider",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          fromDrawer: true,
                        )),
              );
            },
            child: SizedBox(
                width: 48.w,
                child: Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                )),
          ),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserInitialNew) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
            child: GestureDetector(
              onTap: () {

                AuthMethods().signOut().then((value) {

                  if(value=="success"){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }  else{

                  }
                });

              },
              child: Container(
                  width: 48.w,
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                        color: kSignupColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
        ],
      ),
    );
  }
}
