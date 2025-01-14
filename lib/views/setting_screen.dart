import 'package:flutter/material.dart';
import 'package:laugh_coin/utils/preference.dart';
import 'package:laugh_coin/view_models/login_register_view_modal.dart';
import 'package:laugh_coin/views/edit_profile_screen.dart';
import 'package:laugh_coin/views/kyc_screen.dart';
import 'package:laugh_coin/views/login_screen.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginRegisterViewModel = Provider.of<LoginRegisterViewModel>(context);
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
                  'Setting',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                Preference.getString('userName')!,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                Preference.getString('userEmail')!,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70),
                  child: Row(
                    children: [
                      const Icon(Icons.edit, color: Colors.black),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const KycScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70),
                  child: Row(
                    children: [
                      const Icon(Icons.file_present, color: Colors.black),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      const Text(
                        'KYC',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete Account',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            content: const Text(
                              'Please note that, this action cannot be undone',
                              style: TextStyle(color: Colors.red),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                onPressed: loginRegisterViewModel.isLoading
                                    ? null
                                    : () {
                                        loginRegisterViewModel
                                            .deleteUserAccount(context);
                                      },
                                child: loginRegisterViewModel.isLoading
                                    ? const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.red),
                                      )
                                    : const Text(
                                        'Confirm',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ],
                          ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70),
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.black),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      const Text(
                        'Delete Account',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  showLogoutDialog(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70),
                  child: Row(
                    children: [
                      const Icon(Icons.logout, color: Colors.black),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      const Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Logout',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Preference.setBool('login', false);
                    Preference.setString('token', '');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ],
            ));
  }
}
