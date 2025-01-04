import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laugh_coin/view_models/home_view_modal.dart';
import 'package:laugh_coin/view_models/login_register_view_modal.dart';
import 'package:laugh_coin/views/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final homeViewModal = context.read<HomeViewModal>();
      await homeViewModal.getUserDetail(context);

      if (homeViewModal.userDetailResponse != null) {
        final user = homeViewModal.userDetailResponse!;
        _userNameController.text = user.username ?? '';
        _emailController.text = user.email ?? '';
        _firstNameController.text = user.firstName ?? '';
        _lastNameController.text = user.lastName ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeViewModal homeViewModal = context.watch<HomeViewModal>();
    final loginRegisterViewModel = Provider.of<LoginRegisterViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
              : homeViewModal.userDetailResponse == null
                  ? const Center(
                      child: Text('Service not available.',
                          style: TextStyle(color: Colors.white)),
                    )
                  : SingleChildScrollView(
                    child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          TextField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'First Name',
                              filled: true,
                              fillColor: Colors.white54,
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Last Name',
                              filled: true,
                              fillColor: Colors.white54,
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Email',
                              filled: true,
                              fillColor: Colors.white54,
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          TextField(
                            controller: _userNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'User Name',
                              filled: true,
                              fillColor: Colors.white54,
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white54,
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          ElevatedButton(
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
                            onPressed: loginRegisterViewModel.isLoading
                                ? null
                                : () {
                                    loginRegisterViewModel.editProfile(
                                        context,
                                        _firstNameController.text,
                                        _lastNameController.text,
                                        _emailController.text,
                                        _userNameController.text,
                                        _passwordController.text);
                                  },
                            child: loginRegisterViewModel.isLoading
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : const Text(
                                    'Update',
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

  loadingShimmer() {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(5, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
            child: Container(
              width: double.infinity,
              height: size.height * 0.08,
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
