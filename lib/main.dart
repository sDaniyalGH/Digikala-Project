import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app/AllProducts.dart';
import 'package:shop_app/model/SpecialOfferModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'model/pageViewDataModel.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<pageViewDataModel>> pageViewModel;
  late Future<List<SpecialOfferModel>> listViewOfferModel;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageViewModel = requestAPIPageView();
    listViewOfferModel = requestAPISpecialOffer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Shop App"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 120,
                color: Colors.yellow,
                child: FutureBuilder<List<pageViewDataModel>>(
                  future: pageViewModel,
                  builder: (context , snapshot){
                    if (snapshot.hasData){
                      List<pageViewDataModel>? model = snapshot.data;

                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                            controller: pageController,
                              allowImplicitScrolling: true,
                              itemCount: model?.length,
                              itemBuilder: (context , position){
                                return Container(
                                  child: Image.network(model![position].imgurl , fit: BoxFit.fill,),
                                );
                          }),
                          SmoothPageIndicator(
                              controller: pageController,
                              count: model!.length,
                              effect: ExpandingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                spacing: 3,
                                dotColor: Colors.white,
                                activeDotColor: Colors.red,
                              ),
                            onDotClicked: (index) =>
                                pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.bounceOut),
                          )

                        ],
                      );
                    }
                    else {
                        return JumpingDotsProgressIndicator(
                          dotSpacing: 5,
                          fontSize: 60,

                        );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  color: Color.fromRGBO(239,69,78,1),
                  height: 330,
                  child: FutureBuilder<List<SpecialOfferModel>>(
                    future: listViewOfferModel,
                    builder: (context , snapshot){
                      if (snapshot.hasData){
                        List<SpecialOfferModel>? model = snapshot.data;

                         return ListView.builder(

                              reverse: true,
                              shrinkWrap: true,
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,

                              itemBuilder: (context , pos){

                                if (pos == 0){
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      width: 150,
                                      height: 250,
                                      child: Column (
                                        children: [
                                          Image(image: AssetImage("images/pishnahad.png")),
                                         // Expanded(
                                             Padding(
                                               padding: const EdgeInsets.only(top : 10.0),
                                               child: OutlinedButton(

                                                style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllProducts()));
                                                },
                                                child: Text("مشاهده همه" , style: TextStyle(color: Colors.white , fontFamily: "vazir" ),)
                                            ),
                                             ),
                                         // )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else {
                                  return Container(
                                    width: 200,
                                    height: 300,
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column (
                                            children: [
                                              Image.network(model![pos - 1].imgurl),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Text(model![pos - 1].name , style : TextStyle(fontFamily: "vazir") ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 1 , top: 20),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(child: Text("${model![pos - 1].discount}%" , style: TextStyle(color: Colors.white),)),
                                                    ) ,
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: Text("${model![pos - 1].price}" , style: TextStyle(color: Colors.grey[350] , decoration: TextDecoration.lineThrough) , ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(" ${model![pos - 1].offPrice} تومان ", style: TextStyle(fontSize: 20 , fontFamily: "vazir" , fontWeight: FontWeight.w700), textDirection: TextDirection.rtl,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              
                          });


                      } else {
                        return JumpingDotsProgressIndicator(
                          color: Colors.white,
                          dotSpacing: 5,
                          fontSize: 60,
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<List<pageViewDataModel>> requestAPIPageView() async{
    List<pageViewDataModel> model = [];

    var response = await Dio().get("https://besenior.ir/flutter_ecom_project/pageViewAsset/pageViewPics.json");
    //print(response);

    for (var e in response.data["photo"]){
      model.add(pageViewDataModel(e["id"], e["imgUrl"]));
    }
    return model;
  }

  Future<List<SpecialOfferModel>> requestAPISpecialOffer () async {
    List<SpecialOfferModel> model = [];
    var response = await Dio().get("https://jsonplaceholder.typicode.com/photos");
    print(response);
    
    for (var e in response.data){
      model.add(SpecialOfferModel(e["id"], "محصول شماره ${e["id"]}", 100000, 20, 80000, e["url"]));
    }
    return model;
    

  }
}




