import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:laugh_coin/views/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class WithdrawalHistoryScreen extends StatefulWidget {
  const WithdrawalHistoryScreen({super.key});

  @override
  State<WithdrawalHistoryScreen> createState() =>
      _WithdrawalHistoryScreenState();
}

class _WithdrawalHistoryScreenState extends State<WithdrawalHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeViewModal>().getWithdrawalHistory(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeViewModal homeViewModal = context.watch<HomeViewModal>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Withdrawal History'),
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
            child: homeViewModal.isBalanceLoading
                ? loadingShimmer()
                : homeViewModal.withdrawalHistoryResponse!.appMassage!.isEmpty
                    ? const Center(
                        child: Text('No withdrawal history available',
                            style: TextStyle(color: Colors.white)),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(size.height * 0.01),
                        itemCount: homeViewModal
                            .withdrawalHistoryResponse!.appMassage!.length,
                        itemBuilder: (context, index) {
                          final item = homeViewModal
                              .withdrawalHistoryResponse!.appMassage![index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.005),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white70,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.adress ?? 'N/A',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${item.amount ?? 'N/A'} ${item.coinType ?? 'N/A'}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Text(
                                    item.state ?? 'N/A',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(10, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
            child: Container(
              width: double.infinity,
              height: size.height * 0.1,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70),
            ),
          );
        })),
      ),
    );
  }
}
