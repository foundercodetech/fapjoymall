// ignore_for_file: use_build_context_synchronously, deprecated_member_use, no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fapjoymall/main.dart';
import 'package:fapjoymall/res/provider/contactus_provider.dart';
import 'package:flutter/services.dart';
import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/api_urls.dart';
import 'package:fapjoymall/res/components/text_widget.dart';
import 'package:fapjoymall/res/helper/api_helper.dart';
import 'package:fapjoymall/res/provider/profile_provider.dart';
import 'package:fapjoymall/utils/routes/routes_name.dart';
import 'package:fapjoymall/view/account/aboutus.dart';
import 'package:fapjoymall/view/account/change_password.dart';
import 'package:fapjoymall/view/account/logout.dart';
import 'package:fapjoymall/view/account/service_center/privacy_policy.dart';
import 'package:fapjoymall/view/account/service_center/terms_condition.dart';
import 'package:fapjoymall/view/home/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late Future<void> profileFuture;
  bool hasError = false;
  String errorText = '';

/// Check internet
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  /// Check internet  with initState Code
  @override
  void initState() {
    fetchcontact();
    profileFuture = fetchData();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }


  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override

  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileProvider>(context).userData;
    final contactusData = Provider.of<ContactUsProvider>(context).ContactusData;


    

    _launchURL2() async {
      var url = contactusData!.disc.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    List<TranUiModel> tranUiList = [
      TranUiModel(
          image: Assets.iconsBetHistory,
          title: 'Bet',
          subtitle: 'My betting history',
         onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const BetHistory()));
            Navigator.pushNamed(context, RoutesName.Bethistoryscreen);
         }
      ),

      TranUiModel(
          image: Assets.iconsDepositHistory,
          title: 'Deposit',
          subtitle: 'My deposit history',
        onTap: (){
          Navigator.pushNamed(context, RoutesName.depositHistory);
          }
      ),
      TranUiModel(
          image: Assets.iconsWithdrawHistory,
          title: 'Withdraw',
          subtitle: 'My withdraw history',
        onTap: (){
          Navigator.pushNamed(context, RoutesName.withdrawalHistory);

        }
      ),
    ];
    List<ServiceModel> serviceList = [
      ServiceModel(
        image: Assets.iconsSetting,
        title: 'Profile',
        onTap: (){
          Navigator.pushNamed(context, RoutesName.settingscreen);
        }
      ),
      ServiceModel(
        image: Assets.iconsFeedback,
        title: 'Feedback',
          onTap: (){
          Navigator.pushNamed(context, RoutesName.feedbackscreen);
        }
      ),
      ServiceModel(
        image: Assets.iconsNotification,
        title: 'Notification',
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));

          }
      ),
      ServiceModel(
          image: Assets.iconsCusService,
          title: 'Terms & ',
          subtitle: "Condition",
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const TermsCondition()));

          }
      ),
      ServiceModel(
          image: Assets.iconsBigGuide,
          title: "Privacy Policy",
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicy()));

          }
      ),
      ServiceModel(
        image: Assets.iconsAboutus,
        title: 'About us',
          onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Aboutus()));
          }
      ),
      // ServiceModel(
      //     image: Assets.iconsAboutus,
      //     title: 'Contact us',
      //     onTap: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactUs()));
      //     }
      // ),
      ServiceModel(
          image: Assets.iconsAboutus,
          title: 'Contact us',
          onTap: (){
            _launchURL2();
          }
      ),

    ];
    List<ProInfoModel> proInfoList = [
      ProInfoModel(
        image: Assets.iconsProNotification,
        title: 'Notification',
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));

        }
      ),
      ProInfoModel(
        image: Assets.iconsGift,
        title: 'Gifts',
        onTap: (){
          Navigator.pushNamed(context, RoutesName.giftsscreen);
        }
      ),
      ProInfoModel(
        image: Assets.iconsPassword,
        title: 'Change password',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangePassword()));

        }),

    ];



  if(hasError){
      return buildErrorContainer(errorText, () {
        setState(() {
          hasError = false;
        });
        fetchData();
      });
    }
    return _connectionStatus == ConnectivityResult.none
        ?Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: const AssetImage(Assets.imagesNoDataAvailable),
            height:height / 3,
            width: width / 2,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: Text('There is no Internet connection'),
        ),
        const Padding(
          padding: EdgeInsets.all(4.0),
          child:
          Text('Please check your Internet connection'),
        ),
      ],
    ):

      Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: FutureBuilder(
          future: profileFuture, // Replace with your actual data fetching function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show circular progress indicator while data is loading
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              // Render your main content when data is available
              return  ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * 0.4,
                            width: width,
                            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesProfileBg), fit: BoxFit.fill)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.deepPurple.shade100,
                                    backgroundImage: userData!.photo != null
                                        ? NetworkImage(ApiUrl.uploadimage + userData.photo.toString())
                                        : const AssetImage(Assets.person5) as ImageProvider,
                                  ),

                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                          text: userData.username==null?"MEMBERNGKC":userData.username.toString(),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.primaryTextColor),
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: AppColors.gradientSecondColor,
                                          borderRadius:
                                          BorderRadiusDirectional.circular(30),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              textWidget(
                                                  text: 'UID',
                                                  color: AppColors.primaryTextColor,
                                                  fontSize: 16),
                                              const SizedBox(width: 8),
                                              Container(
                                                width: 2,
                                                height: 18,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 8),
                                              textWidget(
                                                  text: userData.custId==null?'000000':
                                                  userData.custId.toString(),
                                                  color: AppColors.primaryTextColor,
                                                  fontSize: 16),
                                              const SizedBox(width: 8),
                                              InkWell(
                                                  onTap: (){
                                                    fetchData();
                                                  },
                                                  child: Image.asset(Assets.iconsCopy)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      textWidget(
                                          text: '',
                                          // text: 'Last login:  ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(userData.updatedAt.toString()))}',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                              top: 180,
                              child: Container(
                                height: height*0.15,
                                width: width * 0.95,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                          text: 'Total Balance',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 25,
                                          color: AppColors.secondaryTextColor),
                                      Row(
                                        children: [
                                          const Icon(Icons.currency_rupee, size: 25),
                                          textWidget(
                                              text: double.parse(userData.wallet).toStringAsFixed(2),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 25),
                                          InkWell(
                                            onTap: (){
                                              fetchData();
                                            },
                                              child: Image.asset(Assets.iconsTotalBal)),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(9, 0, 9, 5),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: tranUiList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 2,
                                childAspectRatio: 4 / 2),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: tranUiList[index].onTap,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadiusDirectional.circular(15)),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        tranUiList[index].image,
                                        height: 60,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          textWidget(
                                              text: tranUiList[index].title,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                          SizedBox(
                                            width: width * 0.3,
                                            child: textWidget(
                                                text: tranUiList[index].subtitle,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.secondaryTextColor,
                                                maxLines: 2,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemCount: proInfoList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: proInfoList[index].onTap,
                                    leading: Image.asset(proInfoList[index].image),
                                    title: textWidget(
                                        text: proInfoList[index].title,
                                        fontSize: 18,
                                        color: AppColors.secondaryTextColor),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.iconColor,
                                      size: 18,
                                    ));
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10, bottom: 15),
                                child: textWidget(
                                    text: 'Service center',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              GridView.builder(
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount: serviceList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                      crossAxisCount: 3,
                                      childAspectRatio: 2.5 / 2),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: serviceList[index].onTap,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            serviceList[index].image,
                                          ),
                                          textWidget(
                                              text: serviceList[index].title,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: AppColors.secondaryTextColor),
                                          textWidget(
                                              text: serviceList[index].subtitle ?? '',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: AppColors.secondaryTextColor),
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  const EdgeInsets.fromLTRB(10, 30, 10, 50),
                        child: GestureDetector(
                          onTap: ()  {

                            showDialog(context: context, builder: (context)=>const Logout());
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(30),
                                border: Border.all(width: 0.5, color: Colors.grey)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Assets.iconsLogOut),
                                textWidget(
                                    text: '  Log out',
                                    fontSize: 25,
                                    color: AppColors.secondaryTextColor)
                              ],
                            ),
                          ),
                        ),
                      ),
                      // const Text("Version 1.0.0")
                    ],
                  ),
                ),
              );
            }
          },
        ),
    );

  }


  Widget buildErrorContainer(String message, VoidCallback onRetry) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: const AssetImage(Assets.imagesNoDataAvailable),
            height: height / 3,
            width: width / 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              textWidget(
                text: message,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Future<void> fetchcontact() async {
    try {
      final Datacontact = await  baseApiHelper.fetchdataCU();
      print(Datacontact);
      print("Datacontact");
      if (Datacontact != null) {
        Provider.of<ContactUsProvider>(context, listen: false).setCu(Datacontact);
      }
    } catch (error) {
      // Handle error here
    }
  }

  Future<void> fetchData() async {
    try {
      final userDataa = await baseApiHelper.fetchProfileData();
      if (userDataa != null) {
        Provider.of<ProfileProvider>(context, listen: false).setUser(userDataa);
      }
    }  catch (error) {
      // Handle other exceptions
      setState(() {
        hasError = true;
        errorText = 'An error occurred';
      });
    }
  }
}

class TranUiModel {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  TranUiModel({
    required this.image,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
}

class ServiceModel {
  final String image;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  ServiceModel({
    required this.image,
    required this.title,
    this.subtitle,
    this.onTap,
  });
}

class ProInfoModel {
  final String image;
  final String title;
  final VoidCallback? onTap;

  ProInfoModel({
    required this.image,
    required this.title,
    this.onTap,
  });
}
