import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  QueryDocumentSnapshot<Object?> documnet;
  InfoPage({
    Key? key,
    required this.documnet,
  }) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  final Uri _url = Uri.parse(
      'https://docs.google.com/forms/d/e/1FAIpQLSdXeCq2FsSA-gf6iqsriIcJizRw6xMmNfws3V5OIOVgO4IYIQ/viewform');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  late AnimationController controller;
  late Animation<double> offsetAnimation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    offsetAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Hero(
          tag: widget.documnet["title"],
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 350.0,
                  floating: false,
                  pinned: false,
                  centerTitle: false,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(widget.documnet["title"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.documnet["img"]),
                              fit: BoxFit.cover)),
                    ),
                    stretchModes: const [
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                      StretchMode.zoomBackground
                    ],
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          foregroundImage:
                              NetworkImage(widget.documnet["cImg"]),
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        Text(widget.documnet["title"],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    AnimatedBuilder(
                      animation: controller,
                      child: Text(widget.documnet["desc"],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 16, 16, 16),
                              fontSize: 16.0,
                              letterSpacing: 1.1,
                              height: 2)),
                      builder: (BuildContext context, Widget? child) {
                        return Opacity(
                          opacity: offsetAnimation.value,
                          child: child,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    ElevatedButton(
                      autofocus: true,
                      onPressed: _launchUrl,
                      child: const Text("Register",
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 227, 227),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
