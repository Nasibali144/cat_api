import 'package:cat_api/pages/home_page.dart';
import 'package:cat_api/pages/search_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String id = "/main_page";
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          HomePage(),
          SearchPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 30,),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 3,
        color: Colors.blue,
        child: Container(
          height: 65,
          child: Row( //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(icon: Icon(Icons.home, color: Colors.white, size: 30,), onPressed: () {
                controller.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.ease);
              },),
              IconButton(icon: Icon(Icons.search, color: Colors.white, size: 30,), onPressed: () {
                controller.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.ease);
              },),
            ],
          ),
        ),
      ),
    );
  }
}
