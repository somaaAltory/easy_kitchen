import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.account_circle,
        ),
        title: Text('EasyKitchen'),
        backgroundColor: Color.fromRGBO(10, 38, 71, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: TextField(
          decoration: const InputDecoration(
            hintText: "Search for anything",
            prefixIcon: Icon(
              Icons.search,
              // color: Colors.pinkAccent,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.green,
        // unselectedItemColor: Colors.red,
        //selectedItemColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color.fromRGBO(10, 38, 71, 1),
            icon: Icon(
              Icons.ad_units_sharp,
              // color: Colors.pinkAccent,
            ),
            label: "Pantry",
          ),
          BottomNavigationBarItem(
            // backgroundColor: Colors.white,
            icon: Icon(
              Icons.home,
              //   color: Colors.pinkAccent,
            ),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.favorite,
              //  color: Colors.pinkAccent,
            ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            // backgroundColor: Colors.pinkAccent,
            icon: Icon(
              Icons.shopping_cart_rounded,
              //  color: Colors.pinkAccent,
            ),
            label: "Shopping List",
          ),
        ],
      ),
    );
  }
}
