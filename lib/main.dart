import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MaterialApp(
title: "Calculator",
debugShowCheckedModeBanner: false,
theme: ThemeData(primarySwatch: Colors.green),
home:Cal(),
), );

class Cal extends StatefulWidget {
  @override
  _CalState createState() => _CalState();
}

class _CalState extends State<Cal> {
  String equation ="0";
  String result="0";
  String expression ="";
  double equationFontSize =43;
  double resultFontSize =52;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation ="0";
        result="0";
        equationFontSize =43;
        resultFontSize =52;
      }
      else if(buttonText == "⌫"){
        equationFontSize =52;
        resultFontSize =43;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      } else if(buttonText == "="){
        equationFontSize =43;
        resultFontSize =52;
        
        expression = equation;
        expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
        try{
          Parser p= new Parser();
          Expression exp =p.parse(expression);
          
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
      }else{
        equationFontSize =52;
        resultFontSize =43;
        if(equation=="0"){
          equation= buttonText;
      }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget button(String buttonText, double buttonWidth, Color buttonColor){
    return Container(
      width: MediaQuery.of(context).size.width* 0.1 *buttonWidth,
      color: buttonColor,
      child: FlatButton(
          padding: EdgeInsets.all(27),
          onPressed:() => buttonPressed(buttonText),
          child:Text(buttonText, style: TextStyle(fontSize: 38,color: Colors.white),)
      ) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10,20,10,10),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10,30),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                 FlatButton(
                   padding: EdgeInsets.fromLTRB(86.7, 13, 86.7,13 ),
                   onPressed: () => buttonPressed("C"),
                   color: Colors.red,
                   child: Text("C",style: TextStyle(fontSize: 34,color: Colors.white)),
                 ),
                  FlatButton(
                    padding: EdgeInsets.fromLTRB(79.1, 10.3, 79.1,10.3 ),
                    onPressed: () => buttonPressed("⌫"),
                    color: Colors.red,
                    child: Text("⌫",style: TextStyle(fontSize: 34,color: Colors.white)),
                  )
                ],
              ),

                Row(
                 children: <Widget>[
                   button("1", 2.5,Colors.blueAccent),
                   button("2", 2.5 ,Colors.blueAccent),
                   button("3", 2.5 ,Colors.blueAccent),
                   button("+", 2.5 ,Colors.blueAccent),
                 ],
                ),
                Row(
                    children: <Widget>[
                      button("4", 2.5 ,Colors.blueAccent),
                      button("5", 2.5 ,Colors.blueAccent),
                      button("6", 2.5 ,Colors.blueAccent),
                      button("−", 2.5 ,Colors.blueAccent),
                    ],
                ),
              Row(
                children: <Widget>[
                  button("7", 2.5 ,Colors.blueAccent),
                  button("8", 2.5,Colors.blueAccent),
                  button("9", 2.5 ,Colors.blueAccent),
                  button("×", 2.5 ,Colors.blueAccent),

                ],
              ),
              Row(
                children: <Widget>[
                  button("0.", 2.5 ,Colors.blueAccent),
                  button("=", 5,Colors.blueAccent),
                  button("÷", 2.5 ,Colors.blueAccent),

                ],
              ),
            ],),
      ],
    ),
    );
  }
}
