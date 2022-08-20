import 'package:flutter/material.dart';

import '../utils/routes.dart';

class drawer extends StatelessWidget {
  const drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountEmail: Text("amilson@mail.com"),
            accountName: Text("Amilson"),
            currentAccountPicture: CircleAvatar(
              child: Text("A"),
            ),

          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text("Minha conta"),
            onTap: () {
              Navigator.pop(context);
              //Navegar para outra página
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: const Text("Assistir mais tarde"),
            onTap: () {
              Navigator.pushNamed(context,Routes.watchLater);
              //Navegar para outra página

            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: const Text("Favoritos"),
            onTap: () {
              Navigator.pushNamed(context, Routes.favorites);
              //Navegar para outra página
            },
          ),
        ],
      ),
    );
  }
}
