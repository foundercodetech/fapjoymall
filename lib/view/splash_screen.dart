import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/main.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/components/text_widget.dart';
import 'package:fapjoymall/res/provider/services/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.red
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height*0.40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(Assets.imagesSplash),fit: BoxFit.contain)
              ),
          ),
          const SizedBox(height: 20),
          textWidget(
              text: 'Withdraw fast, safe and stable',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor),
          const SizedBox(height: 5),
          textWidget(
              text: 'Quick withdraw',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor),
          const SizedBox(height: 50),

          Image.asset(Assets.imagesAppBarSecond, height: 50,color: Colors.white,)
        ],
      ),
    ));
  }
}
