import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MySimpleCalculator(),
  ));
}

class MySimpleCalculator extends StatefulWidget {

  @override
  _MySimpleCalculatorState createState() => _MySimpleCalculatorState();
}

class _MySimpleCalculatorState extends State<MySimpleCalculator> {

  String inputs = " ";
  String result = " ";
  String expression = "";


  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        inputs = " ";
        result = " ";

      }

      else if(buttonText == "⌫"){
        inputs = inputs.substring(0, inputs.length - 1);
        if(inputs == ""){
          inputs = " ";
        }
      }

      else if(buttonText == "="){
        expression = inputs;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        if(inputs == " "){
          inputs = buttonText;
        }else {
          inputs = inputs + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child:TextButton(
      onPressed:() => buttonPressed(buttonText),
           child: Text(buttonText,
              style: TextStyle(
                 fontSize: 30.0,
                   fontWeight: FontWeight.normal,
                      color: Colors.black
                 ),
           ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      //borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.orangeAccent)
                  )
              )
          )
    )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),

      body: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: Text(inputs,
              style: TextStyle(
                  fontSize: 38.0
              ),),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result,
              style: TextStyle(
                  fontSize: 48.0
              ),),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, Colors.black54),
                          buildButton("⌫", 1, Colors.black54),
                          buildButton("÷", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("00", 1, Colors.black54),
                        ]
                    ),
                  ],
                ),
              ),


            Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.black54),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
