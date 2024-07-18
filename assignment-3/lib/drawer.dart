import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tabs.dart';

class Sidemenu extends StatefulWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  State<Sidemenu> createState() => _SidemenuState();
}

class _SidemenuState extends State<Sidemenu> {
  bool isDarkMode = Get.isDarkMode;

  void toggleThemeMode() {
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.red,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Umwari Benie'),
            accountEmail: const Text('umwaribenie5@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('assets/jj.jpg')),
            ),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.blueAccent,

            ),
          ),
          ListTile(
            leading: Icon(Icons.login, color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Sign in", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Fabtabs(selectedIndex: 0)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add, color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Sign up", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Fabtabs(selectedIndex: 1)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate, color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Calculator", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Fabtabs(selectedIndex: 2)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens, color: isDarkMode ? Colors.white : Colors.black),
            title: Text("light/dark mode", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: toggleThemeMode,
          ),
        ],
      ),
    );
  }
}
