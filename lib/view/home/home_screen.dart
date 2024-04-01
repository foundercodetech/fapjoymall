import 'dart:convert';
import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/main.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/api_urls.dart';
import 'package:fapjoymall/res/helper/api_helper.dart';
import 'package:fapjoymall/view/home/notification.dart';
import 'package:fapjoymall/view/home/widgets/category_elements.dart';
import 'package:fapjoymall/view/home/widgets/category_widgets.dart';
import 'package:fapjoymall/view/home/widgets/slider_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  void initState() {
    versionCheck();
    // TODO: implement initState
    super.initState();
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();
  int selectedCategoryIndex = 0;

  bool verssionview = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => showAlert(context));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Image.asset(Assets.imagesAppBarSecond,height: 45,color: Colors.white,),
        actions: [
          kIsWeb==true?
          IconButton(
            onPressed: () {
              _launchURL2();
            },
            icon: const Icon(Icons.download_for_offline,color:Colors.white),
          ):

          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
              },
              child: Image.asset(Assets.iconsMsg)),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SliderWidget(),
              CategoryWidget(
                onCategorySelected: (index) {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
              ),
              CategoryElement(selectedCategoryIndex: selectedCategoryIndex),
            ],
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    verssionview == true
        ? showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Image.asset(Assets.imagesAppBarSecond,color: Colors.red,height: 45,),
                const Text('new version are available',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                Text(
                    'Update your app  ${ApiUrl.version}  to  $map',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              _launchURL();
              print(versionlink);
              print("versionlink");
            }, child: Text("UPDATE"))

          ],
        ))
        : Container();
  }

  var map;
  var versionlink;

  Future<void> versionCheck() async {
    final response = await http.get(
      Uri.parse(ApiUrl.versionlink),
    );
print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
      print('rrrrrrrr');
      if (responseData['version'] != ApiUrl.version) {
        setState(() {
          map = responseData['version'];
          versionlink = responseData['link'];
          verssionview=true;
        });
      } else {
        print('Version is up-to-date');
      }
    } else {
      print('Failed to fetch version data');
    }
  }

  _launchURL() async {
    var url = versionlink.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL2() async {
    var url = "https://fapjoymall.com/fapjoymall.apk";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}