import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:laugh_coin/utils/preference.dart';
import 'package:laugh_coin/utils/toast.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:laugh_coin/views/buy_lgc_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  ShowToast toast = ShowToast();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeViewModal>().getBalanceData(context);
    });
  }

  Future<void> openURL(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      toast.showToastError('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeViewModal homeViewModal = context.watch<HomeViewModal>();
    return Scaffold(
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
        child: context.read<HomeViewModal>().isBalanceLoading
            ? Center(child: loadingShimmer())
            : RefreshIndicator(
                onRefresh: () async {
                  await context.read<HomeViewModal>().getBalanceData(context);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.height * 0.03),
                    child: Column(
                      children: [
                        Row(children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/user-icon.webp'),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome,',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 209, 204, 204),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2),
                              ),
                              Text(
                                Preference.getString('userEmail') ?? '',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 209, 204, 204),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ]),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        const Text(
                          'Current Balance',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2),
                        ),
                        Text(
                          '${double.tryParse(homeViewModal.balanceResponse?.lgcBal ?? "0")?.toStringAsFixed(4) ?? "0.00"} LGC',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 65, 172, 238),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Earning rate ${homeViewModal.balanceResponse?.perDayEarn ?? "0"} LGC/hr',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'BNB Value : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                    double.tryParse(homeViewModal
                                                    .balanceResponse?.bnbBal ??
                                                "0")
                                            ?.toStringAsFixed(4) ??
                                        '-',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BuyLgcScreen()),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber),
                                    child: const Text(
                                      'Buy LGC',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Referral Code : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  homeViewModal.balanceResponse?.myRefCode ??
                                      '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final referralCode = homeViewModal
                                            .balanceResponse?.myRefCode ??
                                        '';
                                    if (referralCode.isNotEmpty) {
                                      Clipboard.setData(
                                          ClipboardData(text: referralCode));

                                      toast.showToastSuccess(
                                          'Referral code copied to clipboard!');
                                    } else {
                                      toast.showToastError(
                                          'No referral code available to copy.');
                                    }
                                  },
                                  child: const Icon(
                                    Icons.file_copy,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white24),
                            child: Row(
                              children: [
                                const Icon(Icons.share, color: Colors.white),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                const Text(
                                  'Invite Friends',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          'Share in Social Media',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  openURL(homeViewModal
                                          .balanceResponse!.socials!.x ??
                                      '');
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/x-icon.jpg'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  openURL(homeViewModal
                                          .balanceResponse!.socials!.facebook ??
                                      '');
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/fb-icon.webp'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  openURL(homeViewModal
                                          .balanceResponse!.socials!.insta ??
                                      '');
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/images/insta-icon.webp'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  openURL(homeViewModal
                                          .balanceResponse!.socials!.youtube ??
                                      '');
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/yt-icon.webp'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  openURL(homeViewModal
                                          .balanceResponse!.socials!.whatsapp ??
                                      '');
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/wh-icon.jpg'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  openURL(homeViewModal
                                          .balanceResponse!.socials!.tIKTOK ??
                                      '');
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/images/ticktok-icon.webp'),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        homeViewModal.isTimerRunning == false
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: size.height * 0.03),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color:
                                        const Color.fromARGB(255, 59, 147, 210),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 251, 251, 252),
                                        width: 2)),
                                child: TextButton(
                                    onPressed: homeViewModal.isMiningLoading
                                        ? null
                                        : () {
                                            homeViewModal.doUserMine();
                                          },
                                    child: const Text(
                                      'Mine',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            : Column(
                                children: [
                                  Text(
                                    "Mining ends in ${homeViewModal.timeRemaining.inHours}h ${homeViewModal.timeRemaining.inMinutes.remainder(60)}m ${homeViewModal.timeRemaining.inSeconds.remainder(60)}s",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CircleAvatar(
                                      radius: size.width * 0.15,
                                      child: Image.network(
                                          'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExN25xejBhcXZkZm1td2xwOXkwODByMWh0YzJkc3QxcjhmMmc1dXNqOSZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9cw/ux6vPam8BubuCxbW20/giphy.gif')),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  loadingShimmer() {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade700,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.03),
          child: Column(children: [
            Row(children: [
              const CircleAvatar(
                radius: 20,
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.2,
                    height: size.height * 0.01,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    width: size.width * 0.4,
                    height: size.height * 0.01,
                    color: Colors.white,
                  ),
                ],
              )
            ]),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              width: size.width * 0.5,
              height: size.height * 0.05,
              color: Colors.white,
            ),
            SizedBox(
              height: size.height / 40,
            ),
            Container(
              width: size.width * 0.4,
              height: size.height * 0.05,
              color: Colors.white,
            ),
            SizedBox(
              height: size.height / 40,
            ),
            Container(
              width: size.width * 0.6,
              height: size.height * 0.02,
              color: Colors.white,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.06,
              color: Colors.white,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.06,
              color: Colors.white,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.06,
              color: Colors.white,
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 20,
                ),
                CircleAvatar(
                  radius: 20,
                ),
                CircleAvatar(
                  radius: 20,
                ),
                CircleAvatar(
                  radius: 20,
                ),
                CircleAvatar(
                  radius: 20,
                ),
                CircleAvatar(
                  radius: 20,
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            const CircleAvatar(
              radius: 50,
            )
          ]),
        ));
  }
}
