import 'package:flutter/material.dart';
typedef CallbackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  final Color color;
  final double size;
  final VoidCallback onPressed;
  final String text;

  ProductivityButton({super.key, required this.color, required this.size, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: size,
      color: color,
      child: Text(
        text , 
        style:  TextStyle(color:Colors.white),),
      onPressed: onPressed);
  }
}

class SettingButton extends StatelessWidget {
  
  Color color;
  String text;
  int value;
  String setting;
  CallbackSetting callback;
  SettingButton(this.color , this.text, this.value , this.callback , this.setting);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed:(){ return this.callback(setting , value);} ,
      color: color,
      child: Text(text , 
      style: TextStyle(color: Colors.white),

      ),
    
      
      );
  }
}