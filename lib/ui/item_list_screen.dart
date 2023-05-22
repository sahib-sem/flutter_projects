import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../database_helper.dart';
import '../models/item_model.dart';
import '../models/list_model.dart';
import './item_dialog.dart';

class ItemsScrean extends StatefulWidget {
  ListModel? shopping_list;
  ItemsScrean(this.shopping_list);

  @override
  State<ItemsScrean> createState() => _ItemsScreanState(shopping_list);
}

class _ItemsScreanState extends State<ItemsScrean> {
  ItemDialogue? itemDialogue;
  @override
  void initState() {
    itemDialogue = ItemDialogue();
    super.initState();
  }

  ListModel? shopping_list;
  _ItemsScreanState(this.shopping_list);
  DbHelper dbHelper = DbHelper();
  List items_list = [];
  showData() async {
    await dbHelper.openDb();
    List ls = await dbHelper.getItems(shopping_list!.id);

    setState(() {
      items_list = ls;
    });
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
        appBar: AppBar(title: Text(shopping_list!.name!)),
        body: ListView.builder(
            itemCount: (items_list.length == 0) ? 0 : items_list.length,
            itemBuilder: (BuildContext context, index) {
              return Dismissible(
                key: Key(items_list[index].name),
                onDismissed: (direction) {
                  String strName = items_list[index].name;
                  dbHelper.deleteItems(items_list[index]);
                  setState(() {
                    items_list.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("$strName deleted")));
                },
                child: ListTile(
                  title: Text(
                    items_list[index].name,
                  ),
                  subtitle: Text(
                      'Quantity: ${items_list[index].quantity} - Note:${items_list[index].notes}'),
                  onTap: () {},
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => itemDialogue!
                            .buildDialog(context, items_list[index], false),
                      );
                    },
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => itemDialogue!.buildDialog(
                  context,
                  ItemModel(null, shopping_list!.id, '', null, ''),
                  true),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 228, 43, 6),
        ));
  }
}
