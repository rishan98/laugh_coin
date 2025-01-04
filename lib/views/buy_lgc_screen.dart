import 'package:flutter/material.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:laugh_coin/views/home_screen.dart';
import 'package:provider/provider.dart';

class BuyLgcScreen extends StatefulWidget {
  const BuyLgcScreen({super.key});

  @override
  State<BuyLgcScreen> createState() => _BuyLgcScreenState();
}

class _BuyLgcScreenState extends State<BuyLgcScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeViewModal homeViewModal = context.watch<HomeViewModal>();
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buy LGC'),
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
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Current LGC Value : ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text(homeViewModal.balanceResponse!.lgcBal ?? '0.00',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Current BNB Value : ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text(homeViewModal.balanceResponse!.bnbBal ?? '0.00',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'LGC Amount',
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: homeViewModal.isBalanceLoading
                      ? null
                      : () async {
                          await homeViewModal.getBuyLgc(
                              context, _amountController.text);
                        },
                  child: homeViewModal.isBalanceLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          'Buy LGC',
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
      ),
    );
  }
}
