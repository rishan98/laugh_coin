import 'package:flutter/material.dart';
import 'package:laugh_coin/views/deposit_tab_view.dart';
import 'package:laugh_coin/views/withdraw_tab_view.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 47, 82, 100),
                  ),
                  width: double.infinity,
                  child: const Text(
                    'Wallet',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ),
                const TabBar(
                  indicatorColor: Colors.amberAccent,
                  labelColor: Colors.amberAccent,
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(text: "Withdraw"),
                    Tab(text: "Deposit"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      WithdrawTabView(),
                      DepositTabView()
                    ],
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
