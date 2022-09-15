
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_outlined,
              color: Color(0xff0063F5),
              size: 35,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          const CircleAvatar(
            foregroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNQufceARlglNH6WE5hqxj_ZFJePtP777A4A9QSx7_JqSB5HE0qWpHovJNG97X7NlebbY&usqp=CAU",
              scale: 4,
            ),
            radius: 15,
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.settings_outlined,
            color: Color(0xff0063F5),
            size: 35,
          )
        ],
      ),
    );
  }
}



Widget drawer(BuildContext context) {
  return Drawer(
    backgroundColor: Color(0xff3D3C42),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xff0063F5),
          ),
          child: Text(
            'Navigation Drawer',
            style: TextStyle(fontSize: 20),
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
          title: const Text(' My Course '),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.workspace_premium),
          title: const Text(' Go Premium '),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.video_label),
          title: const Text(' Saved Videos '),
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
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
