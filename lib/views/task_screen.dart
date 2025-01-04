import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeViewModal>().getTaskList(context);
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
                  'Tasks',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.77,
                child: homeViewModal.isBalanceLoading
                    ? loadingShimmer()
                    : homeViewModal.taskResponse?.taskList == null ||
                            homeViewModal.taskResponse!.taskList!.isEmpty
                        ? const Center(
                            child: Text('No task available',
                                style: TextStyle(color: Colors.white)),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(size.height * 0.01),
                            itemCount:
                                homeViewModal.taskResponse!.taskList!.length,
                            itemBuilder: (context, index) {
                              final item =
                                  homeViewModal.taskResponse!.taskList![index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.taskDescription ?? 'N/A',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Reward Coin ${item.rewardCoin ?? 'N/A'}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  item.taskUrl ?? 'N/A',
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                )),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.amber,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                              title: const Text(
                                                                  'Claim Task',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          20)),
                                                              content:
                                                                  const Text(
                                                                'Are you sure you want to claim this task?',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      homeViewModal
                                                                              .isBalanceLoading
                                                                          ? null
                                                                          : () {
                                                                              homeViewModal.setUserTask(context, item.id ?? '');
                                                                            },
                                                                  child: homeViewModal
                                                                          .isBalanceLoading
                                                                      ? const CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(Colors.amber),
                                                                        )
                                                                      : const Text(
                                                                          'Confirm',
                                                                          style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                ),
                                                              ],
                                                            ));
                                              },
                                              child: const Text('Claim'))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              )
            ],
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

  // Future<void> openURL(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
