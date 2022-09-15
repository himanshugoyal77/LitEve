import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_pr/config_size.dart';

class AdminPost extends StatefulWidget {
  AdminPost({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  State<AdminPost> createState() => _AdminPostState();
}

class _AdminPostState extends State<AdminPost> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String urlDownload = "";

  Future uploadFile() async {
    final path = "files/${pickedFile!.name}";
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlD = await snapshot.ref.getDownloadURL();
    urlDownload += urlD;
    print("download Link $urlDownload");

    setState(() {
      uploadTask = null;
    });
  }

  String dropdownvalue = "CSI VESIT";

  // List of items in our dropdown menu
  var items = [
    "CSI VESIT",
    "AI Warriers",
    "ISA Vesit",
    "ISTE Vesit",
    "SPORTS "
  ];

  @override
  Widget build(BuildContext context) {
    Future selectFile() async {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;

      setState(() {
        pickedFile = result.files.first;
      });
    }

    return Scaffold(
      backgroundColor: Contants.scaffoldPColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Post An Event",
                style: GoogleFonts.adamina(
                  letterSpacing: 1.9,
                  color: const Color.fromARGB(208, 255, 255, 255),
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 40),
              showdropDown(),
              const SizedBox(height: 40),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter a title';
                  }
                  return null;
                },
                controller: widget.titleController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xff0063F5))),
                  hintText: 'Enter title',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter dscription';
                  }
                  return null;
                },
                controller: widget.descController,
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
              const SizedBox(height: 20),
              if (pickedFile != null)
                Container(
                  color: Colors.blue[100],
                  child: Center(
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "upload image/pdf",
                    style: TextStyle(
                      color: const Color.fromARGB(85, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: selectFile,
                    child: const Text("Select File"),
                  ),
                ],
              ),
              // ElevatedButton(
              //     onPressed: uploadFile, child: const Text("upload file")),
              const SizedBox(height: 20),
              buildProgress(),
              const SizedBox(height: 20),
              Center(
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 92, 172, 237),
                  child: const Icon(Icons.add),
                  onPressed: () {
                    uploadFile().then((value) =>
                        FirebaseFirestore.instance.collection('posts').add({
                          'title': widget.titleController.text,
                          'desc': widget.descController.text,
                          'img': urlDownload,
                          'cName': dropdownvalue,
                          'cImg': findImg(dropdownvalue)
                        }).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('data added successfully')));
                        }).then((value) => Navigator.pop(context)));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;

            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      "${(100 * progress).roundToDouble()}%",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(height: 50);
          }
        },
      );

  Widget showdropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton(
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),

          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: const TextStyle(
                    backgroundColor: Colors.white, fontSize: 18),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        ),
        //        "CSI VESIT",
        // "AI Warriers",
        // "ISA Vesit",
        // "ISTE Vesit",
        // "SPORTS "

        if (dropdownvalue == "AI Warriers")
           const CircleAvatar(
            foregroundImage: AssetImage("assets/img/aiw.jpg"),
          ),
        if (dropdownvalue == "ISA Vesit")
          const CircleAvatar(
            foregroundImage: AssetImage("assets/img/isa.jpg"),
          ),
        if (dropdownvalue == "CSI VESIT")
          const CircleAvatar(
            foregroundImage: AssetImage("assets/img/csi.jpg"),
          ),
        if (dropdownvalue == "ISTE Vesit")
          const CircleAvatar(
            foregroundImage: AssetImage("assets/img/iste.png"),
          ),
        if (dropdownvalue == "SPORTS ")
          const CircleAvatar(
            foregroundImage: AssetImage("assets/img/sport.jpg"),
          ),
      ],
    );
  }
}

String findImg (dropdownvalue) {
    if (dropdownvalue == "AI Warriers") {
      return "https://firebasestorage.googleapis.com/v0/b/miniproject-61800.appspot.com/o/constants%2Fai%20w.jpg?alt=media&token=20ec916a-b0bb-4978-8d06-6d4ce1fa3677";
    }
        if (dropdownvalue == "ISA Vesit") {
          return "https://firebasestorage.googleapis.com/v0/b/miniproject-61800.appspot.com/o/constants%2Fisa.jpg?alt=media&token=5dacb02f-8455-46fe-9bba-48a4ec506596";
        }
        if (dropdownvalue == "CSI VESIT") {
          return "https://firebasestorage.googleapis.com/v0/b/miniproject-61800.appspot.com/o/constants%2Fcsi.jpg?alt=media&token=ac79db04-7ba5-466c-a890-b2d70f1ce6a4";
        }
        if (dropdownvalue == "ISTE Vesit") {
          return "https://firebasestorage.googleapis.com/v0/b/miniproject-61800.appspot.com/o/constants%2Fiste.png?alt=media&token=a54f70eb-a052-4d4a-9ece-29145c76c2c7";
        }
        if (dropdownvalue == "SPORTS ") {
          return "https://firebasestorage.googleapis.com/v0/b/miniproject-61800.appspot.com/o/constants%2Fsport.jpg?alt=media&token=a6986d54-898b-40b7-bfe8-85197e09e076";
        }
     return "";      
         
}
