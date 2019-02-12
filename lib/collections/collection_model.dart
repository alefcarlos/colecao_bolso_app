class Collection {
  int _id;
  String _name;
  bool _isFav;
  int _itemCount;
  String rgbColor;

  Collection(this._id, this._name, this._isFav, this._itemCount,
      {this.rgbColor = "158,158,158"});

  Collection.fromMap(dynamic data) {
    this._id = data["id"];
    this._name = data["name"];
    this._isFav = data["isFav"];
    this._itemCount = data["itemCount"];
  }

  int get id => _id;
  String get name => _name;
  bool get isFav => _isFav;
  int get itemCount => _itemCount;

  void setFav(bool fav) => _isFav = fav;
  void setId(int id) => _id = id;
  dynamic toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'isFav': this.isFav,
      'itemCount': this.itemCount
    };
  }
}
