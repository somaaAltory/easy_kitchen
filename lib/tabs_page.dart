import 'package:easy_kitchen/Screens/categoryScreen.dart';
import 'package:easy_kitchen/Screens/pantry_screen.dart';
import 'package:easy_kitchen/views/recipe_item.dart';
import 'package:easy_kitchen/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Screens/favorites_screen.dart';

class TabsPage extends StatefulWidget {
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedItem = 0;
  List titles = ['Pantry', 'Recipes', 'Favorite', 'Shopping List'];
  String defualtTitle = 'Pantry';

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PantryScreen(),
    RecipeItem(),
    FavoriteScreen(),
    // PantryScreen(),
    // IngredientsScreen(),
    // CategoryWidget()
      CategoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      defualtTitle = titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            icon: Icon(
              Icons.logout,
            )),
         title: Text(defualtTitle),
        backgroundColor: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedItem),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: Theme.of(context).bottomAppBarColor),
        child: BottomNavigationBar(

          selectedItemColor: Theme.of(context).canvasColor,
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.ad_units_sharp,
              ),
              label: "Pantry",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Menu",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_rounded,
              ),
              label: "Shopping List",
            ),
          ],
          currentIndex: _selectedItem,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
