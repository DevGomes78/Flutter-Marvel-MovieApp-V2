import 'package:flutter/material.dart';

import '../utils/routes.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
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
            leading: const Icon(Icons.person,color: Colors.blueAccent,),
            title: const Text("Minha conta"),
            onTap: () {
              Navigator.pop(context);
              //Navegar para outra página
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Minha lista"),
            onTap: () {
              Navigator.pushNamed(context,Routes.myListPage);
              //Navegar para outra página
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.favorite,color: Colors.red,),
            title: const Text("Favoritos"),
            onTap: () {
              Navigator.pushNamed(context, Routes.favorites);
              //Navegar para outra página
            },
          ),
          const Divider(color: Colors.white),
        ],
      ),
    );
  }
}
