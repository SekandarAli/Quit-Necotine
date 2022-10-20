import 'package:flutter/material.dart';

import '../../Constant.dart';

class DialogBoxWidthButton extends StatelessWidget {
  final String text;
  final void Function() func;
  //final String image;
  final bool isFullWidth;
  final bool isOutlined;

  const DialogBoxWidthButton({
    required this.text,
    required this.func,
    //required this.image,
    required this.isFullWidth,
    required this.isOutlined,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    // gradient:
    //             LinearGradient(colors: [Color(0xffa4dc61), Color(0xff8bc744)]),
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kSignupColor,

        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        // gradient: LinearGradient(
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        //   colors: buttonColorTheme,
        //   //     <Color>[
        //   //   weellPurple,
        //   //   Colors.deepPurple,
        //   // ],
        //   stops: [0.2, 0.8],
        // ),
      ),
      width: isFullWidth ? size.width * 0.6 : size.width * 0.30,
      height: 40,
      child: ElevatedButton(
        onPressed: func,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              isOutlined ? Colors.white : Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                  color: theme.primaryColor, width: isOutlined ? 1 : 0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          width: isFullWidth ? size.width * 0.6 : size.width * 0.40,
          height: 35,
          // height: size.height * 0.05 < 40 ? size.height * 0.05 : 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //     width: size.width * 0.04,
              //     child: Image.asset(
              //       // 'assets/Icons/tickIcon.png',
              //       image,
              //       color: isOutlined ? theme.primaryColor : Colors.white,
              //       fit: BoxFit.contain,
              //     )),
              // SizedBox(width: 10),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: theme.textTheme.subtitle1?.merge(TextStyle(
                      color: isOutlined ? theme.primaryColor : Colors.white,
                      fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Container(
    //   width: size.width * 0.85,
    //   child: ElevatedButton(
    //     onPressed: func,
    //     child: Text(
    //       text,
    //       style: theme.textTheme.overline.merge(TextStyle(color: Colors.white)),
    //     ),
    //     style: ButtonStyle(
    //       backgroundColor: MaterialStateProperty.all<Color>(theme.primaryColor),
    //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //         RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10.0),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
