import 'package:flutter/material.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/static/settingtile.dart';
import 'package:furniture/static/topbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TopBar(
                      ontap: () {},
                      text: 'Settings',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SettingTile(
                        image: 'assets/images/editProfile.svg',
                        text: 'Edit Profile',
                        ontap: () {},
                      ),
                    ),
                    SettingTile(
                      image: 'assets/images/password.svg',
                      text: 'Change password',
                      ontap: () {},
                    ),
                    SettingTile(
                      image: 'assets/images/language.svg',
                      text: 'Language',
                      ontap: () {},
                    ),
                    SettingTile(
                      image: 'assets/images/report.svg',
                      text: 'Report Issue',
                      ontap: () {},
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  child: LargeButton(
                    title: "Log Out",
                    onPressed: () {
                      
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
