import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marvel/components/drawer.dart';
import 'package:provider/provider.dart';
import '../components/text_style.dart';
import '../constants/image_constants.dart';
import '../constants/string_constants.dart';
import '../controller/marvel_controller.dart';
import '../controller/search_movie.dart';
import 'details_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MarvelListPage2 extends StatefulWidget {
  const MarvelListPage2({Key? key}) : super(key: key);

  @override
  State<MarvelListPage2> createState() => _MarvelListPage2State();
}

class _MarvelListPage2State extends State<MarvelListPage2> {
  int activeIndex = 0;


  late final MarvelController controller;
  var lista;

  @override
  void initState() {
    controller = context.read<MarvelController>();
    controller.getData(query: '');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    MarvelController provider = Provider.of<MarvelController>(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        appBar: buildAppBar(context),
        drawer: const drawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(StringConstants.assistaAgora,
                    style: AppTextStyle.font18),
              ),
              carrouselSlider(provider),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child:
                    Text(StringConstants.popular, style: AppTextStyle.font18),
              ),
              listMovie(provider),
            ],
          ),
        ),

      );
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      // backgroundColor: Colors.transparent,
      title: Text(
        StringConstants.titleText,
        style: AppTextStyle.font22Bold,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchMovie(),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Padding listMovie(MarvelController provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.lista.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 2 - 9,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      data: provider.lista[index],
                                    )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: CachedNetworkImageProvider(
                            provider.lista[index].coverUrl.toString(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      provider.lista[index].title.toString(),
                      style: AppTextStyle.font12Bold,
                    ),
                  ),
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
    );
  }

  Column carrouselSlider(MarvelController provider) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          child: CarouselSlider.builder(
            itemCount: provider.lista.length,
            options: CarouselOptions(
              enlargeCenterPage: true,
              initialPage: 5,
              height: MediaQuery.of(context).size.height / 3.5,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              reverse: false,
              aspectRatio: 5.0,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
            itemBuilder: (context, index, id) {
              return (index <= 0)
                  ? Container()
                  : GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        //ClipRRect for image border radius
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            provider.lista[index].coverUrl.toString(),
                            width: 420,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      data: provider.lista[index],
                                    )));
                      },
                    );
            },
          ),
        ),
        const SizedBox(height: 10),
        buildIndicator(provider),
      ],
    );
  }

  buildIndicator(MarvelController provider) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: provider.lista.length,
        effect: const ScrollingDotsEffect(
          dotHeight: 18,
          dotWidth: 18,
          activeDotColor: Colors.white,
          dotColor: Colors.grey,
        ),
      );
}
