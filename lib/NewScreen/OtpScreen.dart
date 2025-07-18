import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.number, required this.countryCode})
      : super(key: key);
  final String number;
  final String countryCode;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Verify your phone number",
          style: TextStyle(
            color: Colors.teal[800],
            fontSize: 16.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Enter the 6-digit code sent to\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  ),
                  TextSpan(
                    text: "${widget.countryCode} ${widget.number}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            TextButton(
              onPressed: () {},
              child: Text(
                "Wrong number?",
                style: TextStyle(
                  color: Colors.cyan[800],
                  fontSize: 14.5,
                ),
              ),
            ),
            SizedBox(height: 5),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 30),
            Text(
              "Didn’t receive the code?",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.5,
              ),
            ),
            SizedBox(height: 10),
            bottomButton("Resend SMS", Icons.message),
            SizedBox(height: 30),
            Divider(thickness: 1.5),
            bottomButton("Call me", Icons.call),
          ],
        ),
      ),
    );
  }

  Widget bottomButton(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.teal,
          size: 24,
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 14.5,
          ),
        ),
      ],
    );
  }
}
