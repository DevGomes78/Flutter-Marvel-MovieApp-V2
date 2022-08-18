import 'package:flutter/material.dart';
import 'package:marvel/components/text_style.dart';
import 'package:provider/provider.dart';
import '../controller/favourites_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Favorites>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Assistir mais tarde'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueAccent,
              ),
              child: Image.asset('images/thor.png'),
            ),
            const SizedBox(height: 10),
            Text(
              'Assistir mais tarde',
              style: AppTextStyle.font25Bold,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: provider.listFavorites.length,
                  itemBuilder: (context, index) {
                    var lista = provider.listFavorites[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        elevation: 5,
                        child: Image.network(
                          lista.coverUrl.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
