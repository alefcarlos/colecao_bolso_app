class ItemTag {
  int _count;
  String _tag;

  ItemTag(this._tag, this._count);

  ItemTag.fromMap(dynamic data){
    this._count = data["count"];
    this._tag = data["tag"];
  }

  int get count => _count;
  String get tag => _tag;
}
