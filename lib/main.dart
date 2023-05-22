import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/item_model.dart';
import 'models/list_model.dart';
import './ui/item_list_screen.dart';
import './ui/list_dialog.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shoppping List',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ListDialogue? listDialogue;

  @override
  void initState() {
    listDialogue = ListDialogue();
    super.initState();
  }

  DbHelper dbHelper = DbHelper();
  List shopping_list = [];
  showData() async {
    await dbHelper.openDb();
    List ls = await dbHelper.getLists();

    setState(() {
      shopping_list = ls;
    });
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(title: Text('shopping list')),
      body: ListView.builder(
          itemCount: (shopping_list.length == 0) ? 0 : shopping_list.length,
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
              key: Key(shopping_list[index].name),
              onDismissed: (direction) {
                String strName = shopping_list[index].name;
                dbHelper.deleteList(shopping_list[index]);
                setState(() {
                  shopping_list.removeAt(index);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$strName deleted")));
              },
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ItemsScrean(shopping_list[index]);
                  }));
                },
                leading: CircleAvatar(
                    child: Text(shopping_list[index].priority.toString())),
                title: Text(shopping_list[index].name),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => listDialogue!
                            .buildDialog(context, shopping_list[index], false));
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => listDialogue!
                .buildDialog(context, ListModel(null, '', null), true),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
