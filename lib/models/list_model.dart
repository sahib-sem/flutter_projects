class ListModel {
  int? id;
  String? name;
  int? priority;

  ListModel(this.id, this.name, this.priority);
  toMap() {
    return {'id': (id == 0) ? null : id, "name": name, "priority": priority};
  }
}
