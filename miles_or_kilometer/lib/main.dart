import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title:'unit converter', 
    home: MyApp(),
  ) );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  double? _numberForm;
  String? _startMeasure;
  String? _convertedMeasure;
  String? _resultMessage;

  final Map<String, int> _measuresMap = {
 'meters' : 0,
 'kilometers' : 1,
 'grams' : 2,
 'kilograms' : 3,
 'feet' : 4,
 'miles' : 5,
  'pounds (lbs)' : 6,
 'ounces' : 7,
};
final dynamic _formulas = {
'0':[1,0.001,0,0,3.28084,0.000621371,0,0],
'1':[1000,1,0,0,3280.84,0.621371,0,0],
'2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
'3':[0,0,1000,1,0,0,2.20462,35.274],
'4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
'5':[1609.34, 1.60934,0,0,5280,1,0,0],
'6':[0,0,453.592,0.453592,0,0,1,16],
'7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
 };

  final TextStyle InputStyle = TextStyle(fontSize: 20 , color: Colors.blue[900]);
  final TextStyle labelStyle = TextStyle(fontSize: 24, color: Colors.grey[700]);
  final List<String> _measures = [
      'meters',
      'kilometers',
      'grams',
      'kilograms',
      'feet',
      'miles',
      'pounds (lbs)',
      'ounces',
      ];
  @override
  void initState() {
    _numberForm = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('unit converter'), 
        centerTitle: true,
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Spacer(),
            Text('Value', style:labelStyle),
            Spacer(),
            TextField(
              style:labelStyle,
              decoration: InputDecoration(
                hintText: 'please enter a number to convert'
              ),
               onChanged: (text) {
                var rv = double.tryParse(text);
                if (rv != null){
                  setState(() {
                    _numberForm = rv;
                  });
                }
               },
            ),
            Spacer(),
            Text('From', style: labelStyle, ), 
            
            DropdownButton<String>(
              value: _startMeasure,
              items: _measures.map((String text) {
                return DropdownMenuItem<String>(
                  value:text ,
                  child: Text(text, style: InputStyle,));
              }).toList(), 
              onChanged: (value) {
                setState(() {
                  _startMeasure = value;
                });
              }), 
              Spacer(),
              Text('To' , style: labelStyle,),
        
              Spacer(),
        
              DropdownButton<String>(
                value: _convertedMeasure,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child:Text(value, style: InputStyle,) );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _convertedMeasure = value;
                  });
                }),
                Spacer(flex: 2,),
                ElevatedButton(
                  onPressed: () {
                    if (_startMeasure!.isEmpty || _convertedMeasure!.isEmpty || _numberForm == 0){
                      return ;
                    }
                    convert(_numberForm, _startMeasure, _convertedMeasure);
                  }, 
                  child: Text('covert', style: InputStyle,)),
                Spacer(flex: 2,),
        
                Text((_resultMessage == null) ? '':_resultMessage.toString(), style: labelStyle,),
                Spacer(flex: 8,)
        
              
          ],
        ),
      ),
    );
  }

  void convert(double? value , String? from , String? to){
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    dynamic multiplier = _formulas[nFrom.toString()][nTo];
    double result = value! * multiplier;
   
      if (result == 0){
        _resultMessage = 'conversion is not possible';
      }
      else{
        _resultMessage = '${_numberForm.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
      }

      setState(() {
        _resultMessage = _resultMessage;
      });
   
 
  }
}
