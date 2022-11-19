import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel/components/text_style_widget.dart';
import 'package:provider/provider.dart';

import '../controller/marvel_controller.dart';
import '../data/models/marvel_models.dart';
import '../views/details_page.dart';

class Top10List extends StatefulWidget {
  const Top10List({Key? key}) : super(key: key);

  @override
  State<Top10List> createState() => _Top10ListState();
}

class _Top10ListState extends State<Top10List> {
  List<Data> lista = [];

  MarvelController controller=MarvelController();

  @override
  void initState() {
    controller = context.read<MarvelController>();
    controller.getData(query: '');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.lista.length,
            itemBuilder: (context, index) {
              var list = controller.lista.sublist(9)[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: MediaQuery.of(context).size.height / 3.8,
                    width: MediaQuery.of(context).size.width / 2 - 9,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  data: list,
                                )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: CachedNetworkImageProvider(
                            list.coverUrl.toString(),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 40,
                      width: 175,
                      child: Text(
                        list.title.toString(),
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
