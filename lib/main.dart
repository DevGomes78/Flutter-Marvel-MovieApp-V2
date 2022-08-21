import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel/controller/watch_later.dart';
import 'package:marvel/data/models/marvel_models.dart';
import 'package:marvel/utils/routes.dart';
import 'package:marvel/views/details_page.dart';
import 'package:marvel/views/favorites_page.dart';
import 'package:marvel/views/home_page.dart';
import 'package:marvel/views/marvel_listpage2.dart';
import 'package:marvel/views/mylist_page.dart';
import 'package:provider/provider.dart';
import 'controller/favourites_controller.dart';
import 'controller/marvel_controller.dart';
import 'package:device_preview/device_preview.dart';

//void main() => runApp(
// DevicePreview(
//  enabled: !kReleaseMode,
//builder: (context) => MyApp(), // Wrap your app
//),
//);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MarvelController()),
        ChangeNotifierProvider(create: (context) => Favorites()),
        ChangeNotifierProvider(create: (context) => Watchlater()),
        ChangeNotifierProvider(create: (context) => Data()),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          Routes.HOME: (context) => HomePage(),
          Routes.detailsPage: (context) => DetailsPage(),
          Routes.marvelListPage2: (context) => MarvelListPage2(),
          Routes.favorites: (context) => FavoritesPage(),
          Routes.watchLater: (context) => MylistPage(),
        },
      ),
    );
  }
}
