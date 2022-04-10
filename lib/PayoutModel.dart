class PayoutModel {
  String? status;
  List<Data>? data;

  PayoutModel({this.status, this.data});

  PayoutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? start;
  int? end;
  int? amount;
  String? txHash;
  int? paidOn;

  Data({this.start, this.end, this.amount, this.txHash, this.paidOn});

  Data.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    amount = json['amount'];
    txHash = json['txHash'];
    paidOn = json['paidOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    data['amount'] = this.amount;
    data['txHash'] = this.txHash;
    data['paidOn'] = this.paidOn;
    return data;
  }
}
