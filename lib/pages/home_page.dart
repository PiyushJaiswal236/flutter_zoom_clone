import 'package:flutter/material.dart';
import 'package:zoom_clone/pages/meeting_history_page.dart';
import 'package:zoom_clone/pages/meeting_page.dart';
import 'package:zoom_clone/resources/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routeName = "/homepage";

  @override
  State<StatefulWidget> createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  int _page = 0;

  onPageChange(int selectedPage) {
    setState(() {
      _page = selectedPage;
    });
  }
  List<Widget> pages = [MeetingPage(),const MeetingHistoryPage(),const Text('Schedule'),const Text('Settings')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text("Meet and Chat"),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _page,
        onTap: onPageChange,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.comment_bank), label: "Meet and Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock), label: "Meetings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Contacts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: "Settings "),

        ],
      ),
    );
  }
}

