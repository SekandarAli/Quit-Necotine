import 'package:flutter/material.dart';
import 'package:nicotine/Screens/ServiceProvider/service_card.dart';
import 'package:sizer/sizer.dart';

import '../../Constant.dart';
import '../../models/ServiceItem.dart';
import '../Components/backButton.dart';

class ServiceProvider extends StatefulWidget {
  const ServiceProvider({Key? key}) : super(key: key);

  @override
  State<ServiceProvider> createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  List<ServiceItem> serviceItem = [
    ServiceItem(
        image: "assets/theSchoolOfHealth.PNG",
        url: "https://www.schoolofhealth.com/",
        itemName: "The School of Health",
        color: Colors.white),
    ServiceItem(
        image: "assets/liveAsYourSelf.PNG",
        url: "https://humandesign.org.uk/living-your-design-course",
        itemName: "Live as Yourself",
        color: Colors.white),
    ServiceItem(
        image: "assets/sarahRaven.PNG",
        url: "https://www.sarahraven.com/",
        itemName: "Sarah Raven",
        color: Colors.white),
    ServiceItem(
        image: "assets/medical.jpeg",
        url: "http://www.medical-station-project.co.uk",
        itemName: "Medical Station",
        color: Colors.white),
    // ServiceItem(
    //     image: "",
    //     url: "http://4medicinalpurposesonly.com/",
    //     itemName: "4 Medicinal Purposes Only",
    //     color: kSigninColor),
    ServiceItem(
        image: "assets/addictedToAbuse.PNG",
        url: "http://addictedtoabuse.com",
        itemName: "Addicted to Abuse",
        color: Colors.white),
    ServiceItem(
        image: "assets/beginWithTheEnd.png",
        url: "https://www.begin-with-the-end-in-mind.com/",
        itemName: "Begin with the end in mind",
        color: kSigninColor),
    // ServiceItem(
    //     image: "assets/theBotanicalLife.PNG",
    //     url: "http://www.botanical-life.co.uk/",
    //     itemName: "The Botanical Life",
    //     color: Colors.white),
    ServiceItem(
        image: "assets/botanicalLifeLocal.png",
        url: "https://www.botanicalhairlounge.co.uk/",
        itemName: "Botanical Hair Lounge UK",
        color: Colors.white),
    ServiceItem(
        image: "assets/botanicalLifeOriginal.png",
        url: "http://botanicalhairlounge.com/",
        itemName: "Botanical Hair Lounge",
        color: Colors.white),
    // ServiceItem(
    //     image: "",
    //     url: "http://childrenarenotbornnaughty.com/",
    //     itemName: "Children are not born naughty",
    //     color: kSigninColor),
    ServiceItem(
        image: "assets/d4r.png",
        url: "http://discovery4recovery.com/",
        itemName: "Discovery 4 Recovery",
        color: kSigninColor),
    ServiceItem(
        image: "assets/hairHealthPracticioner.png",
        url: "http://hairhealthpractitioners.co.uk/",
        itemName: "Hair Health Practitioners",
        color: Colors.white),
    // ServiceItem(
    //     image: "",
    //     url: "https://hairlossandhairthinningsolutions.com/",
    //     itemName: "Hair loss and hair thinning solutions",
    //     color: kSigninColor),
    ServiceItem(
        image: "assets/HST-1.png",
        url: "http://hairsciencetherapy.org/",
        itemName: "Hair science therapy",
        color: Colors.white),
    ServiceItem(
        image: "assets/heaven HQ LTD.png",
        url: "http://heavenhqltd.com/",
        itemName: "Heaven HQ LTD",
        color: Colors.white),
    ServiceItem(
        image: "assets/learnEarnAndGrowRich.jpg",
        url: "https://www.learnearnandgrowrich.com/",
        itemName: "Learn earn and grow rich",
        color: Colors.white),
    ServiceItem(
        image: "assets/power of an hour.png",
        url: "https://www.power-of-an-hour.com/",
        itemName: "Power of an hour",
        color: Colors.white),
    // ServiceItem(
    //     image: "",
    //     url: "http://nospeak.org/",
    //     itemName: "No Speak",
    //     color: kSigninColor),
    ServiceItem(
        image: "assets/saltLiteLogoV2.jpg",
        url: "http://saltandlite.org/",
        itemName: "Salt + Lite",
        color: Colors.white),
    // ServiceItem(
    //     image: "",
    //     url: "http://sellwhatyouloveandlovewhatyousell.com/",
    //     itemName: "Sell what you love and love what you sell",
    //     color: kSigninColor),
    // ServiceItem(
    //     image: "",
    //     url: "http://standingonyourown2feet.com/",
    //     itemName: "Standing on your own 2 feet",
    //     color: kSigninColor),
    ServiceItem(
        image: "assets/SWEENEY TODDS.png",
        url: "http://sweeneytoddsenterprise.com/",
        itemName: "Sweeney Todds Enterprise",
        color: Colors.white),
    // ServiceItem(
    //     image: "",
    //     url: "http://thehairdoctors.co.uk/",
    //     itemName: "The Hair Doctors",
    //     color: kSigninColor),
    ServiceItem(
        image: "assets/SwimmersWorld.png",
        url: "http://swimmersworld.org/",
        itemName: "Swimmers World",
        color: Colors.white),
    // ServiceItem(
    //     image: "",
    //     url: "http://theyearwenearlylostchristmas.com/",
    //     itemName: "The year we nearly lost christmas",
    //     color: kSigninColor),
    // ServiceItem(
    //     image: "",
    //     url: "http://thisisyourlife.world/",
    //     itemName: "This is your life",
    //     color: kSigninColor),
    // ServiceItem(
    //     image: "",
    //     url: "http://whatsupwecare.com/",
    //     itemName: "Whats up we care",
    //     color: kSigninColor),
    ServiceItem(
        image: "assets/whereDoIGoFromHereV2.jpg",
        url: "http://wheredoigofromhereacademy.com/",
        itemName: "Where do I go from here academy",
        color: Colors.white),
    // ServiceItem(
    //     image: "",
    //     url: "http://womenwhodotoomuch.org/",
    //     itemName: "Women who do too much",
    //     color: kSigninColor),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        backgroundColor: Colors.white,
        title: Text(
          "Service Provider",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: ListView.builder(
            itemCount: serviceItem.length,
            itemBuilder: (BuildContext context, int index) {
              return ServiceCard(
                  serviceItem: serviceItem[index],
                  isAsset: (index == 0) ? false : true);
            }),
      ),
    );
  }
}
