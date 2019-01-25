class CollectionEntity {
  int id;
  String name;
  bool isFav = false;

  CollectionEntity(this.id, this.name, {this.isFav = false});
}