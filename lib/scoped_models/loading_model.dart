import 'package:scoped_model/scoped_model.dart';

class LoadingModel extends Model {
  bool _isLoading;

  bool get isLoading => _isLoading;
  setLoading(bool status) {
    print('[Model: setLoading] => $status');
    _isLoading = status;
    notifyListeners();
  }
}
