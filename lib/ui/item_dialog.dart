import 'package:flutter/material.dart';
import 'package:shopping_list/models/item_model.dart';
import '../models/list_model.dart';
import '../database_helper.dart';

class ItemDialogue {
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();

  final txtNotes = TextEditingController();

  Widget buildDialog(BuildContext context, ItemModel list, bool isNew) {
    DbHelper helper = DbHelper();
    txtName.text = "";
    txtQuantity.text = "";
    txtNotes.text = "";
    if (!isNew) {
      txtName.text = (list.name == null) ? "" : list.name!;
      txtQuantity.text =
          (list.quantity == null) ? "" : list.quantity!.toString();
      txtNotes.text = (list.notes == null) ? "" : list.notes!;
    }
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        title: Text((isNew) ? 'New Item' : 'Edit Item'),
        content: SingleChildScrollView(
          child: Column(children: [
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Item Name')),
            TextField(
              controller: txtQuantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Quantity'),
            ),
            TextField(
              controller: txtNotes,
              decoration: InputDecoration(hintText: 'notes'),
            ),
            ElevatedButton(
                child: Text('Save Item'),
                onPressed: () async {
                  list.name = txtName.text;
                  list.quantity = int.parse(txtQuantity.text);
                  list.notes = txtNotes.text;
                  await helper.openDb();
                  await helper.insertItem(list);
                  Navigator.pop(context);
                })
          ]),
        ));
  }
}
