import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app/SingleProduct.dart';
import 'package:shop_app/bottomNav.dart';
import  'package:persian_number_utility/persian_number_utility.dart';
import 'model/SpecialOfferModel.dart';


class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late Future<List<SpecialOfferModel>> futureSpecialOfferModel;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureSpecialOfferModel = requestAPISpecialOfferModel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){} , child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNav(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("فروشگاه" , style: TextStyle(fontFamily: "vazir"),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.map)),
        ],
      ),
      body: Container(

        child: FutureBuilder(
          future: futureSpecialOfferModel,
          builder: (context , snapshot){
            if (snapshot.hasData){
              List<SpecialOfferModel>? model = snapshot.data as List<SpecialOfferModel>?;

              return Directionality(
                textDirection: TextDirection.rtl,
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(model!.length, (index) => genItem(model[index]))


                ),
              );

            } else {
              return JumpingDotsProgressIndicator(
                fontSize: 60,
                dotSpacing: 5,
              );
            }
          },
        ),

      ),
    );
  }

  InkWell genItem (SpecialOfferModel specialOfferModel){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SingleProduct(specialOfferModel)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 90,
                  height: 90,
                  child: Image.network(specialOfferModel.imgurl),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(specialOfferModel.name , style: TextStyle(fontSize: 12 , fontFamily: "vazir"),),
              ),
              Text(specialOfferModel.offPrice.toString().seRagham().toPersianDigit() + " تومان " , style: TextStyle(fontSize: 12 , fontFamily: "vazir" , color: Colors.red), textDirection: TextDirection.rtl,),

            ],
          ),
        ),
      ),
    );
  }
  Future<List<SpecialOfferModel>> requestAPISpecialOfferModel () async {
    List<SpecialOfferModel> model = [];
    var response = await Dio().get("https://jsonplaceholder.typicode.com/photos");

    for (int i = 0 ; i < 100 ; i++)
      model.add(SpecialOfferModel(response.data[i]["id"], "محصول شماره ${i + 1}", "100000", 20, "80000", response.data[i]["url"]));

    return model;
  }
  
}
