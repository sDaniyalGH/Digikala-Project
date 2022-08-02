import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shop_app/model/SpecialOfferModel.dart';

import 'ShopBascket.dart';

class SingleProduct extends StatefulWidget {

  SpecialOfferModel specialOfferModel;
  SingleProduct(this.specialOfferModel);

  @override
  State<SingleProduct> createState() => _SingleProductState(specialOfferModel);
}

class _SingleProductState extends State<SingleProduct> {
  List<String> imgs = [];
  List<String> title = [];
  List<String> price = [];

  SpecialOfferModel specialOfferModel;
  _SingleProductState(this.specialOfferModel);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("فروشگاه" , style: TextStyle(fontFamily: "vazir"),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context , MaterialPageRoute(builder: (context) => ShopBascket(imgs , title , price)));
          }, icon: Icon(Icons.shopping_cart_outlined))
        ],

      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(child: Image.network(specialOfferModel.imgurl , width: 200, height: 200,)),
            ) ,
            Text(specialOfferModel.name , style: TextStyle(fontSize: 20 , fontFamily: "vazir"),),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(specialOfferModel.offPrice.toString().seRagham().toPersianDigit() + " تومان " , style: TextStyle(fontSize: 18 , fontFamily: "vazir" , color: Colors.red), textDirection: TextDirection.rtl,),
            ),

           Expanded(
                child : Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
                      child: ElevatedButton (
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: (){
                          saveData(specialOfferModel);
                        },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("افزودن به سبد خرید" , style: TextStyle(fontSize: 20 , fontFamily: "vazir"),),
                      ),),
                    ),
                  ),
                )
           )

          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    imgs = sharedPreferences.getStringList("imgs") ?? [];
    title = sharedPreferences.getStringList("title") ?? [];
    price = sharedPreferences.getStringList("price") ?? [];


  }
  Future<void> saveData(SpecialOfferModel specialOfferModel) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    imgs.add(specialOfferModel.imgurl);
    title.add(specialOfferModel.name);
    price.add(specialOfferModel.price);

    sharedPreferences.setStringList("imgs", imgs);
    sharedPreferences.setStringList("title", title);
    sharedPreferences.setStringList("price", price);

  }
}
