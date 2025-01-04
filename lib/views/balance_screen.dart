import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laugh_coin/utils/preference.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:laugh_coin/views/buy_lgc_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeViewModal>().getBalanceData(context);
    });
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
                          '${homeViewModal.balanceResponse?.lgcBal ?? "0"} LGC',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 65, 172, 238),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Earning rate ${homeViewModal.balanceResponse?.miningRateForHour ?? "0"} LGC/hr',
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
                                    homeViewModal.balanceResponse?.bnbBal ??
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
                                        color: Colors.white)),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                const Icon(Icons.file_copy,
                                    color: Colors.white),
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
                          height: size.height * 0.04,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/x-icon.jpg'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/fb-icon.webp'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/images/insta-icon.webp'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/yt-icon.webp'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/images/wh-icon.jpg'),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/images/ticktok-icon.webp'),
                                ),
                              )
                            ]),
                        SizedBox(
                          height: size.height * 0.1,
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
                                    onPressed: () {
                                      homeViewModal.clickStartCountDown();
                                    },
                                    child: const Text(
                                      'Mine',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: size.height * 0.03),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color:
                                        const Color.fromARGB(255, 169, 22, 14),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 251, 251, 252),
                                        width: 2)),
                                child: TextButton(
                                    onPressed: () {
                                      homeViewModal.clickStopCountDown();
                                    },
                                    child: const Text(
                                      'Stop',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
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
