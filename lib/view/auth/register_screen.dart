import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/res/aap_colors.dart';
import 'package:fapjoymall/res/components/app_bar.dart';
import 'package:fapjoymall/res/components/app_btn.dart';
import 'package:fapjoymall/res/components/text_field.dart';
import 'package:fapjoymall/res/components/text_widget.dart';
import 'package:fapjoymall/res/provider/auth_provider.dart';
import 'package:fapjoymall/utils/routes/routes_name.dart';
import 'package:fapjoymall/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../res/components/rich_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  bool readAndAgreePolicy = false;

  TextEditingController phoneCon = TextEditingController();
  TextEditingController setPasswordCon = TextEditingController();
  TextEditingController confirmPasswordCon = TextEditingController();
  TextEditingController refercodee = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context);

    String argument = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: GradientAppBar(
          title: Image.asset(
            Assets.imagesAppBarSecond,
            height: 55,
            color: Colors.white,
          ),
          leading: argument == '0' ? Container() : const AppBackBtn(),
          gradient: AppColors.primaryGradient),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration:
                      const BoxDecoration(gradient: AppColors.primaryGradient),
                  child: ListTile(
                    title: textWidget(
                        text: 'Register',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: AppColors.primaryTextColor),
                    subtitle: textWidget(
                        text: 'Please register by phone number or email',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.primaryTextColor),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.iconsPhoneTabColor,
                      height: 28,
                    ),
                    const SizedBox(width: 2),
                    textWidget(
                        text: 'Register your phone',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.gradientFirstColor)
                  ],
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(thickness: 0.7, color: AppColors.dividerColor),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.iconsInvitionCode,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      textWidget(
                          text: 'Enter Referral Code',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.secondaryTextColor)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: CustomTextField(
                    controller: refercodee,
                    maxLines: 1,
                    hintText: 'Please Enter Referral code',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.iconsPhone,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      textWidget(
                          text: 'Phone Number',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.secondaryTextColor)
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          child: CustomTextField(
                            enabled: false,
                            hintText: '+91',
                            suffixIcon: RotatedBox(
                                quarterTurns: 45,
                                child: Icon(Icons.arrow_forward_ios_outlined,
                                    size: 20)),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                            child: CustomTextField(
                              keyboardType: TextInputType.phone,
                          controller: phoneCon,
                          maxLength: 10,
                          hintText: 'Please enter the phone number',
                        )),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    children: [
                      Image.asset(Assets.iconsEmailTabColor,height: 30,),
                      const SizedBox(width: 20),
                      textWidget(
                          text: 'Email',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.secondaryTextColor)
                    ],
                  )),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                   child: CustomTextField(

                         onChanged: (value) {
                           if (emailCon.text.isNotEmpty) {}
                        },
                       controller: emailCon,
                       maxLines: 1,
                       hintText: 'please input your email',
                    ),
                 ),

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
                          text: 'Set password',
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
                    controller: setPasswordCon,
                    maxLines: 1,
                    hintText: 'Please enterSet password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideSetPassword = !hideSetPassword;
                          });
                        },
                        icon: Image.asset(hideSetPassword
                            ? Assets.iconsEyeClose
                            : Assets.iconsEyeOpen)),
                    // validator: (value) {
                    //   if (setPasswordCon.text.isEmpty) {
                    //     return 'Please enter your password';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
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
                          text: 'Confirm password',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.secondaryTextColor)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: CustomTextField(
                    // validator: (value) {
                    //   if (confirmPasswordCon.text.isEmpty) {
                    //     return 'Please enter your password';
                    //   }
                    //   return null;
                    // },
                    obscureText: hideConfirmPassword,
                    controller: confirmPasswordCon,
                    maxLines: 1,
                    hintText: 'Please EnterConfirm password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideConfirmPassword = !hideConfirmPassword;
                          });
                        },
                        icon: Image.asset(hideConfirmPassword
                            ? Assets.iconsEyeClose
                            : Assets.iconsEyeOpen)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            readAndAgreePolicy = !readAndAgreePolicy;
                          });
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          alignment: Alignment.center,
                          decoration: readAndAgreePolicy
                              ? BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(Assets.iconsCorrect)),
                                  border: Border.all(
                                      color: AppColors.secondaryTextColor),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(50),
                                )
                              : BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.secondaryTextColor),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(50),
                                ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomRichText(
                        textSpans: [
                          CustomTextSpan(
                            text: "I have read and agree",
                            textColor: Colors.black,
                            fontSize: 13,
                            spanTap: () {
                              setState(() {
                                readAndAgreePolicy = !readAndAgreePolicy;
                              });
                            },
                          ),
                          CustomTextSpan(
                            text: "【Privacy Agreement】",
                            textColor: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            spanTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: AppBtn(
                      title: 'Register',
                      fontSize: 20,
                      loading: authProvider.regLoading,
                      onTap: () {

                        if(phoneCon.text.isEmpty || phoneCon.text.length!=10){
                          Utils.flushBarSuccessMessage("Enter phone number", context, Colors.red);
                        }else if(setPasswordCon.text.isEmpty){
                          Utils.flushBarSuccessMessage("Set your password", context, Colors.red);
                        } else if(confirmPasswordCon.text.isEmpty){
                          Utils.flushBarSuccessMessage("Confirm your password", context, Colors.red);
                        } else if(emailCon.text.isEmpty){
                          Utils.flushBarSuccessMessage("Confirm your email", context, Colors.red);
                        }
                        else {
                          authProvider.userRegister(
                            context,
                            phoneCon.text,
                            setPasswordCon.text,
                            confirmPasswordCon.text,
                            refercodee.text,
                            emailCon.text
                          );
                        }},
                      hideBorder: true,
                      gradient: AppColors.primaryGradient
                      // gradient: activeButton
                      //     ? AppColors.primaryGradient
                      //     : AppColors.inactiveGradient,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: AppBtn(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.loginScreen);
                    },
                    gradient: AppColors.secondaryGradient,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget(
                            text: 'I have an account',
                            fontSize: 16,
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w600),
                        const SizedBox(width: 15),
                        textWidget(
                            text: 'Login',
                            fontSize: 22,
                            color: AppColors.gradientFirstColor,
                            fontWeight: FontWeight.w600)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
