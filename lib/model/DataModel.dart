class DataModel {
  String? status;
  Data? data;

  DataModel({this.status, this.data});

  DataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Statistics>? statistics;
  List<Workers>? workers;
  CurrentStatistics? currentStatistics;
  Settings? settings;

  Data({this.statistics, this.workers, this.currentStatistics, this.settings});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['statistics'] != null) {
      statistics = <Statistics>[];
      json['statistics'].forEach((v) {
        statistics!.add(new Statistics.fromJson(v));
      });
    }
    if (json['workers'] != null) {
      workers = <Workers>[];
      json['workers'].forEach((v) {
        workers!.add(new Workers.fromJson(v));
      });
    }
    currentStatistics = json['currentStatistics'] != null
        ? new CurrentStatistics.fromJson(json['currentStatistics'])
        : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.map((v) => v.toJson()).toList();
    }
    if (this.workers != null) {
      data['workers'] = this.workers!.map((v) => v.toJson()).toList();
    }
    if (this.currentStatistics != null) {
      data['currentStatistics'] = this.currentStatistics!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }
}

class Statistics {
  int? time;
  int? lastSeen;
  int? reportedHashrate;
  int? currentHashrate;
  int? validShares;
  int? invalidShares;
  int? staleShares;
  int? activeWorkers;

  Statistics(
      {this.time,
        this.lastSeen,
        this.reportedHashrate,
        this.currentHashrate,
        this.validShares,
        this.invalidShares,
        this.staleShares,
        this.activeWorkers});

  Statistics.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    lastSeen = json['lastSeen'];
    reportedHashrate = json['reportedHashrate'];
    currentHashrate = json['currentHashrate'];
    validShares = json['validShares'];
    invalidShares = json['invalidShares'];
    staleShares = json['staleShares'];
    activeWorkers = json['activeWorkers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['lastSeen'] = this.lastSeen;
    data['reportedHashrate'] = this.reportedHashrate;
    data['currentHashrate'] = this.currentHashrate;
    data['validShares'] = this.validShares;
    data['invalidShares'] = this.invalidShares;
    data['staleShares'] = this.staleShares;
    data['activeWorkers'] = this.activeWorkers;
    return data;
  }
}

class Workers {
  String? worker;
  int? time;
  int? lastSeen;
  int? reportedHashrate;
  int? currentHashrate;
  int? validShares;
  int? invalidShares;
  int? staleShares;

  Workers(
      {this.worker,
        this.time,
        this.lastSeen,
        this.reportedHashrate,
        this.currentHashrate,
        this.validShares,
        this.invalidShares,
        this.staleShares});

  Workers.fromJson(Map<String, dynamic> json) {
    worker = json['worker'];
    time = json['time'];
    lastSeen = json['lastSeen'];
    reportedHashrate = json['reportedHashrate'];
    currentHashrate = json['currentHashrate'];
    validShares = json['validShares'];
    invalidShares = json['invalidShares'];
    staleShares = json['staleShares'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['worker'] = this.worker;
    data['time'] = this.time;
    data['lastSeen'] = this.lastSeen;
    data['reportedHashrate'] = this.reportedHashrate;
    data['currentHashrate'] = this.currentHashrate;
    data['validShares'] = this.validShares;
    data['invalidShares'] = this.invalidShares;
    data['staleShares'] = this.staleShares;
    return data;
  }
}

class CurrentStatistics {
  int? time;
  int? lastSeen;
  int? reportedHashrate;
  int? currentHashrate;
  int? validShares;
  int? invalidShares;
  int? staleShares;
  int? activeWorkers;
  int? unpaid;

  CurrentStatistics(
      {this.time,
        this.lastSeen,
        this.reportedHashrate,
        this.currentHashrate,
        this.validShares,
        this.invalidShares,
        this.staleShares,
        this.activeWorkers,
        this.unpaid});

  CurrentStatistics.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    lastSeen = json['lastSeen'];
    reportedHashrate = json['reportedHashrate'];
    currentHashrate = json['currentHashrate'];
    validShares = json['validShares'];
    invalidShares = json['invalidShares'];
    staleShares = json['staleShares'];
    activeWorkers = json['activeWorkers'];
    unpaid = json['unpaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['lastSeen'] = this.lastSeen;
    data['reportedHashrate'] = this.reportedHashrate;
    data['currentHashrate'] = this.currentHashrate;
    data['validShares'] = this.validShares;
    data['invalidShares'] = this.invalidShares;
    data['staleShares'] = this.staleShares;
    data['activeWorkers'] = this.activeWorkers;
    data['unpaid'] = this.unpaid;
    return data;
  }
}

class Settings {
  String? email;
  int? monitor;
  int? minPayout;
  int? suspended;

  Settings({this.email, this.monitor, this.minPayout, this.suspended});

  Settings.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    monitor = json['monitor'];
    minPayout = json['minPayout'];
    suspended = json['suspended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['monitor'] = this.monitor;
    data['minPayout'] = this.minPayout;
    data['suspended'] = this.suspended;
    return data;
  }
}
