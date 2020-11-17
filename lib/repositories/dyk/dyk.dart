import 'package:aussie/models/dyk/dyk.dart';
import 'package:aussie/providers/online/dyk/dyk.dart';

class DYKRepository {
  DYKOnlineProvider _onlineProvider = DYKOnlineProvider();
  Future<List<DYKModel>> fetch() async {
    var _fetched = await _onlineProvider.fetch();
    var _mapped = _fetched.map((element) => DYKModel(text: element)).toList();
    return _mapped;
  }
}
