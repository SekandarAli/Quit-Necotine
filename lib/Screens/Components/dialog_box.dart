import 'package:flutter/material.dart';
import 'package:nicotine/Screens/Components/dialog_box_width_button.dart';

learnMoreDialogBox(
    {required BuildContext context,
    required String heading,
    required String content,
    required String buttonText,
    required void Function() function}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 5),
          insetPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //     padding: EdgeInsets.zero,
                //     onPressed:,
                //     icon: ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Text(heading,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 13,
                        // margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Image.asset('assets/crossNoBackground.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                    )),

                SizedBox(height: 20),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Container(
                    //       // height: 13,
                    //       // margin: const EdgeInsets.symmetric(vertical: 5),
                    //       // child: Text('Cancel'),
                    //       ),
                    // ),
                    // DialogBoxWidthButton(
                    //     text: "Cancel",
                    //     func: () {
                    //       Navigator.of(context).pop();
                    //     },
                    //     isFullWidth: false,
                    //     isOutlined: true),
                    DialogBoxWidthButton(
                        text: buttonText,
                        func: function,
                        isFullWidth: true,
                        isOutlined: false),
                  ],
                ),
                // SizedBox(height: 20),
              ],
            ),
          ),
        );
      });
}
