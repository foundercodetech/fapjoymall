import 'dart:convert';

import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/main.dart';
import 'package:fapjoymall/model/user_model.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/api_urls.dart';
import 'package:fapjoymall/res/components/app_bar.dart';
import 'package:fapjoymall/res/components/app_btn.dart';
import 'package:fapjoymall/res/components/text_field.dart';
import 'package:fapjoymall/res/components/text_widget.dart';
import 'package:fapjoymall/res/provider/user_view_provider.dart';
import 'package:fapjoymall/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {


  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController oldPassCon = TextEditingController();
  TextEditingController newPassCon = TextEditingController();
  TextEditingController confirmPassCon = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: GradientAppBar(
          leading: AppBackBtn(),
          title: textWidget(
              text: 'Change Password',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: height*0.01,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.iconsPassword,
                            height: 30,
                          ),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'Old Password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.secondaryTextColor)
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.01,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: CustomTextField(
                        obscureText: hideSetPassword,
                        controller: oldPassCon,
                        maxLines: 1,
                        hintText: 'Enter your old password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideSetPassword = !hideSetPassword;
                              });
                            },
                            icon: Image.asset(hideSetPassword
                                ? Assets.iconsEyeClose
                                : Assets.iconsEyeOpen)),
                      )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.iconsPassword,
                            height: 30,
                          ),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'New Password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.secondaryTextColor)
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: CustomTextField(
                          obscureText: hideSetPassword,
                          controller: newPassCon,
                          maxLines: 1,
                          hintText: 'Please enter the new password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hideSetPassword = !hideSetPassword;
                                });
                              },
                              icon: Image.asset(hideSetPassword
                                  ? Assets.iconsEyeClose
                                  : Assets.iconsEyeOpen)),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.iconsPassword,
                            height: 30,
                          ),
                          const SizedBox(width: 20),
                          textWidget(
                              text: 'Confirm Password',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.secondaryTextColor)
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: CustomTextField(
                          obscureText: hideSetPassword,
                          controller: confirmPassCon,
                          maxLines: 1,
                          hintText: 'Please re-enterpassword',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hideSetPassword = !hideSetPassword;
                                });
                              },
                              icon: Image.asset(hideSetPassword
                                  ? Assets.iconsEyeClose
                                  : Assets.iconsEyeOpen)),
                        )),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                      child: AppBtn(
                        loading: changeLoading,
                        title: 'U p d a t e',
                        fontSize: 20,
                        titleColor: AppColors.gradientFirstColor,
                        onTap: () {
                          Changepass(oldPassCon.text,newPassCon.text,confirmPassCon.text);
                        },
                        gradient: AppColors.secondaryGradient,
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
  bool changeLoading = false;
  UserViewProvider userProvider = UserViewProvider();

  Changepass(String oldpass, String newpass,String confirmpass) async {
    setState(() {
      changeLoading =true;
    });
    if (kDebugMode) {
      print("guycyg");
    }
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(token);
    }
    final response = await http.post(Uri.parse(ApiUrl.changepasswordapi),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic >{
          "userid":token,
          "old_password":oldpass,
          "new_password":newpass,
          "confirm_password":confirmpass
        })
    );
    try{
    if(response.statusCode==200){
      setState(() {
        changeLoading= false;
      });
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
        print("👍👍👍👍updatee");
      }
      if(data["status"]=="200"){
        setState(() {
          changeLoading=false;
        });
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);

      }
      else {
        setState(() {
          changeLoading=false;
        });
        Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
      }
    }
    else{
      setState(() {
        changeLoading=false;
      });
      throw Exception("error");
    }}catch(e){
      setState(() {
        changeLoading = false;
      });
      print(e);
      Utils.flushBarErrorMessage("Something went Wrong\n   try again", context, Colors.white);
    }

  }









}
