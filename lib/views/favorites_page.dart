import 'package:flutter/material.dart';
import 'package:marvel/components/text_style.dart';
import 'package:provider/provider.dart';
import '../constants/image_constants.dart';
import '../controller/favourites_controller.dart';
import '../utils/routes.dart';

class FavoritesPage extends StatefulWidget {


  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Favorites>(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,constraints)=>
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height:constraints.maxHeight / 2.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    image: DecorationImage(
                      image: AssetImage('images/vingadores2.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    height: constraints.maxHeight / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Assine a conta premiun e aproveite os '
                                'melhores lançamentos marvel!',
                            style: AppTextStyle.font22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 25,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.marvelListPage2);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Favoritos',
                style: AppTextStyle.font22,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: constraints.maxHeight / 2 -10,
                width:double.infinity,
                child: ListView.builder(
                    scrollDirection:  Axis.horizontal,
                    itemCount: provider.listFavorites.length,
                    itemBuilder: (context, index) {
                      var lista = provider.listFavorites[index];
                      return Column(
                        children: [
                          Container(
                            height: constraints.maxHeight / 2.5 -10,
                            width: constraints.maxWidth /2 ,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Card(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                elevation: 5,
                                child: Image.network(
                                  lista.coverUrl.toString(),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(lista.title.toString()),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 50,
                                  child: Image.asset(ImageConstants.imageAsset),
                                ),
                              ),
                              const SizedBox(width: 10),

                              Text('8.5', style: AppTextStyle.font15),
                            ],
                          ),
                        ],
                      );

                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
