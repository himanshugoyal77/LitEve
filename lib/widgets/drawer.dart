import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mini_pr/admin/admin_auth.dart';
import 'package:mini_pr/admin/post_feed.dart';
import 'package:mini_pr/auth/login_screen.dart';

import '../config_size.dart';
import '../controller/auth_controller.dart';
import '../controller/google_auth_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Contants.scaffoldPColor,
            ),
            child: const Text(
              'Welcome back!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: const Text(' Admin Pannel '),
            onTap: () {
              Get.to(() => AdminPost());
            },
          ),
          ListTile(
            leading: Icon(Icons.video_label),
            title: const Text(' Saved Events '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: const Text(' Edit Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Authentication.signOut(context: context);
              AuthenticationHelper().signOut();
              Get.to(() => LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
