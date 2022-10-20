import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/blocs/Activity/activity_bloc.dart';
import 'package:sizer/sizer.dart';
import 'Components/progress_card.dart';

class DaysProgress extends StatefulWidget {
   final String userId;

   DaysProgress({required this.userId});

  @override
  _DaysProgressState createState() => _DaysProgressState();
}

class _DaysProgressState extends State<DaysProgress> {


  @override
  void initState() {
    getID();
    super.initState();

  }
  var dataaaa;
  getID() async{
  var snap= await FirebaseFirestore.instance.collection("activity").where("userId",isEqualTo: widget.userId).snapshots();
  // dataaaa==snap;

  }

  @override
  Widget build(BuildContext context) {
    final activityState = BlocProvider.of<ActivityBloc>(context).state;
    int waterCount = 0;
    int stepsCount = 0;
    int foodCount = 0;
    int cigrettes = 0;
    int herbalMix = 0;
    if (activityState is UserActivitiesRetrieved) {
      final thirtyDaysBegin = DateTime.now().subtract(Duration(days: 30));
      activityState.activities.forEach((element) {
        if (element.activityCreationDate!.isAfter(thirtyDaysBegin)) {
          waterCount = waterCount + element.glassesOfWater!;
          foodCount = foodCount + 878;
          stepsCount = stepsCount + element.stepsWalked!;
          cigrettes = cigrettes + element.cigarettesSmoked!;
          herbalMix = herbalMix + element.herbalMix!;
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        // Padding(
        //   padding: EdgeInsets.only(left: 5.sp),
        //   child: Container(
        //     margin: EdgeInsets.only(top: 1.4.h, bottom: 1.4.h, left: 2.w, right: 2.w),
        //     decoration: BoxDecoration(
        //       color: Colors.black.withOpacity(0.1),
        //       borderRadius: BorderRadius.circular(50),
        //     ),
        //     child:  Builder(builder: (context) =>  IconButton(
        //       onPressed: ()=> Navigator.pop(context),
        //       icon: Icon(Icons.arrow_back_ios_rounded, size: 12.sp,),
        //     ),),
        //   ),
        // ),
        backgroundColor: Colors.white,
        title: Text(
          "30 Days Progress",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        actions: [
          Icon(
            Icons.more_horiz,
            size: 24.sp,
          ),
          SizedBox(
            width: 5.sp,
          ),
        ],
      ),
      body: Container(
          height: 100.h,
          width: 100.w,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),

                ProgressCard(
                  img: "assets/watergreen.png",
                  type: "  Water",
                  score: " ${herbalMix.toString()}\n/ 270",
                  // "  483",
                  hading: "Glasses in 30 days\n",
                  description:
                      "Good hydration helps to flush out toxins, deliver nutrients and oxygen around the body, and boost energy levels",
                ),
                ProgressCard(
                  img: "assets/Vector (7).png",
                  type: "  Steps walked",
                  score:  "${herbalMix.toString()},\n/ 330000",
                  // "  58,483",
                  hading: "Steps walked in 30 days\n",
                  description:
                      "Walking increases cardiovascular fitness, strengthens bones, reduces body fat, and boosts muscle power and endurance",
                ),
                ProgressCard(
                  img: "assets/watergreen.png",
                  type: "  Food",
                  score: " ${foodCount.toString()}\n/ 52680",
                  // "  8,976",
                  hading: "Minerals in 30 days\n",
                  description:
                      "Healthy eating improves gut health, boosts immunity, and lowers the risk of disease, while strengthening muscles and bones",
                ),
                ProgressCard(
                  img: "assets/cigretteRed.png",
                  type: "  Cigrettes Smoked",
                  score: " ${cigrettes.toString()}\n/ 0",
                  // "  8,976",
                  hading: "Cigrettes smoked in 30 days\n",
                  description: " ",
                ),
                ProgressCard(
                  img: "assets/herbalRed.png",
                  type: "  Herbal Mix used",
                  score: " ${herbalMix.toString()}\n/ 200",
                  // "  8,976",
                  hading: "Herbal mix used in 30 days\n",
                  description: " ",
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }
}
// class SalesData {
//   SalesData(this.year, this.sales);
//   final String year;
//   final double sales;
// }
