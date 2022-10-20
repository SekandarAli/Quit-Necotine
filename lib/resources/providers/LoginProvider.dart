import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

Future<Map<String, dynamic>> loginViaGoogle() async {
  // User user = User(email: ' ', first_name: " ", last_name: " ");
  print('Google login done1');

  Map<String, dynamic> googleLoginCreds = {
    "email": null,
    "first_name": null,
  };
  try {
    await _googleSignIn.signIn().then((GoogleSignInAccount? acc) async {
      print('Google login done1.5');

      // user =
      //     User(email: acc!.email, first_name: acc.displayName!, last_name: " ");

      Map<String, dynamic> googleLoginNewCreds = {
        "email": acc!.email,
        "first_name": acc.displayName,
      };
      googleLoginCreds = googleLoginNewCreds;

      // socialLoginFirestoreService(googleLoginCreds, context);
      // print(acc?.id);
      // print(acc?.email);
      // print(acc?.displayName);
      // print(acc?.photoUrl);

      // user.email = acc.email;
      // user.name = acc.displayName;
      // user.image = acc.photoUrl;
    });
  } catch (e) {
    print("Thrown Exception");
    print(e.toString());
  }

  return googleLoginCreds;
}

Future<Map<String, dynamic>> loginViaFacebook() async {
  // User user = User();
  Map<String, dynamic> facebookLoginCreds = {
    "email": null,
    "first_name": null,
  };
  try {
    final FacebookAuth _facebookAuth = FacebookAuth.instance;
    final LoginResult result = await _facebookAuth.login();

    // print("login start");
    // final LoginResult result = await FacebookAuth.login();
    // print("login start 2");
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      // print(accessToken);
      // print(accessToken.token);

      // print(accessToken);
      // print(accessToken.token);
      // print(accessToken.expires);
      // print(accessToken.grantedPermissions);
      // print(accessToken.userId);
      // print(accessToken.isExpired);

      final token = accessToken.token;

      final url = Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=$token');

      /// for profile details also use the below code
      final graphResponse = await http.get(url);
      final profile = json.decode(graphResponse.body);
      print("Here is your profile");
      print(profile);
      print(profile['picture']['data']['url']);
      Map<String, dynamic> facebookLoginNewCreds = {
        "email": profile['email'],
        "first_name": profile['name'],
      };
      facebookLoginCreds = facebookLoginNewCreds;

      // user.email = profile['email'];
      // user.name = profile['name'];
      // user.image = profile['picture']['data']['url'];
      // print(user.image);
    } else {
      print("Login Failed");
    }
  } catch (e) {
    print("Error in login via facebook");
    print(e.toString());
    throw Exception(e.toString());
  }
  return facebookLoginCreds;
  // print('FB login done');
  // return user;
}

  // final res = await widget.plugin.expressLogin();
  // if (res.status == FacebookLoginStatus.success) {
  //   await _updateLoginInfo();
  // } else {
  //   await showDialog<Object>(
  //     context: context,
  //     builder: (context) => const AlertDialog(
  //       content: Text("Can't make express log in. Try regular log in."),
  //     ),
  //   );
  // }
  // var facebookLoginResult =
  //     await facebookLogin.logInWithReadPermissions(['email']);
  // switch (facebookLoginResult.status) {
  //   case FacebookLoginStatus.error:
  //     print("Error");
  //     // onLoginStatusChanged(false);
  //     break;
  //   case FacebookLoginStatus.cancelledByUser:
  //     print("CancelledByUser");
  //     // onLoginStatusChanged(false);
  //     break;
  //   case FacebookLoginStatus.loggedIn:
  //     print("LoggedIn");
  //     // onLoginStatusChanged(true);
  //     break;
  // }

