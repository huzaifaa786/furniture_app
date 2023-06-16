import 'package:flutter/material.dart';
import 'package:furniture/static/topbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              text: 'Profile',
              ontap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
