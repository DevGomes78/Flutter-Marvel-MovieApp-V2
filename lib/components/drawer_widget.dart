import 'package:flutter/material.dart';
import 'package:marvel/constants/string_constants.dart';

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
            title: const Text(StringConstants.minhaConta),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text(StringConstants.minhaLista),
            onTap: () {
              Navigator.pushNamed(context,Routes.myListPage);
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.favorite,color: Colors.red,),
            title: const Text(StringConstants.favorites),
            onTap: () {
              Navigator.pushNamed(context, Routes.favorites);
            },
          ),
          const Divider(color: Colors.white),
        ],
      ),
    );
  }
}
