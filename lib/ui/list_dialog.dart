import 'package:flutter/material.dart';
import '../models/list_model.dart';
import '../database_helper.dart';

class ListDialogue {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();

  Widget buildDialog(BuildContext context, ListModel list, bool isNew) {
    DbHelper helper = DbHelper();
    txtName.text = '';
    txtPriority.text = '';
    if (!isNew) {
      txtName.text = list.name!;
      txtPriority.text = list.priority.toString();
    }
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        title: Text((isNew) ? 'New shopping list' : 'Edit shopping list'),
        content: SingleChildScrollView(
          child: Column(children: [
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Shopping List Name')),
            TextField(
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Shopping List Priority (1-3)'),
            ),
            ElevatedButton(
                child: Text('Save Shopping List'),
                onPressed: () async {
                  list.name = txtName.text;
                  list.priority = int.parse(txtPriority.text);
                  await helper.openDb();
                  await helper.insertList(list);
                  Navigator.pop(context);
                })
          ]),
        ));
  }
}
