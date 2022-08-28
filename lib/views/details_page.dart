import 'package:flutter/material.dart';
import 'package:marvel/components/text_style.dart';
import 'package:marvel/constants/string_constants.dart';
import 'package:marvel/controller/favourites_controller.dart';
import 'package:provider/provider.dart';
import '../constants/error_constants.dart';
import '../constants/image_constants.dart';
import '../controller/mylist.dart';
import '../data/models/marvel_models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../utils/routes.dart';

class DetailsPage extends StatefulWidget {
  Data? data;

  DetailsPage({Key? key, this.data}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: movieDetails(),
    );
  }

  Padding movieDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            cardMovie(),
            const SizedBox(height: 20),
            infoDetailsMovie(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                StringConstants.sumary,
                style: AppTextStyle.font25Bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.data!.overview.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Row infoDetailsMovie() {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          (DateFormat("yyyy")
              .format(DateTime.parse(widget.data!.releaseDate.toString()))),
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 15),
        Text('|'),
        const SizedBox(width: 15),
        Text(
          widget.data!.duration.toString(),
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          StringConstants.minutes,
          style: AppTextStyle.font15,
        ),
        const SizedBox(width: 8),
        Text('|'),
        const SizedBox(width: 10),
        Container(
          alignment: Alignment.center,
          height: 15,
          child: Image.asset(ImageConstants.imageAssetEstrela),
        ),
        const SizedBox(width: 10),
        Text('8.5', style: AppTextStyle.font15),
        const SizedBox(width: 30),
        Container(
          alignment: Alignment.topLeft,
          height: 35,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black54,
          ),
          child: Row(
            children: [
              Consumer<MyList>(
                builder: (context, value, child) => IconButton(
                  onPressed: () {
                    value.listLaterOnly(widget.data!);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Adicionado a minha lista!')));
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'Minha Lista',
                style: AppTextStyle.font15,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack cardMovie() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Image.network(
              widget.data!.coverUrl.toString(),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Colors.black54, Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: 15,
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
        Positioned(
          left: 170,
          top: 100,
          child: InkWell(
            onTap: callVideoPlayer,
            child: const Icon(
              Icons.play_circle_outline,
              color: Colors.yellow,
              size: 65,
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 15,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white12),
            child: Consumer<Favorites>(
              builder: (context, provider, child) => IconButton(
                onPressed: () {
                  provider.toogleFavorite();
                  favoritesController(provider, context);
                },
                icon: Icon(
                  provider.listFavorites.contains(widget.data)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void favoritesController(Favorites provider, BuildContext context) {
    if (!provider.listFavorites.contains(widget.data)) {
      provider.listFavorites.add(widget.data!);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Adicionado aos Favoritos!')));
    } else {
      provider.listFavorites.remove(widget.data!);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('removido dos Favoritos!')));
    }
  }

  Container container() {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
    );
  }

  void callVideoPlayer() async {
    final url = widget.data!.trailerUrl.toString();
    if (await launch(url)) {
      await launch(
        url,
        enableJavaScript: true,
        forceWebView: true,
      );
    } else {
      throw ErrorConstants.VideoNaoDisponivel + url;
    }
  }
}
