import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laugh_coin/utils/list_shrimmer.dart';
import 'package:laugh_coin/utils/preference.dart';
import 'package:laugh_coin/view_models/login_register_view_modal.dart';
import 'package:laugh_coin/views/home_screen.dart';
import 'package:provider/provider.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<LoginRegisterViewModel>().getKycInfo(context);
    });
  }

  ListShrimmer shrimmer = ListShrimmer();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginRegisterViewModel loginViewModal =
        context.watch<LoginRegisterViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 1, 17, 27),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
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
          child: loginViewModal.isLoading == true
              ? shrimmer.kycShimmer(context)
              : SingleChildScrollView(
                  child: loginViewModal.kycResponse?.emailVerifiedStates ==
                              null ||
                          loginViewModal.kycResponse?.phoneVerifiedStates ==
                              null
                      ? const Center(
                          child: Text('This service is not available yet.',
                              style: TextStyle(color: Colors.white)),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Your Email : ${Preference.getString('userEmail') ?? ''}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                loginViewModal.kycResponse!
                                                .emailVerifiedStates ==
                                            "none" ||
                                        loginViewModal.kycResponse!
                                                .emailVerifiedStates ==
                                            "false"
                                    ? GestureDetector(
                                        onTap: loginViewModal.isVerificationSent
                                            ? null
                                            : () {
                                                loginViewModal
                                                    .sendKycEmail(context);
                                              },
                                        child: loginViewModal.isVerificationSent
                                            ? const CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.02,
                                                    vertical:
                                                        size.height * 0.02),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white70),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.mark_email_read,
                                                        color: Colors.black),
                                                    SizedBox(
                                                      width: size.width * 0.05,
                                                    ),
                                                    const Text(
                                                      'Click here to email verification',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                      )
                                    : const Text(
                                        "Your Email is verified",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                  height: size.height * 0.03,
                                ),
                                loginViewModal.kycResponse!
                                                .phoneVerifiedStates ==
                                            "none" ||
                                        loginViewModal.kycResponse!
                                                .phoneVerifiedStates ==
                                            "false"
                                    ? GestureDetector(
                                        onTap:
                                            loginViewModal.isSmsVerificationSent
                                                ? null
                                                : () {
                                                    loginViewModal
                                                        .sendKycSms(context);
                                                  },
                                        child: loginViewModal
                                                .isSmsVerificationSent
                                            ? const CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.02,
                                                    vertical:
                                                        size.height * 0.02),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white70),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.mark_email_read,
                                                        color: Colors.black),
                                                    SizedBox(
                                                      width: size.width * 0.05,
                                                    ),
                                                    const Text(
                                                      'Click here to phone verification',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                      )
                                    : const Text(
                                        "Your Phone is verified",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ],
                            )
                          ],
                        )),
        ),
      ),
    );
  }
}
