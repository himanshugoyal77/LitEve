import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdminAuth extends StatelessWidget {
  AdminAuth({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 40),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter email id';
                }
                return null;
              },
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xff0063F5))),
                hintText: 'Enter Description',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (emailController.text != null) {
                  FirebaseFirestore.instance
                      .collection('admins')
                      .doc(emailController.text)
                      .set({
                    "isAdmin": true,
                  });
                }
              },
              child: Text("request Admin"),
            )
          ],
        ),
      ),
    );
  }
}
