import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatabase {
  static Future<List<int>?> getFavoriteIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int>? favoriteIds = prefs.getStringList('favorites')?.map(int.parse).toList();
    return favoriteIds;
  }

  static Future<void> saveFavoriteIds(List<int> favoriteIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favoriteIds.map((id) => id.toString()).toList());
  }
}
