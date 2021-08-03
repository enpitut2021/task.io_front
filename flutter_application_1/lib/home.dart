//@dart = 2.9
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/today.dart';
import './today.dart';
import './calendar.dart';
import './taskadd.dart';
import './today2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 表示中の Widget を取り出すための index としての int 型の mutable な stored property
  int _selectedIndex = 0;
  String res_ = '';

  // 表示する Widget の一覧
  static List<Widget> _pageList = [
    Today(),
    // SamplePage(title: 'today'),
    TaskAdd(res_: ''),
    Calendar(),
    // SamplePage(title: 'calendar'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('today'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('add'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('schedule'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class SamplePage extends StatelessWidget {
  final String title;
  SamplePage({@required this.title});
  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.title;
    return Container(
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleTextStyle.fontSize,
                color: titleTextStyle.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
