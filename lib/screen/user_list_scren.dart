import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../service/api_service.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
    late List<User> users;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      final fetchedUsers = await apiService.fetchUsers();
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  Future<void> toggleFavorite(int index) async {
    setState(() {
      users[index].isFavorite = !users[index].isFavorite;
    });
     
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteItems = [];
    users.forEach((user) {
      if (user.isFavorite) {
        favoriteItems.add(user.name);
      }
    });
    await prefs.setStringList('favoriteItems', favoriteItems);
  }

  @override
  Widget build(BuildContext context) {
    if (users == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                  trailing: IconButton(
                    icon: Icon(users[index].isFavorite ? Icons.favorite : Icons.favorite_border),
                    onPressed: () => toggleFavorite(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String>? favoriteItems = prefs.getStringList('favoriteItems');
              if (favoriteItems != null && favoriteItems.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Favorite Items'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: favoriteItems
                            .map((item) => ListTile(
                                  title: Text(item),
                                ))
                            .toList(),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ),
                      ],
                    );
                  }
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Favorite Items'),
                      content: Text('No favorite items found.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text('Show Favorite Items'),
          ),
        ],
      );
    }
  }
}
