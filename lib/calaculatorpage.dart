import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class _CalState extends State<Cal> {

  Widget button(String buttonText, double buttonWidth, Color buttonColor){
    return Container(
      width: MediaQuery.of(context).size.width* 0.1 *buttonWidth,
      child: RaisedButton(
          padding: EdgeInsets.all(20),
          color: buttonColor,
          onPressed:() => buttonPressed(buttonText),
          child:Text(buttonText, style: TextStyle(fontSize: 40,color: Colors.black),)
      ) ,
    );
  }
  String equation ="0";
  String result="0";
  String expression ="";
  double equationFontSize =36;
  double resultFontSize =51;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation ="0";
        result="0";
        equationFontSize =36;
        resultFontSize =52;
      }
      else if(buttonText == "0."){
        equation = equation + "0";
      }
      else if(buttonText == "⌫"){
        equationFontSize =52;
        resultFontSize =36;

        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      } else if(buttonText == "="){
        equationFontSize =36;
        resultFontSize =52;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('−', '-');
        try{
          Parser p= new Parser();
          Expression exp =p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
      }else{
        equationFontSize =46;
        resultFontSize =36;
        if(equation=="0"){
          equation= buttonText;}
        else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width* .5,
                    child: RaisedButton(
                      padding: EdgeInsets.all(7),
                      onPressed: () => buttonPressed("C"),
                      color: Colors.purple[900],
                      child: Text("C",style: TextStyle(fontSize: 34,color: Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width* .5,
                    child: RaisedButton(
                      padding: EdgeInsets.all(7),
                      onPressed: () => buttonPressed("⌫"),
                      color: Colors.red[900],
                      child: Text("⌫",style: TextStyle(fontSize: 29.7,color: Colors.white)),
                    ),
                  )
                ],
              ),

              Row(
                children: <Widget>[
                  button("1", 2.5 ,Colors.cyanAccent),
                  button("2", 2.5 ,Colors.cyanAccent),
                  button("3", 2.5 ,Colors.cyanAccent),
                  button("+", 2.5 ,Colors.pinkAccent),
                ],
              ),
              Row(
                children: <Widget>[
                  button("4", 2.5 ,Colors.cyanAccent),
                  button("5", 2.5 ,Colors.cyanAccent),
                  button("6", 2.5 ,Colors.cyanAccent),
                  button("−", 2.5 ,Colors.pinkAccent),
                ],
              ),
              Row(
                children: <Widget>[
                  button("7", 2.5 ,Colors.cyanAccent),
                  button("8", 2.5 ,Colors.cyanAccent),
                  button("9", 2.5 ,Colors.cyanAccent),
                  button("×", 2.5 ,Colors.pinkAccent),

                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15.5),
                    color: Colors.cyanAccent,
                    width: MediaQuery.of(context).size.width* 0.1 *2.5,
                    child: GestureDetector(
                      onTap: () =>
                        setState((){
                          equation = equation + "0";
                        }),
                      onDoubleTap: () =>
                          setState(() {
                            equation = equation + ".";
                          }),
                      child: Text(" 0 ." , style: TextStyle(fontSize: 48,color: Colors.black))
                    ),
                  ),
                  button("=", 5 ,Colors.pinkAccent),
                  button("÷", 2.5 ,Colors.pinkAccent),
                ],
              ),
            ],),
        ],
      ),
    );
  }
}
