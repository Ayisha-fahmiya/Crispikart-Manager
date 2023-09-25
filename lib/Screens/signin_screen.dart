import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/otp_verification.dart';
import 'package:restaurant_app/services/api_services.dart';
import 'package:sign_button/sign_button.dart';
import 'package:restaurant_app/Widgets/easy_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  ApiServices apiServices = ApiServices();
  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "We've sent you an OTP to your mobile number!",
      textAlign: TextAlign.center,
    )));
  }

  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logos/Logo.png',
                    width: 270,
                  ),
                  const SizedBox(
                    height: 56,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        indent: 40,
                        thickness: 2,
                        color: Colors.grey[300],
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Log in or sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.grey[700]),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Divider(
                        endIndent: 40,
                        thickness: 2,
                        color: Colors.grey[300],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    controller: phoneController,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      hintText: "Phone number",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Container(
                              height: 22,
                              width: 22,
                              margin: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 16,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  MyElevatedButton(
                    buttonName: 'Continue',
                    onPressed: () async {
                      // const apiKey = 'http://127.0.0.1:8000/api/send-otp/';

                      // await apiServices.sendOTP(
                      //     phoneController.text, apiKey, context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtpVerificationScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 26),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  ),
                  const SizedBox(height: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton.mini(
                          btnColor: Colors.white,
                          buttonSize: ButtonSize.medium,
                          buttonType: ButtonType.google,
                          onPressed: () {}),
                      const SizedBox(width: 10),
                      const Text('Or'),
                      const SizedBox(width: 10),
                      SignInButton.mini(
                          btnColor: Colors.white,
                          buttonSize: ButtonSize.medium,
                          buttonType: ButtonType.facebook,
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
