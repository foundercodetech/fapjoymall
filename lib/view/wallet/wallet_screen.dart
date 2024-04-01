import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fapjoymall/main.dart';
import 'package:flutter/services.dart';
import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/components/app_bar.dart';
import 'package:fapjoymall/res/components/text_widget.dart';
import 'package:fapjoymall/res/helper/api_helper.dart';
import 'package:fapjoymall/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fapjoymall/view/wallet/wallet_history.dart';
import 'package:provider/provider.dart';
import '../../res/provider/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  BaseApiHelper baseApiHelper = BaseApiHelper();
  late Future<void> walletApi;
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
    walletfetch(context);
    walletApi = walletfetch(context);
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged
            .listen(_updateConnectionStatus);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final walletdetails = Provider.of<WalletProvider>(context).walletlist;

   
    if(hasError){
      return buildErrorContainer(errorText, () {
        setState(() {
          hasError = false;
        });
        walletfetch(context);
      });
    }
    return _connectionStatus == ConnectivityResult.none
        ?Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: const AssetImage(Assets.imagesNoDataAvailable),
            height: height / 3,
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
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Wallet', fontSize: 25, color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: FutureBuilder(
        future: walletApi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return   Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 135,
                      width: width,
                      decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient),
                      child: Column(
                        children: [
                          Image.asset(Assets.iconsWallets),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.currency_rupee,
                                  size: 20, color: AppColors.iconSecondColor),
                              textWidget(
                                  text: walletdetails!.wallet.toString(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.primaryTextColor),
                              InkWell(
                                  onTap: (){
                                    walletfetch(context);
                                  },
                                  child: Image.asset(Assets.iconsTotalBal,height: height*0.03,color: Colors.white,),),
                            ],
                          ),
                          textWidget(
                            text: 'Total Balance',
                            color: AppColors.primaryTextColor,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: height * 0.13,
                    child: Container(
                      height: height * 0.50,
                      width: width * 0.95,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 35, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WalletHistory(
                                                name: "Winning Wallet",
                                                type: "1")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Container(
                                      height: height * 0.10,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Winning Wallet",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textWidget(
                                            text: "₹ ${walletdetails.winning_wallet}",
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WalletHistory(
                                                name: "Bonus",
                                                type: "3")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Container(
                                      height: height * 0.10,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Bonus",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textWidget(
                                            text: "₹ ${walletdetails.bonus}",
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => const WalletHistory(name: "Commission",type: "2")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Container(
                                      height: height * 0.10,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Commission",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textWidget(
                                            text: "₹ ${walletdetails.commission}",
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => const WalletHistory(name: "Interest",type: "32")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Container(
                                      height: height * 0.10,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Interest",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textWidget(
                                            text:  walletdetails.wallet_interest==null?"₹ 0":"₹ "+walletdetails.wallet_interest.toString(),
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 40),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                itemWidget(() {
                                  Navigator.pushNamed(context, RoutesName.depositScreen);
                                }, Assets.iconsProDeposit, 'Deposit'),
                                itemWidget(() {
                                  Navigator.pushNamed(context, RoutesName.withdrawScreen);
                                }, Assets.iconsProWithdraw, 'Withdraw'),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ],
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


  Future<void> walletfetch(context) async {
    try {
      final walletData = await baseApiHelper.fetchWalletData();
      Provider.of<WalletProvider>(context, listen: false).setWalletList(walletData!);
    } catch (error) {
      setState(() {
        hasError = true;
        errorText = 'An error occurred';
      });
    }
  }


  Widget itemWidget(Function()? onTap, String image, String title) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image, height: 50),
          const SizedBox(height: 10),
          textWidget(
              text: title,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.secondaryTextColor),
        ],
      ),
    );
  }
}
