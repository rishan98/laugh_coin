import 'package:flutter/material.dart';
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
                labelText: 'Address',
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
                      bool success = await homeViewModel.setDepositAmount(context,
                          _amountController.text, _addressController.text);
        
                      if (success) {
                        // Clear the fields if deposit is successful
                        _amountController.clear();
                        _addressController.clear();
                      }
                    },
              child: homeViewModel.isBalanceLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text(
                      'Deposit',
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
                    MaterialPageRoute(builder: (context) => const DepositHistoryScreen()),
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
