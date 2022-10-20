import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Home%20Screens/dash_bord.dart';
import 'package:sizer/sizer.dart';

import '../blocs/User/user_bloc.dart';
import 'auth_screens/login_screen.dart';

class StartUp extends StatefulWidget {
  const StartUp({Key? key}) : super(key: key);

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserInitial) {
              Timer(const Duration(milliseconds: 3000), () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              });
            } else if (state is UserLoggedIn) {
              print(state);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DashBord()));
            } else if (state is UserSplashScreen) {}
          },
          child: Stack(children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/1235.png',
                          ),
                          fit: BoxFit.fitWidth),
                    ))),
            Center(
                child: Container(
                    width: 60.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                      // color: Colors.black,
                      image: DecorationImage(
                          image: AssetImage('assets/Quitnicotine1.png'),
                          fit: BoxFit.fitWidth),
                    ))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                // 'Black is the new Red 4 Green to get yourself clean',
                'RED 4 GREEN TO MAKE YOU CLEAN.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Evertone two',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  height: 1.2,
                ),
              ),
            ),
          ])),
    );
  }
}
