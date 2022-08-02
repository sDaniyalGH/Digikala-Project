import 'package:flutter/material.dart';

class ShopBascket extends StatefulWidget {
  List<String> imgs , title , price;
  ShopBascket(this.imgs, this.title, this.price);

  @override
  State<ShopBascket> createState() => _ShopBascketState(imgs , title , price);
}

class _ShopBascketState extends State<ShopBascket> {
  List<String> imgs , title , price;

  _ShopBascketState(this.imgs, this.title, this.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("سبد خرید" , style: TextStyle(fontFamily: "vazir"),),
        centerTitle: true,
      ),
      body: GridView.count(

          crossAxisCount: 1 ,
          children: List.generate(imgs!.length, (index) => genItem(index))

      ),
    );
  }

  Card genItem(int index){
    return Card(

      child: Row(

        children: [

          Container(
              width: 50,
              height: 50,
              child: Image.network(imgs[index])),
          Text(title[index]),
          Text(price[index]),
        ],
      ),
    );
  }
}
