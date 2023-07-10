import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget Kaltbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 20,
            color: txtcolor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          primary: btncolor,
          padding: const EdgeInsets.all(30),
        ),
      ),
    );
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff001C30),
      appBar: AppBar(title: Text("Contoh Kalkulator")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Kaltbutton(
                  'AC',
                  Color(0xffFF9B9B),
                  Colors.black,
                ),
                Kaltbutton('+/-', Colors.grey, Colors.black),
                Kaltbutton('%', Colors.grey, Colors.black),
                Kaltbutton('/', Color(0xff99ebff), Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Kaltbutton('7', Color(0xffCBFFA9), Colors.black),
                Kaltbutton('8', Color(0xffCBFFA9), Colors.black),
                Kaltbutton('9', Color(0xffCBFFA9), Colors.black),
                Kaltbutton('x', Color(0xff99ebff), Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Kaltbutton('4', Color(0xff4A55A2), Colors.black),
                Kaltbutton('5', Color(0xff4A55A2), Colors.black),
                Kaltbutton('6', Color(0xff4A55A2), Colors.black),
                Kaltbutton('-', Color(0xff99ebff), Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Kaltbutton('1', Color(0xffFFD6A5), Colors.black),
                Kaltbutton('2', Color(0xffFFD6A5), Colors.black),
                Kaltbutton('3', Color(0xffFFD6A5), Colors.black),
                Kaltbutton('+', Color(0xff99ebff), Colors.black),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3d3d3d),
                    shape: StadiumBorder(),
                    padding: const EdgeInsets.all(10.0),
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Kaltbutton('.', Color(0xff3d3d3d), Colors.white),
                Kaltbutton('=', Color(0xff99ebff), Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Logic dari Kalkulator
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
