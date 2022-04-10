import 'package:ethermine/coinminer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Coinminer Info'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final myController = TextEditingController();
  late SharedPreferences _prefs;
  String counterKey = "apikey";

  initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    String apikey = _prefs.getString("apikey") ?? "0";

    if(apikey == "0") {

    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => new CoinminerMain(apikey : apikey)),
      );
    }
  }

  setCounterToSharedPrefs(String counter) async {
    _prefs = await SharedPreferences.getInstance();
    // 카운터를 저장한다. string 을 저장할경우 setString 등을 사용할 수 있습니다.
    await _prefs.setString(counterKey, counter);
  }

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CoinminerMain(apikey : "")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '이더마인 지갑 주소를 입력해주세요.',
            ),
            TextField(controller: myController,),
            RaisedButton(onPressed: () {
              setState(() {
                setCounterToSharedPrefs(myController.text); // _counter 를 저장합니다
              });
              //다음 화면으로 넘어간다.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoinminerMain(apikey : myController.text)),
              );
            }, child: Text('코인 현황 조회')),
          ],
        ),
      ),
    );
  }
}
