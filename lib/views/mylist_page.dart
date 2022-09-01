import 'package:flutter/material.dart';
import 'package:marvel/components/text_style.dart';
import 'package:marvel/controller/mylist_controller.dart';
import 'package:provider/provider.dart';
import '../constants/image_constants.dart';
import '../constants/string_constants.dart';
import '../utils/routes.dart';
import 'details_page.dart';

class MylistPage extends StatefulWidget {
  const MylistPage({Key? key}) : super(key: key);

  @override
  State<MylistPage> createState() => _MylistPageState();
}

class _MylistPageState extends State<MylistPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyListController>(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardMyListMovie(constraints, context),
              const SizedBox(height: 15),
              myListtText(),
              const SizedBox(height: 10),
              myListMovie(constraints, provider),
            ],
          ),
        ),
      ),
    );
  }

  Padding myListtText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        StringConstants.minhaLista,
        style: AppTextStyle.font22,
      ),
    );
  }

  Padding myListMovie(BoxConstraints constraints, MyListController provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: constraints.maxHeight / 2.2,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.myList.length,
            itemBuilder: (context, index) {
              var lista = provider.myList[index];
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight / 2.8,
                    width: constraints.maxWidth / 2 - 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    data: lista,
                                  )));
                        },
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
                          child: Image.asset(ImageConstants.imageAsset5Stars),
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
    );
  }

  Stack cardMyListMovie(BoxConstraints constraints, BuildContext context) {
    return Stack(
      children: [
        Container(
          height: constraints.maxHeight / 2.2,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            image: DecorationImage(
              image: AssetImage(ImageConstants.myListPageImageCard),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            height: constraints.maxHeight / 2.5,
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
                    StringConstants.InfoCard,
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
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white12),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.HOME);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
