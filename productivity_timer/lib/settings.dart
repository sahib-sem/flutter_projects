import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'),
        centerTitle: true,
      ),
      body: Settings(),
      
      
       );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;
  SharedPreferences? pref;
  static const String WORKTIME = 'worktime';
  static const String SHORTBREAK = 'shortbreak';
  static const String LONGBREAK = 'longbreak';

  int? workTime;
  int? shortBreak;
  int? longBreak;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    
    readSettings();
    super.initState();
  }

  

  TextStyle textStyle = TextStyle(fontSize: 24);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical, // sets the scroll direction to be vertical 
        crossAxisCount: 3, // no of items that will appear on each row
        mainAxisSpacing: 10, 
        crossAxisSpacing: 10,
        childAspectRatio: 3, 
        padding: EdgeInsets.all(20),// item width / item height 
        children: [

          Text('Work' , style: textStyle,),
          Text(''),
          Text(''),

          SettingButton(Color(0xff455A64),'-', -1,updateSetting, WORKTIME),
          TextField(
            controller: txtWork,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ), 
          SettingButton(Color(0xff009688), '+', 1, updateSetting , WORKTIME),
          
          Text('Short' , style: textStyle,),
          Text(''),
          Text(''),

          SettingButton(Color(0xff455A64), '-', -1,updateSetting , SHORTBREAK ),
          TextField(
            controller: txtShort,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ), 
          SettingButton(Color(0xff009688), '+', 1, updateSetting , SHORTBREAK),

          Text('Long' , style: textStyle,),
          Text(''),
          Text(''),

          SettingButton(Color(0xff455A64), '-', -1, updateSetting, LONGBREAK),
          TextField(
            controller: txtLong,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ), 
          SettingButton(Color(0xff009688), '+', 1,updateSetting, LONGBREAK),
          
        ],
        

        ),
    );
  }

  void readSettings() async{

    pref = await SharedPreferences.getInstance();
   
    workTime = pref!.getInt(WORKTIME);
    if (workTime == null){
      await pref!.setInt(WORKTIME, int.parse('30'));
      workTime = 30;
    }
    shortBreak = pref!.getInt(SHORTBREAK);
    if (shortBreak == null){
      await pref!.setInt(SHORTBREAK, int.parse('5'));
      shortBreak = 5;
    }
    longBreak =  pref!.getInt(LONGBREAK);
    if (longBreak == null){
      await pref!.setInt(LONGBREAK, int.parse('10'));
      longBreak = 10;
    }

    setState(() {
      
      
      txtWork!.text = workTime.toString();
      txtShort!.text = shortBreak.toString();
      txtLong!.text = longBreak.toString();
      
          });

  }
  void setDefaultValues(){

  }

  void updateSetting(String key , int value) async {

    switch (key) {
      case WORKTIME:{
        pref = await SharedPreferences.getInstance();
        int workTime = pref!.getInt(WORKTIME)!;
        workTime += value;
        
        if (workTime >= 1 && workTime <= 180){
          await pref!.setInt(WORKTIME, workTime);
          setState(() {
            txtWork!.text = workTime.toString();
          });

        } 

      }
      break;
      case SHORTBREAK:{
        pref = await SharedPreferences.getInstance();
        int shortBreak = pref!.getInt(SHORTBREAK)!;
        shortBreak += value;
        if (shortBreak >= 1 && shortBreak <= 120){
          await pref!.setInt(SHORTBREAK, shortBreak);
          setState(() {
            txtShort!.text = shortBreak.toString();
          });

        } 

      }
        
        break;

      case LONGBREAK:{
        pref = await SharedPreferences.getInstance();
        int longBreak = pref!.getInt(LONGBREAK)!;
        longBreak += value;
        if (longBreak >= 1 && longBreak <= 180){
          await pref!.setInt(LONGBREAK, longBreak);
          setState(() {
            txtLong!.text = longBreak.toString();
          });

        } 

      }
      break;
      default:
    }
  }
}