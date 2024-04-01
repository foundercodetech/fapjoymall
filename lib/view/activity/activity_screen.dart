import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/main.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/components/app_bar.dart';
import 'package:fapjoymall/res/components/text_widget.dart';
import 'package:fapjoymall/view/account/gifts.dart';
import 'package:fapjoymall/view/activity/attendence_bonus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          title: Image.asset(
            Assets.imagesAppBarSecond,
            height: 44,
            color: Colors.white,
          ),
          gradient: AppColors.primaryGradient),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration:
                  const BoxDecoration(gradient: AppColors.primaryGradient),
              child: ListTile(
                title: textWidget(
                    text: 'Activity',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: AppColors.primaryTextColor),
                subtitle: textWidget(
                    text:
                        'Please remember to follow the event page\nWe will launch user feedback activities from time to time',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.primaryTextColor),
              ),
            ),
            const SizedBox(height: 09),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  redeemWidget(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const GiftsPage()));
                  }, Assets.imagesGiftRedeem, 'Gifts',
                      'Enter the redemption code to receive gift rewards'),
                  redeemWidget(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttendenceBonus()));
                  }, Assets.imagesSignInBanner, 'Attendance bonus',
                      'The more consecutive days you sign in, the higher the reward will be.'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget redeemWidget(Function()? onTap, String image, String title, String subTitle)                                  {
    
    return GestureDetector(
      onTap: onTap,
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height*0.15,
            width: width*0.45,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(image),fit: BoxFit.fill),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: textWidget(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: width*0.4,
              child: textWidget(
                  text: subTitle,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.secondaryTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
