import 'package:flutter/material.dart';
import 'package:laugh_coin/view_models/login_register_view_modal.dart';
import 'package:laugh_coin/views/kyc_screen.dart';
import 'package:provider/provider.dart';

class SmsOtpScreen extends StatefulWidget {
  const SmsOtpScreen({super.key});

  @override
  State<SmsOtpScreen> createState() => _SmsOtpScreenState();
}

class _SmsOtpScreenState extends State<SmsOtpScreen> {
    final TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginRegisterViewModel loginViewModal =
        context.watch<LoginRegisterViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sms Verification'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 1, 17, 27),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const KycScreen()),
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 1, 17, 27),
              Color(0xFF0A3149),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.03),
          child: Column(
            children: [
              const Text(
                'We have sent a verification code to your phone number',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: size.height * 0.04),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Enter OTP',
                  filled: true,
                  fillColor: Colors.white54,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, size.height * 0.01),
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: loginViewModal.isLoading
                    ? null
                    : () {
                        loginViewModal.sendSmsOtp(
                            context, _otpController.text);
                      },
                child: loginViewModal.isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'Verify',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
