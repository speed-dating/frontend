import 'package:flutter/material.dart';
import 'package:speed_dating_front/chat/screens/chat_screen.dart';
import 'package:speed_dating_front/home/screens/chat_content_screen.dart';
import 'package:speed_dating_front/home/screens/home_page_content_screen.dart';
import 'package:speed_dating_front/home/screens/profile_page_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePageContent(),
    ChatPageScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _selectedIndex == 0
                  ? '스개팅'
                  : _selectedIndex == 1
                      ? '채팅'
                      : '프로필',
            ),
          ),
        ),
        actions: <Widget>[
          if (_selectedIndex == 0)
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // 알림 버튼 동작
              },
            ),
          if (_selectedIndex == 1 || _selectedIndex == 2)
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // 설정 버튼 동작
              },
            ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFC62828),
        onTap: _onItemTapped,
      ),
    );
  }
}
