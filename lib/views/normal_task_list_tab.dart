import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laugh_coin/utils/list_shrimmer.dart';
import 'package:laugh_coin/utils/open_url.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:provider/provider.dart';

class NormalTaskListTab extends StatefulWidget {
  const NormalTaskListTab({super.key});

  @override
  State<NormalTaskListTab> createState() => _NormalTaskListTabState();
}

class _NormalTaskListTabState extends State<NormalTaskListTab> {
  ListShrimmer shrimmer = ListShrimmer();
  OpenUrl openURL = OpenUrl();

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
    HomeViewModal homeViewModal = context.watch<HomeViewModal>();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.77,
      child: homeViewModal.isBalanceLoading
          ? shrimmer.loadingShimmer(context)
          : homeViewModal.taskResponse?.taskList == null ||
                  homeViewModal.taskResponse!.taskList!.isEmpty
              ? const Center(
                  child: Text('No task available',
                      style: TextStyle(color: Colors.white)),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await context.read<HomeViewModal>().getTaskList(context);
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(size.height * 0.01),
                    itemCount: homeViewModal.taskResponse!.taskList!
                        .where((item) => item.isDailyTask == 'no')
                        .length,
                    itemBuilder: (context, index) {
                      final filteredTasks = homeViewModal
                          .taskResponse!.taskList!
                          .where((item) => item.isDailyTask == 'no')
                          .toList();
                      final item = filteredTasks[index];

                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.005),
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
                                        onPressed: () {
                                          openURL.openURL(item.taskUrl ?? '');
                                        },
                                        child: Text(
                                          item.taskUrl ?? 'N/A',
                                          style: const TextStyle(
                                              color: Colors.blue),
                                        )),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Text(
                                                      'Claim Task',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20)),
                                                  content: const Text(
                                                    'Are you sure you want to claim this task?',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child:
                                                          const Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                      onPressed: homeViewModal
                                                              .isBalanceLoading
                                                          ? null
                                                          : () {
                                                              homeViewModal
                                                                  .setUserTask(
                                                                      context,
                                                                      item.id ??
                                                                          '');
                                                            },
                                                      child: homeViewModal
                                                              .isBalanceLoading
                                                          ? const CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .amber),
                                                            )
                                                          : const Text(
                                                              'Confirm',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                ),
    );
  }
}
