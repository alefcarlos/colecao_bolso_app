class CollectionEntity {
  int id;
  String name;
  bool isFav = false;
  int itemCount = 1;

  CollectionEntity(this.id, this.name,
      {this.isFav = false, this.itemCount = 1});

  CollectionEntity.create(this.name, {this.isFav = false, this.itemCount = 1});
}
