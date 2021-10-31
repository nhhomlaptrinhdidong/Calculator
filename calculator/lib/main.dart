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

class _HomePageState extends State<HomePage>{
  late double first, second;
  late String opp;
  late String result, text = "",history='',key ='';
  bool advanced = false;
  bool advancedFunction=false;
  late String firstText,secondText;
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
    if (btnText == "AC") {
      result = "";
      text = "";
      first = 0;
      second = 0;
      history ='';
      key="";
    } else if (btnText=="="&& (key == "sin"||key == "cos"||key == "tan"||key=="√")){
      first = double.parse(text);
      result =Trigonometric().toString();
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
        key="";
      }else
      firstText=first.toString();
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
        history= history+second.toString();
        history="";
        first=0;
        second=0;
    } 
    else if (btnText == "%") {
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
      result = "";
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
      history = first.toString()+"!";
      result=c.toString();
      
    }
    else if (btnText == "C") {

        if(text!="0")
        {
          first = double.parse(text);
          result = (first/10).toInt().toString();
          
        }
        else if(text=="0"&&history!="")
        {
          if(opp!="")
          {
            opp="";
            history=secondText;
            result =firstText;
          }
          else
          {
            history="";  
            result =firstText;
          }
        }
    }
    else {
      advancedFunction=false;
      //text = "";

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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey,
              ],
            )),
          padding: EdgeInsets.all(8),
          child: MouseRegion(  
            child: OutlinedButton(        
               style: OutlinedButton.styleFrom(
                primary: Colors.black,
                backgroundColor: color,
                
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
        elevation: 30,
        foregroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.red]
            )
          ),
        ),
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
                    
                    customOutlineButton("AC"),
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
                 Row(
                  children: [
                    customIconBunton("Change",Icons.autorenew_rounded, Colors.white, Colors.orange),
                    customOutlineButton("0"),
                    customOutlineButton("."),
                    customIconBunton("C",Icons.backspace_outlined, Colors.white, Colors.red),
                    customIconBunton("=",Icons.drag_handle_outlined,Colors.orange, Colors.white),
                  ],
                ),
              ],
            )
            :Column(
              children: [
                Row(
                  children: [
                    customOutlineButton("AC"),
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
                    customIconBunton("Change",Icons.autorenew_rounded, Colors.white, Colors.orange),
                    customOutlineButton("0"),
                    customOutlineButton("."),
                    customIconBunton("C",Icons.backspace_outlined, Colors.white, Colors.red),
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

