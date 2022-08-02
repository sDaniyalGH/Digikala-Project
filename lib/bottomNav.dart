import 'package:flutter/material.dart';

class bottomNav extends StatelessWidget {
  const bottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.red,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
             // color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.home) ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.person)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
              //color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined) ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
