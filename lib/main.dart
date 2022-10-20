import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Shop%20Screen/provider/cart_provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';
import 'Screens/start_up.dart';
import 'blocs/Activity/activity_bloc.dart';
import 'blocs/Goal/goal_bloc.dart';
import 'blocs/User/user_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserBloc()..add(CheckIfLoggedIn()),
            ),
            BlocProvider(create: (context) => ActivityBloc()),
            BlocProvider(create: (context) => GoalBloc()),
          ],
          child: OverlaySupport(
            child: ChangeNotifierProvider(
              create: (_) => CartProvider(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(unselectedWidgetColor: Colors.white),
                home: const StartUp(),
              ),
            ),
          ));
    });
  }
}
