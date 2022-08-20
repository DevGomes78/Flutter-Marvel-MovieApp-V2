import 'package:flutter/material.dart';
import 'package:marvel/components/text_style.dart';
import 'package:marvel/controller/watch_later.dart';
import 'package:provider/provider.dart';
import '../utils/routes.dart';

class WatchLaterPage extends StatefulWidget {
  const WatchLaterPage({Key? key}) : super(key: key);

  @override
  State<WatchLaterPage> createState() => _WatchLaterPageState();
}

class _WatchLaterPageState extends State<WatchLaterPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Watchlater>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.4,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    image: AssetImage('images/studiosmarvel.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
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
              'Assistir mais tarde',
              style: AppTextStyle.font22,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: provider.listLater.length,
                  itemBuilder: (context, index) {
                    var lista = provider.listLater[index];
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
          ),
        ],
      ),
    );
  }
}
