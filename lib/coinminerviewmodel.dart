import 'dart:convert';
import 'package:ethermine/model/PayoutData.dart';
import 'package:http/http.dart' as http;
import 'package:ethermine/model/DataModel.dart';
import 'package:ethermine/model/PayoutModel.dart';
import 'package:ethermine/model/MinimumData.dart';

import 'dart:developer';

class CoinViewModel {
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
    PayoutData payout;

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
}


