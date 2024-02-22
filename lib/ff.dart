import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpController extends GetxController {
  OtpController() {
    _initializeSmsAutoFill();
  }

  _initializeSmsAutoFill() async {
    await SmsAutoFill().listenForCode;
  }

  RxString phoneNumber = ''.obs;
  RxString otp = ''.obs;

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  void setOtp(String value) {
    otp.value = value;
  }
}

class OtpScreen extends StatelessWidget {
  final OtpController otpController =
      Get.put(OtpController()); // Initialize the GetX controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
              onChanged: otpController.setPhoneNumber,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Call the function to send OTP
                await _sendOtp(otpController.phoneNumber.value);
              },
              child: Text('Send OTP'),
            ),
            SizedBox(height: 20),
            Text(
              'Enter OTP:',
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder: FixedColorBuilder(Colors.black),
                ),
                currentCode: otpController.otp.value,
                onCodeChanged: (vl) {
                  otpController.setOtp(vl!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendOtp(String phoneNumber) async {
    // Implement the function to send OTP
  }
}
