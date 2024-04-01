import 'dart:convert';
import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/main.dart';
import 'package:fapjoymall/model/attendence_model.dart';
import 'package:fapjoymall/model/user_model.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/api_urls.dart';
import 'package:fapjoymall/res/components/app_bar.dart';
import 'package:fapjoymall/res/components/app_btn.dart';
import 'package:fapjoymall/res/components/text_widget.dart';
import 'package:fapjoymall/res/provider/user_view_provider.dart';
import 'package:fapjoymall/view/activity/attendence_history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class AttendenceBonus extends StatefulWidget {
  const AttendenceBonus({super.key});

  @override
  State<AttendenceBonus> createState() => _AttendenceBonusState();
}

class _AttendenceBonusState extends State<AttendenceBonus> {

  @override
  void initState() {
    AttendenceList();
     attendence_days();
    // TODO: implement initState
    super.initState();
  }

  int ?responseStatuscode;

  @override
  Widget build(BuildContext context) {

    String? lastDay = AttendenceItems.isNotEmpty?AttendenceItems.last.datetime.toString():"";
    String lastAmount = AttendenceItems.isNotEmpty?AttendenceItems.last.amount.toString():"";
    String lastid = AttendenceItems.isNotEmpty?AttendenceItems.last.id.toString():"";
    String laststatus = AttendenceItems.isNotEmpty?AttendenceItems.last.status.toString():"";



    return Scaffold(
      appBar: GradientAppBar(
          leading: AppBackBtn(),
          title: textWidget(
              text: 'Attendance bonus',
              fontSize: width*0.05,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
        body: ListView(
          children: [
            Container(
              decoration: BoxDecoration(gradient: AppColors.primaryGradient,image: DecorationImage(image: AssetImage(Assets.imagesBggifts),fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                      text: "Attendence Bonus",
                      fontSize: width*0.047,
                      color: Colors.white,
                        fontWeight: FontWeight.bold

                    ),
                    SizedBox(height: height*0.01,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                          text: "Get your rewards based on consecutive \n login days",
                          fontSize: width*0.034,
                          color: Colors.white,
                        ),
                        textWidget(
                          text: "* Tap to claim the daily rewards",
                          fontSize: width*0.04,
                          color: Colors.white,
                            fontWeight: FontWeight.bold

                        ),
                      ],
                    ),
                    SizedBox(height: height*0.01),
                    Container(
                      height: height*0.10,
                      width: width*0.50,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesBookmark),fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.01,),
                          textWidget(
                              text: "Attended consecutively",
                              fontSize: width*0.035,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),
                          SizedBox(height: height*0.01,),
                          textWidget(
                              text: days==null?"":days.toString()+" Days",
                              fontSize: width*0.045,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),
                        ],
                      ),
                    ),
                    textWidget(
                      text: "Accumulated",
                      fontSize: width*0.045,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    Row(
                      children: [
                        textWidget(
                          text: amount==null?"":"₹ "+amount.toString(),
                          fontSize:  width*0.05,
                          color: Colors.white,
                        ),
                        InkWell(
                            onTap: (){
                              AttendenceList();
                              attendence_days();
                              },
                            child: Image.asset(Assets.iconsTotalBal, height: 30, color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendenceHistory()));
                      },
                      child: Center(
                        child: Container(
                          height: height*0.045,
                          width: width*0.40,

                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                           gradient: LinearGradient(
                              colors: [Color(0xffff9b3e),Color(0xffffab3f)])),
                          child: Center(
                            child: textWidget(
                              text: "Attendence History",
                              fontSize:  width*0.035,
                              color: Colors.white,
                            ),
                          ) ,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.02,),

            responseStatuscode== 400 ?
            const Notfounddata(): AttendenceItems.isEmpty? const Center(child: CircularProgressIndicator()):

            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: AttendenceItems.length>6?6:AttendenceItems.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  AttendenceItems[index].status=='1'?
                  InkWell(
                    onTap: (){
                      Attendenceget(ids:AttendenceItems[index].id.toString());
                    },
                    child: Card(
                    elevation:  3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: AppColors.secondaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textWidget(
                              text: "₹"+AttendenceItems[index].amount.toString(),
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            Image.asset(Assets.imagesCoingifts, height: 45,),
                            textWidget(
                                text: DateFormat.EEEE().format(
                                    DateTime.parse(AttendenceItems[index].datetime.toString())),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryTextColor
                            ),

                          ],
                        ))),
                  )
                      :AttendenceItems[index].status=='2'?
                  Card(
                      elevation:  1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textWidget(
                                text: "₹"+AttendenceItems[index].amount.toString(),
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              textWidget(
                                  text: 'Reedmed',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                              ),
                              textWidget(
                                  text: DateFormat.EEEE().format(
                                      DateTime.parse(AttendenceItems[index].datetime.toString())),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryTextColor
                              ),

                            ],
                          ))):
                  Card(
                      elevation:  1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textWidget(
                                text: "₹"+AttendenceItems[index].amount.toString(),
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              textWidget(
                                  text: 'Expired',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                              ),

                              textWidget(
                                  text: DateFormat.EEEE().format(
                                      DateTime.parse(AttendenceItems[index].datetime.toString())),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryTextColor
                              ),

                            ],
                          )));
              },
            ),



            if (laststatus=="1") InkWell(
              onTap: (){
                Attendenceget(ids:lastid);
                print(lastid);
                print("lastid");
                },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height*0.20,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),
                  child: SizedBox(
                    width: width*0.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        textWidget(
                            text: "₹"+lastAmount,
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                        lastDay==''?Container():
                        textWidget(
                            text: DateFormat.EEEE().format(
                                DateTime.parse(lastDay.toString())),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryTextColor
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ) else laststatus=="2"?
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                    height: height*0.20,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        textWidget(
                          text:"₹"+lastAmount,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        // Image.asset(Assets.imagesCoingifts, height: 45,),
                        textWidget(
                          text: 'Reedmed',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        lastDay==''?Container():
                        textWidget(
                            text: DateFormat.EEEE().format(
                                DateTime.parse(lastDay.toString())),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryTextColor
                        ),

                      ],
                    ))):
            Card(
                elevation:  1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height*0.20,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration( color: Colors.grey.shade100,image: DecorationImage(image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        textWidget(
                          text: "₹"+lastAmount,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textWidget(
                          text: 'Expired',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,

                        ),
                        lastDay==''?Container():
                        textWidget(
                            text: DateFormat.EEEE().format(
                                DateTime.parse(lastDay.toString())),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryTextColor
                        ),
                      ],
                    )))
          ],
        )
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  List<AttendenceModel> AttendenceItems = [];

  Future<void> AttendenceList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse(ApiUrl.AttendenceList+token),);
    print(ApiUrl.AttendenceList+token);
    print('AttendenceList');

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        AttendenceItems = responseData.map((item) => AttendenceModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        AttendenceItems = [];
      });
      throw Exception('Failed to load data');
    }
  }



///claim api
   Attendenceget( {String? ids}) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

   final response = await http.get(Uri.parse(ApiUrl.AttendenceGet+"userid=$token&tableid=$ids"));


    if (response.statusCode == 200) {
      print(response);
      print("response attendence get");
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);
      print("responseData");
      AttendenceList();

      return Fluttertoast.showToast(msg: responseData['msg']);
    } else {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['msg']);
    }
  }

///container red

  var amount;
  var days;


  Future<void> attendence_days() async {
    UserViewProvider userProvider = UserViewProvider();

    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    print("ffffffffggfhff");

    final url = Uri.parse(ApiUrl.attendenceDays+token);
    final response = await http.get(url,);
    print("fggggggghgggg");
    print(ApiUrl.attendenceDays+token);
    print("ApiUrl.attendenceDays+token");
    if(response.statusCode==200){
      print(response.statusCode);
      print("guyguggggu");
      final responseData = json.decode(response.body);
      amount = responseData["amount"]==null?"":responseData["amount"].toString();
      days = responseData["days"]==null?"":responseData["days"].toString();


      print("guygugu");

    }else{
      throw Exception("load to display");
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

