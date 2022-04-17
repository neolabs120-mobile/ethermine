import 'dart:ui';
import 'package:ethermine/apiprovider.dart';
import 'package:ethermine/model/MinimumData.dart';
import 'package:ethermine/model/PayoutData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ethermine/coinminerviewmodel.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:developer';


class CoinminerMain extends StatelessWidget {
  final String apikey;

  CoinminerMain({required this.apikey}) : super();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coinminer Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ApiProvider(api: Coinapi(),
      child: Miner(title: 'Coinminer info', apikey: apikey,)),
    );
  }
}

class Miner extends StatefulWidget {
  Miner({Key? key, required this.title, required this.apikey})
      : super(key: key);
  final String title;
  final String apikey;

  @override
  Coinminer createState() => Coinminer(apikey: apikey);
}

class Coinminer extends State<Miner> {
  var apikey;
  var workers;
  String? paideth;

  Coinminer( { required String apikey});

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final coinapi = ApiProvider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: Column(children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: InkWell(
                onTap: () {
                  print("Card Clicked");
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FutureBuilder<String?>(
                        future: coinapi!.api.getworkernumber(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //return Text(snapshot.data.getuserallbalances.data.elementAt(1).confirmed.toString());
                            return Padding(
                                padding: EdgeInsets.all(15),
                                //apply padding to all four sides
                                child: Text(snapshot.data! + " Online",
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.bold)));
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
              width: double.infinity,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FutureBuilder<PayoutData>(
                        future: coinapi.api.getpaidamount(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //return Text(snapshot.data.getuserallbalances.data.elementAt(1).confirmed.toString());
                            return Padding(
                                padding: EdgeInsets.all(15),
                                //apply padding to all four sides
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          "TOTAL PAID - " +
                                              snapshot.data!.payoutnumber +
                                              " Payouts",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(snapshot.data!.payouteth + " ETH",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold))
                                    ]));
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  ))),
          SizedBox(
              width: double.infinity,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FutureBuilder<String?>(
                        future: coinapi.api.getunpaideth(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //return Text(snapshot.data.getuserallbalances.data.elementAt(1).confirmed.toString());
                            return Padding(
                                padding: EdgeInsets.all(15),
                                //apply padding to all four sides
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("UNPAID BALANCE",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(snapshot.data! + " ETH",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold))
                                    ]));
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  ))),
              SizedBox(
                  width: double.infinity,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      margin: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FutureBuilder<MinimumData?>(
                            future: coinapi.api.getminimumpayout(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                //return Text(snapshot.data.getuserallbalances.data.elementAt(1).confirmed.toString());
                                //log("percent = " + double.parse(snapshot.data!.payout).toString());
                                //log("percent = " + (double.parse(snapshot.data!.payout) / double.parse(snapshot.data!.minimum)).toString());
                                var result = ((double.parse(snapshot.data!.payout) / double.parse(snapshot.data!.minimum)) * 100).toStringAsFixed(2);
                                var percent = double.parse(result) / 100;

                                if(double.parse(result) > 100) {
                                  result = "1";
                                }
                                log("precent = " + ((double.parse(result))).toString());

                                return Padding(
                                    padding: EdgeInsets.all(15),
                                    //apply padding to all four sides
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              "Minimum Payout : " + snapshot.data!.minimum,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          LinearPercentIndicator(
                                            width: MediaQuery.of(context).size.width - 50,
                                            lineHeight: 14.0,
                                            percent: percent,
                                            center: Text(result + "%" ),
                                            backgroundColor: Colors.grey,
                                            progressColor: Colors.blue,
                                          ),
                                        ]));
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              // By default, show a loading spinner.
                              return CircularProgressIndicator();
                            },
                          ),
                        ],
                      ))),
          SizedBox(
              width: double.infinity,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FutureBuilder<String?>(
                        future: coinapi.api.getrecentpayout(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            //return Text(snapshot.data.getuserallbalances.data.elementAt(1).confirmed.toString());
                            return Padding(
                                padding: EdgeInsets.all(15),
                                //apply padding to all four sides
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("LAST PAYOUT",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(snapshot.data! + " ETH",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold))
                                    ]));
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  )))
        ])));
  }
}
