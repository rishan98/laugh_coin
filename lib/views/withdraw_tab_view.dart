import 'package:flutter/material.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:laugh_coin/views/withdrawal_history_screen.dart';
import 'package:provider/provider.dart';

class WithdrawTabView extends StatefulWidget {
  const WithdrawTabView({super.key});

  @override
  State<WithdrawTabView> createState() => _WithdrawTabViewState();
}

class _WithdrawTabViewState extends State<WithdrawTabView> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeViewModel = Provider.of<HomeViewModal>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01, vertical: size.height * 0.01),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Withdraw Amount',
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
                labelText: 'BSC Chain Address',
                filled: true,
                fillColor: Colors.white54,
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, size.height * 0.01),
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: homeViewModel.isBalanceLoading
                  ? null
                  : () async {
                      bool success = await homeViewModel.setWithdrawalAmount(
                          context,
                          _amountController.text,
                          _addressController.text);
        
                      if (success) {
                        // Clear the fields if withdrawal is successful
                        _amountController.clear();
                        _addressController.clear();
                      }
                    },
              child: homeViewModel.isBalanceLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text(
                      'Withdraw',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
            ),
            SizedBox(height: size.height * 0.25),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WithdrawalHistoryScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 59, 147, 210),
                  ),
                  child: const Center(
                    child: Text(
                      'Withdrawal History',
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
