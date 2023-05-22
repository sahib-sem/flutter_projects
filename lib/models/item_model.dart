class ItemModel {
  int? id;
  int? listId;
  String? name;
  int? quantity;
  String? notes;

  ItemModel(this.id, this.listId, this.name, this.quantity, this.notes);

  toMap() {
    return {
      'id': (id == 0) ? null : id,
      "listId": listId,
      "name": name,
      "quantity": quantity,
      "notes": notes
    };
  }
}
