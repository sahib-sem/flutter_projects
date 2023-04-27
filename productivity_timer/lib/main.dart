import 'package:flutter/material.dart';
import 'package:productivity_timer/settings.dart';
import 'widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';
import './timermodel.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage() ,
        
    );
  }
}

class TimerHomePage extends StatelessWidget {
  TimerHomePage({super.key});
   final Padding defaultPadding = Padding(padding: EdgeInsets.all(5.0));
  CountDownTimer timer = CountDownTimer(); 
  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(PopupMenuItem(value:'settings' , child: Text('settings'),));
    timer.startWork();
    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          centerTitle: true,
          actions: [
            
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return menuItems.toList();
              },
              onSelected: (value) => {
                if (value == 'settings'){
                  goToSetting(context)
                }
              },
              
              ), 
            
          ],
          ),
          
        body: LayoutBuilder(
          builder: (BuildContext context , BoxConstraints constraits) {
            final double availableWidth = constraits.maxWidth;
            return Column(
              children: [
                Row(
                  children: [
                   defaultPadding,
                   Expanded(child: ProductivityButton(color: Color(0xff009688), size: 10, onPressed: () {
                    return timer.startWork();
                   }, text: 'Work')),
                   defaultPadding,
                   Expanded(child: ProductivityButton(color: Color(0xff607D8B), size: 10, onPressed: (){
                    return timer.startBreak(true);
                   }, text: 'Short Break')),
                   defaultPadding,
                   Expanded(child: ProductivityButton(color: Color(0xff455A64), size: 10, onPressed: (){
                    timer.startBreak(false);
                   }, text: 'Long Break'),),
                   defaultPadding
                
                  ],
                ),
                StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel time_data = (snapshot.data == '00:00') ? TimerModel(text: '00:00', percentage:1) : snapshot.data;
                    return Expanded(child: CircularPercentIndicator(
                      radius: availableWidth / 4, 
                      center: Text(time_data.text , style: Theme.of(context).textTheme.displayMedium,),
                      percent: time_data.percentage,
                      progressColor: Color(0xff009688),
                      lineWidth: 10,));
                  }
                ),

                Row(
                  children: [
                    defaultPadding,
                    Expanded(child: ProductivityButton(color: Color(0xff212121), size: 10, onPressed: (){
                      timer.stopTimer();
                    }, text: 'Stop')),
                    defaultPadding,
                    Expanded(child: ProductivityButton(color: Color(0xff009688), size: 10, onPressed:(){
                      timer.startTimer();
                    }, text: 'Restart'),)
                  ],
                )
              ],
            );
          }
        ),
           );
  }
  void goToSetting(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }
}