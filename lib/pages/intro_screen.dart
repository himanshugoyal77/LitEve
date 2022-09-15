import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_pr/admin/post_feed.dart';
import 'package:get/get.dart';

import 'package:mini_pr/config_size.dart';
import 'package:mini_pr/controller/admin_controller.dart';
import 'package:mini_pr/main.dart';
import 'package:mini_pr/pages/info_page.dart';
import 'package:mini_pr/widgets/appbar_main.dart';

import '../controller/get_controller.dart';
import '../widgets/drawer.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late bool isAdmin = false;

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('admins');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    querySnapshot.docs.map((doc) {
      if (doc.id == "lemon") {
        final allData = doc.get("isAdmin");
        print(allData);
        setState(() {
          isAdmin = allData;
        });
      }
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    playSound: true,
                    color: Colors.blue,
                    icon: '@mipmap/ic_launcher')));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new message event was published");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  // late AnimationController controller;
  // late Animation<double> offsetAnimation;
  // @override
  // void initState() {
  //   controller =
  //       AnimationController(vsync: this, duration: Duration(seconds: 5));
  //   offsetAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller)
  //     ..addListener(() {
  //       print(offsetAnimation.value);
  //       setState(() {});
  //     });
  //   controller.forward();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Contants.scaffoldPColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              CupertinoIcons.list_bullet,
              size: 28,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 21, right: 21, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose your",
                style: GoogleFonts.adamina(
                  color: const Color.fromARGB(85, 255, 255, 255),
                  fontSize: 30,
                ),
              ),
              Text(
                "Favourite Councils",
                style: GoogleFonts.adamina(
                  letterSpacing: 1.25,
                  color: const Color.fromARGB(187, 255, 255, 255),
                  fontSize: 33,
                ),
              ),
              const SizedBox(height: 33),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: Contants.imgList
                          .map((e) => CustomCard(e: e))
                          .toList())),
              const SizedBox(height: 33),
              Text(
                "News",
                style: GoogleFonts.adamina(
                  letterSpacing: 1.25,
                  color: const Color.fromARGB(85, 255, 255, 255),
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!.docs.map((document) {
                        return ShowEvents(documnet: document);
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowEvents extends StatefulWidget {
  QueryDocumentSnapshot<Object?> documnet;
  ShowEvents({
    Key? key,
    required this.documnet,
  }) : super(key: key);

  @override
  State<ShowEvents> createState() => _ShowEventsState();
}

class _ShowEventsState extends State<ShowEvents>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => InfoPage(documnet: widget.documnet));
        print("hero" + widget.documnet["title"]);
      },
      child: Hero(
          tag: widget.documnet["title"],
          child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22, top: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          foregroundImage:
                              NetworkImage(widget.documnet["cImg"]),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.documnet["cName"],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(57, 0, 0, 0),
                              ),
                            ),
                            Text(
                              widget.documnet["title"],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(47, 158, 158, 158),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          widget.documnet["img"]))),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.documnet["desc"].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           ),
    );
  }
}

@override
class CustomCard extends StatelessWidget {
  Map<String, String> e;
  CustomCard({
    Key? key,
    required this.e,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 120,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: const Color.fromARGB(9, 255, 255, 255)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              child: CircleAvatar(
                radius: 30,
                foregroundImage: AssetImage(e["img"].toString()),
              ),
            ),
            Text(
              e["name"].toString(),
              style: const TextStyle(
                color: Color.fromARGB(187, 255, 255, 255),
              ),
            )
          ],
        ),
      ),
    );
  }
}
