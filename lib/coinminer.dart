import 'dart:convert';
import 'dart:ui';
import 'package:ethermine/PayoutModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ethermine/DataModel.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
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
      home: Miner(title: 'Coinminer info', apikey: apikey),
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

class PayoutData {
  final String payoutnumber;
  late final String payouteth;

  PayoutData(this.payoutnumber, this.payouteth);
}

class MinimumData {
  final String minimum;
  final String payout;

  MinimumData(this.minimum, this.payout);
}

class Coinminer extends State<Miner> {
  var apikey;
  var workers;
  String? paideth;

  Coinminer({this.apikey});

  late Future<String?> result;
  late Future<String?> payoutresult;
  late Future<PayoutData> paidethamount;
  late Future<String?> unpaid;
  late Future<String?> recentpayout;
  late Future<MinimumData?> minimumpayout;

  Future<DataModel> getinfo() async {
    String url =
        "https://api.ethermine.org/miner/0x49AcE5D179769Aa917a611CbE2737D86b61Fc5b4/dashboard";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //log(response.toString());
      log('data: ' + response.body.toString());
      return DataModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<PayoutModel> getpayout() async {
    String url =
        "https://api.ethermine.org/miner/0x49AcE5D179769Aa917a611CbE2737D86b61Fc5b4/payouts";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //log(response.toString());
      log('data: ' + response.body.toString());
      return PayoutModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<String?> getworkernumber() async {
    DataModel model;

    model = await getinfo();
    //upbitmodel = await getupbitinfo();
    return model.data?.workers?.length.toString();
  }

  Future<String?> getunpaideth() async {
    DataModel model;

    model = await getinfo();
    double bigint =
        double.parse(model.data!.currentStatistics!.unpaid.toString());
    var divide = 1000000000000000000;
    bigint = bigint / divide;
    var finalpatheth = bigint.toStringAsFixed(4);

    return finalpatheth;
  }

  Future<String?> getpayoutstring() async {
    PayoutModel model;

    model = await getpayout();
    return model.data?.length.toString();
  }

  Future<PayoutData> getpaidamount() async {
    PayoutModel model;
    PayoutData? payout;

    model = await getpayout();
    dynamic paideth = 0;
    for (dynamic i = 0; i < model.data?.length; i++) {
      paideth += model.data?[i].amount;
    }

    double bigint = double.parse(paideth.toString());
    var divide = 1000000000000000000;
    bigint = bigint / divide;
    var finalpatheth = bigint.toStringAsFixed(4);

    payout = PayoutData(model.data!.length.toString(), finalpatheth);

    return payout;
  }

  Future<String?> getrecentpayout() async {
    PayoutModel? payout;

    payout = await getpayout();

    double bigint = double.parse(payout.data![0].amount!.toString());
    var divide = 1000000000000000000;
    bigint = bigint / divide;
    var finalpatheth = bigint.toStringAsFixed(4);

    return finalpatheth;
  }

  Future<MinimumData> getminimumpayout() async {
    DataModel model;
    MinimumData minimum;

    model = await getinfo();

    double bigint = double.parse(model.data!.settings!.minPayout.toString());
    var divide = 1000000000000000000;
    bigint = bigint / divide;
    var finalpatheth = bigint.toStringAsFixed(4);

    double bigint2 = double.parse(model.data!.currentStatistics!.unpaid.toString());
    var divide2 = 1000000000000000000;
    bigint2 = bigint2 / divide2;
    var finalpatheth2 = bigint2.toStringAsFixed(4);

    minimum = MinimumData(finalpatheth, finalpatheth2);

    //log("percent = " + (double.parse(finalpatheth) / double.parse(finalpatheth2)));
    return minimum;
  }

  @override
  void initState() {
    super.initState();
    result = getworkernumber();
    payoutresult = getpayoutstring();
    paidethamount = getpaidamount();
    unpaid = getunpaideth();
    recentpayout = getrecentpayout();
    minimumpayout = getminimumpayout();
  }

  @override
  Widget build(BuildContext context) {
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
                        future: result,
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
                        future: paidethamount,
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
                        future: unpaid,
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
                            future: minimumpayout,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                //return Text(snapshot.data.getuserallbalances.data.elementAt(1).confirmed.toString());
                                //log("percent = " + double.parse(snapshot.data!.payout).toString());
                                //log("percent = " + (double.parse(snapshot.data!.payout) / double.parse(snapshot.data!.minimum)).toString());
                                var result = (double.parse(snapshot.data!.payout) / double.parse(snapshot.data!.minimum)).toStringAsFixed(4);
                                var percent = double.parse(result) * 100;
                                log("precent = " + ((double.parse(result)) * 100).toString());
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
                                            percent: double.parse(result),
                                            center: Text(percent.toString() + "%" ),
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
                        future: recentpayout,
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
