import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marvel/components/drawer_widget.dart';
import 'package:provider/provider.dart';
import '../components/text_style_widget.dart';
import '../constants/string_constants.dart';
import '../controller/marvel_controller.dart';
import '../components/search_movie.dart';
import '../data/models/marvel_models.dart';
import 'details_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MarvelListPage2 extends StatefulWidget {
  const MarvelListPage2({Key? key}) : super(key: key);

  @override
  State<MarvelListPage2> createState() => _MarvelListPage2State();
}

class _MarvelListPage2State extends State<MarvelListPage2> {
  int activeIndex = 0;
  List<Data> lista=[];

  late final MarvelController controller;

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
        appBar: _buildAppBar(context),
        drawer: const DrawerWidget(),
        body: provider.lista.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    _textAssistaAgora(),
                    _carrouselSlider(provider),
                    _textRecomended(),
                    _listMovieRecommended(provider),
                    _textTop10(),
                    _listMovieTop10(context, provider)
                  ],
                ),
              ),
      );
    });
  }

  _textTop10() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(StringConstants.top10, style: AppTextStyle.font22),
    );
  }

 _textRecomended() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(StringConstants.recomendados, style: AppTextStyle.font22),
    );
  }

  _textAssistaAgora() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(StringConstants.assistaAgora, style: AppTextStyle.font22),
    );
  }

  _listMovieTop10(BuildContext context, MarvelController provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.lista.length,
            itemBuilder: (context, index) {
              var list = provider.lista.sublist(9)[index];
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
                    child: Text(
                      list.title.toString(),
                      style: AppTextStyle.font12Bold,
                    ),
                  ),

                ],
              );
            }),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      // backgroundColor: Colors.transparent,
      title: Text(
        StringConstants.marvelApp,
        style: AppTextStyle.font22,
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

  _listMovieRecommended(MarvelController provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3.4,
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
                    height: MediaQuery.of(context).size.height / 3.7,
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
                        child: Hero(
                          tag:provider.lista[index].coverUrl.toString(),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      provider.lista[index].title.toString(),
                      style: AppTextStyle.font12Bold,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  _carrouselSlider(MarvelController provider) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          child: CarouselSlider.builder(
            itemCount: provider.lista.length,
            options: CarouselOptions(
              enlargeCenterPage: true,
              initialPage: 6,
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
