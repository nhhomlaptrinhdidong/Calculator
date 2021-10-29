// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'package:calculator/hover.dart';
import 'package:flutter/material.dart';
import 'hover.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double first, second;
  late String opp;
  late String result, text = "",history='',key ='';
  bool advanced = false;
  bool advancedFunction=false;
  double Trigonometric()
  {
    double x = 0;
    if(key=='sin')
      {
         x = sin(first);
      }
      else if(key=='cos')
      {
        x = cos(first);
      }
      else if(key=='tan')
      {
        x = tan(first);
      }else if(key=='√')
      {
        x = sqrt(first);
      }
      return x;
  }
  void btnClicked(String btnText) {
    if (btnText == "C") {
      result = "";
      text = "";
      first = 0;
      second = 0;
      history ='';
      key="";
    } else if (btnText=="="&& (key == "sin"||key == "cos"||key == "tan"||key=="√")&& opp==""){
      first = double.parse(text);
      Trigonometric();
      key="";
      history= history+"("+first.toString()+")";
    }
    else if ((btnText == "+" ||
        btnText == "-" ||
        btnText == "x" ||
        btnText == "÷" ||
        btnText == "^") ) {
        first = double.parse(text);
      if(key!="")
      {
        history= history+"("+first.toString()+")";
        first = Trigonometric();
      }else
        history = first.toString()+btnText;
      result = "";
      opp = btnText;
    } 
    else if (btnText == "=") {
      second = double.parse(text); 
      if (opp == "+") {
        result = (first + second).toString();
      } else if (opp == "-") {
        result = (first - second).toString();
      } else if (opp == "x") {
        result = (first * second).toString();
      } else if (opp == "÷") {
        result = (first / second).toString();
      } else if (opp == "^") {
        result = pow(first, second).toString();
      }    
      if(key=="")
      history= history+second.toString();
      else
      history= history+opp+second.toString();

    } else if (btnText == "%") {
      first = double.parse(text);
      result = (first / 100).toString();
    } else if (btnText == ".") {
      if (result.contains(".")) {
        return;
      } else {
        result = result + btnText;
      }
      
    } else if (btnText == "Change") {
      advanced=!advanced;
      result = "";
      text = "";
      first = 0;
      second = 0;
      history ='';
      
    }
    else if (btnText == "sin"||btnText == "cos"||btnText == "tan"||btnText=="√") {
      advancedFunction=true;
      history= key = btnText;
    }
    else if(btnText=="π")
    {
      history = history+"π";
      result ='3.141592653589793';
    }
    else if (btnText == "x!") {
      first = double.parse(text);
      late double c;
      for(int i =1;i<=first;i++)
      {
        c=first*i;
      }
      result=c.toString();
      
    }
    else {
      advancedFunction=false;
      result = double.parse(text + btnText).toString();
    }
    setState(() {
      text = result;
    });
  }

  Widget customOutlineButton(String value) {
    return Expanded(
      child: OnHover(builder: (isHovered){
        final color = isHovered?Colors.orange[300]:Colors.white;
        return Container(
          padding: EdgeInsets.all(8),
          child: MouseRegion(   
            child: OutlinedButton(        
               style: OutlinedButton.styleFrom(
                primary: Colors.black,
                backgroundColor: color,
                shadowColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () => btnClicked(value),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        );
        },
      ),
    );
  }
Widget customIconBunton(String value, IconData icon, Color color, Color colori) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        child: FloatingActionButton(
          hoverColor: Colors.amber,
          onPressed: () {          
            btnClicked(value);
          },
          child: Icon(icon,color: colori,),
          backgroundColor: color,
          ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
          children: [          
              Padding(
                padding: const EdgeInsets.only(right: 15,bottom: 8),
                child: Text(history,style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),),
              ),
            advancedFunction?Padding(
                padding: const EdgeInsets.only(right: 15,bottom: 8),
                child: Container(
                  width: 450,
                  height: 60,
                  child: Text(
                    key,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ):
             Padding(
                padding: const EdgeInsets.only(right: 15,bottom: 8),
                child: Container(
                  width: 450,
                  height: 60,
                  child: Text(
                    text,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
                
            advanced? Column(
              children: [
                Row(
                  children: [
                    customOutlineButton("C"),
                    customOutlineButton("x!"),
                    customOutlineButton("√"),    
                    customOutlineButton("π"),                  
                    customOutlineButton("÷"),
                  ],
                ),
                Row(
                  children: [
                    customOutlineButton("sin"), 
                    customOutlineButton("7"),
                    customOutlineButton("8"),
                    customOutlineButton("9"),
                    customOutlineButton("+"),
                  ],
                ),
                Row(
                  children: [
                    customOutlineButton("cos"),
                    customOutlineButton("4"),
                    customOutlineButton("5"),
                    customOutlineButton("6"),
                    customOutlineButton("-"),

                  ],
                ),
                Row(
                  children: [
                    customOutlineButton("tan"),
                    customOutlineButton("1"),
                    customOutlineButton("2"),
                    customOutlineButton("3"),
                    customOutlineButton("x"),
                  ],
                ),
                // Row(
                //   children: [
                //     customOutlineButton("11"),
                //     customOutlineButton("12"),
                //     customOutlineButton("13"),
                //     customOutlineButton("+"),
                //     customOutlineButton("13"),
                //     customOutlineButton("÷"),
                //   ],
                // ),
                 Row(
                  children: [
                    customIconBunton("Change",Icons.change_circle, Colors.white, Colors.orange),
                    customOutlineButton("0"),
                    customOutlineButton("."),
                    customIconBunton("=",Icons.drag_handle_outlined,Colors.orange, Colors.white),
                  ],
                ),
              ],
            )
            :Column(
              children: [
                Row(
                  children: [
                    customOutlineButton("C"),
                    customOutlineButton("%"),
                    customOutlineButton("^"),                  
                    customOutlineButton("÷"),
                  ],
                ),
                Row(
                  children: [
                    customOutlineButton("7"),
                    customOutlineButton("8"),
                    customOutlineButton("9"),
                    customOutlineButton("+"),
                  ],
                ),
                Row(
                  children: [
                    customOutlineButton("4"),
                    customOutlineButton("5"),
                    customOutlineButton("6"),
                    customOutlineButton("-"),
                  ],
                ),
                Row(
                  children: [
                    customOutlineButton("1"),
                    customOutlineButton("2"),
                    customOutlineButton("3"),
                    customOutlineButton("x"),
                  ],
                ),
                Row(
                  children: [
                    customIconBunton("Change",Icons.change_circle, Colors.white, Colors.orange),
                    customOutlineButton("0"),
                    customOutlineButton("."),
                    customIconBunton("=",Icons.drag_handle_outlined,Colors.orange, Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
