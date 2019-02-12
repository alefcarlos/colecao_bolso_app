class CollectionItem {
  int _id;
  int _collectionId;
  String _number;
  bool _isFav;
  int _quantity;
  List<String> _tags;

  CollectionItem(
      this._collectionId, this._number, this._isFav, this._quantity, this._tags)
      : assert(_quantity > 0);

  int get id => _id;
  setId(int id) => this._id = id;

  int get collectionId => this._collectionId;
  String get number => this._number;
  bool get isFav => this._isFav;
  int get quantity => this._quantity;
  List<String> get tags => this._tags;

  setFav(bool status) => this._isFav = status;
}
