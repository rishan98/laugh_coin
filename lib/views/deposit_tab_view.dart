import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:laugh_coin/utils/list_shrimmer.dart';
import 'package:laugh_coin/utils/toast.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:laugh_coin/views/deposit_history_screen.dart';
import 'package:provider/provider.dart';

class DepositTabView extends StatefulWidget {
  const DepositTabView({super.key});

  @override
  State<DepositTabView> createState() => _DepositTabViewState();
}

class _DepositTabViewState extends State<DepositTabView> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  ListShrimmer shrimmer = ListShrimmer();
  ShowToast toast = ShowToast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeViewModal>().getDepositDetails(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeViewModel = Provider.of<HomeViewModal>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01, vertical: size.height * 0.01),
      child: SingleChildScrollView(
        child: homeViewModel.isBalanceLoading
            ? shrimmer.walletShimmer(context)
            : homeViewModel.depositViewResponse == null
                ? Center(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.4),
                    child: const Text('This feature is not available.',
                        style: TextStyle(color: Colors.white)),
                  ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Deposit BNB',
                          filled: true,
                          fillColor: Colors.white54,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Tnx Hash',
                          filled: true,
                          fillColor: Colors.white54,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
                          width: double.infinity,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white38,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Liquidity Address :',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  Expanded(
                                    child: Text(
                                        '${homeViewModel.depositViewResponse!.adress}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    final referralCode = homeViewModel
                                            .depositViewResponse!.adress ??
                                        '';
                                    if (referralCode.isNotEmpty) {
                                      Clipboard.setData(
                                          ClipboardData(text: referralCode));

                                      toast.showToastSuccess(
                                          'Liquidity address copied to clipboard!');
                                    } else {
                                      toast.showToastError(
                                          'No liquidity address available to copy.');
                                    }
                                  },
                                  icon: const Icon(Icons.copy),
                                  color: Colors.white,
                                ),
                              
                            ],
                          )),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        'Note : ${homeViewModel.depositViewResponse!.text}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      homeViewModel.depositViewResponse!.comingSoon == "false"
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize:
                                    Size(double.infinity, size.height * 0.01),
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: homeViewModel.isBalanceLoading
                                  ? null
                                  : () async {
                                      bool success =
                                          await homeViewModel.setDepositAmount(
                                              context,
                                              _amountController.text,
                                              _addressController.text);

                                      if (success) {
                                        // Clear the fields if deposit is successful
                                        _amountController.clear();
                                        _addressController.clear();
                                      }
                                    },
                              child: homeViewModel.isBalanceLoading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : const Text(
                                      'Deposit',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                            )
                          : const Center(
                              child: Text(
                              'You can not deposit now.',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            )),
                      SizedBox(height: size.height * 0.05),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DepositHistoryScreen()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 59, 147, 210),
                            ),
                            child: const Center(
                              child: Text(
                                'Deposit History',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                    ],
                  ),
      ),
    );
  }
}
