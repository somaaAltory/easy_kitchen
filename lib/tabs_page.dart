import 'package:easy_kitchen/test_base.dart';
import 'package:easy_kitchen/views/home.dart';
import 'package:easy_kitchen/views/login_page.dart';
import 'package:easy_kitchen/views/widgets/ingredients_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  _TabsPageState createState() => _TabsPageState();

}

class _TabsPageState extends State<TabsPage> {
   int  _selectedItem=0 ;
   List titles =['Pantry','Recipes','Favorite','Shopping List'];
   String defualtTitle='Pantry';


   static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    PantryScreen(),
    HomePage(),
    PantryScreen(),
    IngredientsScreen(),
];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      defualtTitle=titles[index];
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }, icon: Icon(Icons.logout)
        ),
        title: Text(defualtTitle),
        backgroundColor: Colors.blue,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedItem)
        ,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.green,
        // unselectedItemColor: Colors.red,
        //selectedItemColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.shifting,
        items:const<BottomNavigationBarItem>  [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
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
        currentIndex:_selectedItem ,
        onTap: _onItemTapped,
      ),
    );
  }
}
