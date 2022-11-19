import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/components/text_style_widget.dart';
import 'package:provider/provider.dart';
import '../controller/marvel_controller.dart';
import '../data/models/marvel_models.dart';
import '../views/details_page.dart';

class RecomendedList extends StatefulWidget {
  const RecomendedList({Key? key}) : super(key: key);

  @override
  State<RecomendedList> createState() => _RecomendedListState();
}

class _RecomendedListState extends State<RecomendedList> {
  List<Data> lista = [];

  MarvelController controller = MarvelController();

  @override
  void initState() {
    controller = context.read<MarvelController>();
    controller.getData(query: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3.1,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.lista.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: MediaQuery.of(context).size.height / 3.7,
                    width: MediaQuery.of(context).size.width / 2 - 9,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      data: controller.lista[index],
                                    )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: controller.lista[index].coverUrl.toString(),
                          child: Image(
                            image: CachedNetworkImageProvider(
                              controller.lista[index].coverUrl.toString(),
                              maxHeight: 260,
                              maxWidth: 200,
                            ),
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                ),
                              );
                            },
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 40,
                      width: 175,
                      child:
                          Text(
                            controller.lista[index].title.toString(),
                            style: AppTextStyle.font14,
                          ),


                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
