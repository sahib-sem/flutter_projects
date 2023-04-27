import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return MaterialApp(
  title: 'Hello world title ',
   home: Scaffold(
    appBar: AppBar(
      title: Text('hello world app bar'),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
    ),
     body: Builder(
       builder: (context) {
         return SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(20),
             child: Center(
           
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Text(
                    'Hello World Travel',
                    style: TextStyle(
                      fontSize: 26, 
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800]
                    ),
                    ),
                 ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Discover the world',
                      style: TextStyle(
                        fontSize: 26, 
                        color: Colors.deepPurpleAccent
                       ),
                    ),
                  ), 
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.network(
                      'https://picsum.photos/250?image=9',
                    ),
                  ), 
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      child: Text('contact us'),
                      onPressed: () => contactUs(context),
                      ),
                  )
               ],
             ),
             ),
           ),
         );
       }
     ),
   ),
 );
 }

  void contactUs(BuildContext context){
    showDialog(
      context: context,
       builder: (BuildContext context)  {
        return AlertDialog(
          title:Text('contact us'),
          content: Text('hello@world.com'),
          actions: [TextButton(
            onPressed: () => Navigator.of(context).pop() , 
            child: Text('close'))],
        );
       }
       
       );
  }

 }

