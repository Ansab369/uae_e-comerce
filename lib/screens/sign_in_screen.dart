// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/sign_up_%20screeen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isOTPsent = false;
  String otpverificationId = '';
  String countryCode = '';
  TextEditingController phoneNumbercONTROLLER =TextEditingController();
  TextEditingController otpcONTROLLER =TextEditingController();

    final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification Failed: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification Failed: ${e.message}'),
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // todo :
        setState(() {
          otpverificationId=verificationId;
        isOTPsent=true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }

  Future<void> signInWithPhoneNumber(String verificationId, String smsCode, BuildContext context) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(), 
      ),
    );

  } catch (e) {
    // Handle verification failure
    print('Verification Failed: $e');
    // You may show an error message to the user if needed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification Failed: $e'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SignScreenTopWidget(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //  SizedBox(height: 48),
                  
                  SizedBox(height: 20),
                  TextField(
                    enabled: !isOTPsent,
                    controller: phoneNumbercONTROLLER,
                    decoration: InputDecoration(
                      hintText: 'النص هنا',
                       hintTextDirection: 
                    TextDirection.rtl,
                      filled: true,
                      fillColor: textFieldColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: CountryCodePicker(
                        onChanged: (value){
                            setState(() {
                              countryCode =value.toString();
                            });
                        },
                        initialSelection: 'IT',
                        favorite: ['+39', 'FR'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    // textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 20),
                  isOTPsent?
                  TextField(
                    controller: otpcONTROLLER,

                    decoration: InputDecoration(
                      hintText: 'النص هنا',
                      filled: true,
                      fillColor: textFieldColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Icon(
                        Icons.verified_user_rounded,
                        color: buttonColor2,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    textAlign: TextAlign.right, // For right-to-left text input
                  ):SizedBox(),
              
                  //! BUTTONS
                  SizedBox(height: 30),

                  //!

                      GestureDetector(
                        onTap: () {
                          // todo : sent opt function 
                          // todo : verify otp function
                          // todo : after verify navigate to home
                          if (!isOTPsent) {
                          verifyPhoneNumber('$countryCode${phoneNumbercONTROLLER.text}', context);
                            
                          }else{
                            signInWithPhoneNumber(otpverificationId, otpcONTROLLER.text, context);
                          }

                          
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          decoration: BoxDecoration(
                              color: buttonColor2,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                           isOTPsent?"Verify": "LogIn",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      //
                  SizedBox(height: 12),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            decoration: BoxDecoration(
                                color: buttonColor1,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "SignUp",
                              style: TextStyle(color: Colors.white),
                             ),
                            ),
                          ),
                      ),

                  //!
              
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 20, vertical: 13),
                  //         decoration: BoxDecoration(
                  //             color: buttonColor1,
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: Center(
                  //             child: Text(
                  //           "LogIn",
                  //           style: TextStyle(color: Colors.white),
                  //         )),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 15),
                  //       child: Text('Or'),
                  //     ),
                  //     Expanded(
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 20, vertical: 13),
                  //         decoration: BoxDecoration(
                  //             color: buttonColor2,
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: Center(
                  //             child: Text(
                  //           "SignUp",
                  //           style: TextStyle(color: Colors.white),
                  //          ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  SizedBox(height: 25),
                  Text("⸮ يمكنك تسجيل الدخول"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  }

class SignScreenTopWidget extends StatelessWidget {
  const SignScreenTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: buttonColor1,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 130,
                    child: CustomPaint(
                      painter: LayerPainter(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('👋 مرحبا بك في مركز أبو علي',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right),
                          SizedBox(height: 10),
                          Text('مرحبا بك في مركز بك في مركز أبو علي',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Image.asset(
                  'assets/1.png',
                  height: MediaQuery.of(context).size.width / 4,
                  width: MediaQuery.of(context).size.width / 4,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "يمكنك تسجيل الدخول الى حسابك",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}

class LayerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final topLayerPaint = Paint()
      ..color = canvas1stcolor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, 80, 80),
        bottomRight: Radius.circular(60),
      ),
      topLayerPaint,
    );

    final bottomLayerPaint = Paint()
      ..color = canvas12ndcolor.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, 130, 130),
        bottomRight: Radius.circular(60),
      ),
      bottomLayerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
