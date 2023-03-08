import 'package:flutter/material.dart';
void main()=> runApp(myApp());
class myApp extends StatelessWidget {
  const myApp({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  const Calculator({ Key? key }) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator> {
  Widget calcButton(String btntxt, Color btncolor, Color txtcolor){
    return Container(
      child: MaterialButton(
        onPressed:() {
          calculation(btntxt);
        },
        child: Text(btntxt,style: TextStyle(fontSize: 25,color: txtcolor),),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(30),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 33, 33),
      appBar: AppBar(title: Text("ReCalculator"), backgroundColor: Colors.black,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text(text,textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white,fontSize:55),),
                ), 
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("AC", Color.fromARGB(255, 216, 139, 16), Colors.black),
                calcButton("+/-", Color.fromARGB(255, 216, 139, 16), Colors.black),
                calcButton("%", Color.fromARGB(255, 216, 139, 16), Colors.black),
                calcButton("/", Color.fromARGB(255, 216, 139, 16), Colors.black),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("7", Colors.grey, Colors.black),
                calcButton("8", Colors.grey, Colors.black),
                calcButton("9", Colors.grey, Colors.black),
                calcButton("x", Color.fromARGB(255, 216, 139, 16), Colors.black),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("4", Colors.grey, Colors.black),
                calcButton("5", Colors.grey, Colors.black),
                calcButton("6", Colors.grey, Colors.black),
                calcButton("-", Color.fromARGB(255, 216, 139, 16), Colors.black),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton("1", Colors.grey, Colors.black),
                calcButton("2", Colors.grey, Colors.black),
                calcButton("3", Colors.grey, Colors.black),
                calcButton("+", Color.fromARGB(255, 216, 139, 16), Colors.black),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {
                    
                  },
                  shape: StadiumBorder(),
                  child: Text("0",style: TextStyle(fontSize: 25,color: Colors.black),textAlign: TextAlign.center,),
                  color: Colors.grey,
                ),
                calcButton(".", Colors.grey,Colors.black),
                calcButton("=", Color.fromARGB(255, 216, 139, 16),Colors.black),
              ],
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
  // backend starts here
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
   void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    
    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
         finalResult = add();
      } else if( preOpr == '-') {
          finalResult = sub();
      } else if( preOpr == 'x') {
          finalResult = mul();
      } else if( preOpr == '/') {
          finalResult = div();
      } 

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
          numOne = double.parse(result);
      } else {
          numTwo = double.parse(result);
      }

      if(opr == '+') {
          finalResult = add();
      } else if( opr == '-') {
          finalResult = sub();
      } else if( opr == 'x') {
          finalResult = mul();
      } else if( opr == '/') {
          finalResult = div();
      } 
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
     result = numOne / 100;
     finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    
    else if(btnText == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();        
        finalResult = result;        
    
    } 
    
    else {
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
    
    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result; 
  }
}





