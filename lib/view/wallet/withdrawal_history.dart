// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/main.dart';
import 'package:fapjoymall/model/user_model.dart';
import 'package:fapjoymall/model/withdrawhistory_model.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/api_urls.dart';
import 'package:fapjoymall/res/components/app_bar.dart';
import 'package:fapjoymall/res/components/app_btn.dart';
import 'package:fapjoymall/res/components/text_widget.dart';
import 'package:fapjoymall/res/helper/api_helper.dart';
import 'package:fapjoymall/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;



class WithdrawHistory extends StatefulWidget {
  const WithdrawHistory({super.key});

  @override
  State<WithdrawHistory> createState() => _WithdrawHistoryState();
}

class _WithdrawHistoryState extends State<WithdrawHistory> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    withdrawHistoryyy();
    super.initState();
    selectedCatIndex = 0;
  }
  late int selectedCatIndex;

  int ?responseStatuscode;
  bool errorOccured = false;

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Withdraw History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: errorOccured
            ? buildErrorContainer(() => withdrawHistoryyy())
            : ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            responseStatuscode == 400
                ? const Notfounddata()
                : withdrawItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                :Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: withdrawItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: width * 0.30,
                                      decoration: BoxDecoration(
                                          color: withdrawItems[index].status ==
                                              "0"
                                              ? Colors.orange
                                              : withdrawItems[index].status ==
                                              "1"
                                              ? AppColors.depositButton
                                              : Colors.red,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: textWidget(
                                          text: withdrawItems[index].status ==
                                              "0"
                                              ? "Pending"
                                              : withdrawItems[index].status ==
                                              "1" ? "Complete" : "Failed",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Balance",
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                  textWidget(
                                      text: "₹${withdrawItems[index].amount}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Account No.",
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                  textWidget(
                                      text: withdrawItems[index].accountno
                                          .toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Time",
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor),

                                  Text(
                                    DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                        DateTime.parse(withdrawItems[index].date
                                            .toString())),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,),),
                                ],
                              ),
                            ),


                          ],
                        ),
                      );
                    })

            ),
          ],
        ),
      ),

    );
  }



  Widget buildErrorContainer(VoidCallback onRetry) {
    final heights = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: const AssetImage(Assets.imagesNoDataAvailable),
            height: heights / 3,
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
                text: 'Failed to load data',
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


  UserViewProvider userProvider = UserViewProvider();

  List<WithdrawModel> withdrawItems = [];

  Future<void> withdrawHistoryyy() async {
    try {
      UserModel user = await userProvider.getUser();
      String token = user.id.toString();

      final response = await http.get(Uri.parse(ApiUrl.withdrawHistory+token));
      if (kDebugMode) {
        print(ApiUrl.withdrawHistory+token);
        print('withdrawHistory');
      }
      setState(() {
        responseStatuscode = response.statusCode;
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          withdrawItems = responseData.map((item) => WithdrawModel.fromJson(item)).toList();
          // selectedIndex = items.isNotEmpty ? 0:-1; //
        });
      }
      else if (response.statusCode == 400) {
        if (kDebugMode) {
          print('Data not found');
        }
      }
      else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Set error state
      setState(() {
        withdrawItems = [];
        errorOccured = true;
      });
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
    }
  }
}




class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        SizedBox(height: height*0.07),
        const Text("Data not found",)
      ],
    );
  }

}
