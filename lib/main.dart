import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nicotine/Screens/Shop%20Screen/models/cart_model.dart';
import 'package:nicotine/Screens/Shop%20Screen/provider/cart_provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'Screens/start_up.dart';
import 'blocs/Activity/activity_bloc.dart';
import 'blocs/Goal/goal_bloc.dart';
import 'blocs/User/user_bloc.dart';
import 'package:provider/provider.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  Paint.enableDithering = true;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox("cart_model");
  runApp(ChangeNotifierProvider<CartProvider>(
      child: const MyApp(), create: (_) => CartProvider()));
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
