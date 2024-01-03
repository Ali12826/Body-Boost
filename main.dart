import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
var wtController = TextEditingController();
var ftController = TextEditingController();
var inController = TextEditingController();

var result = "";
var bgColor =  Colors.deepPurple.shade200;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('yourbmi'),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('BMI', style: TextStyle(
                  fontSize: 34, fontWeight: FontWeight.w700
                ),),
                SizedBox(height: 21,),

                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                    label: Text('Enter Your Weight In KGs '),
                     prefixIcon: Icon(Icons.line_weight)
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 11,),

                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                      label: Text('Enter Your Height In feet '),
                      prefixIcon: Icon(Icons.height)
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 11,),

                TextField(
                  controller: inController,
                  decoration: InputDecoration(
                      label: Text('Enter Your Height In inch '),
                      prefixIcon: Icon(Icons.height)
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16,),

                ElevatedButton(onPressed: (){


                  var wt = wtController.text.toString();
                  var ft = ftController.text.toString();
                  var inch = inController.text.toString();

                  if(wt!="" && ft!="" && inch!=""){

                    //BMI CALCULATER
                    var iWt = int.parse(wt);
                    var iFt = int.parse(ft);
                    var iInch = int.parse(inch);

                    var tInch = (iFt*12) +iInch;

                    var tCm = tInch*2.54;

                    var tM = tCm/100;

                    var bmi = iWt/(tM*tM);

                    var msg ="";

                    if(bmi>25){
                      msg = "Yor Are Over Weight";
                      bgColor = Colors.orange.shade200;

                    }else if(bmi<18){
                      msg = "Yor Are under Weight";
                      bgColor = Colors.red.shade200;

                    } else{
                      msg = "Yor Are MashAllah Healthy";
                      bgColor = Colors.green.shade200;

                    }
                    setState(() {
                      result = "$msg \n Your BMI is : ${bmi.toStringAsFixed(4)}";
                    });

                  }else {
                    setState(() {
                      result = "Please Fill all of the above";
                    });

                  }
                }, child: Text('Calculate')),

                SizedBox(height: 11,),
                Text(result, style: TextStyle(fontSize: 19),)

              ],
            ),
          ),
        ),
      )

      ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}