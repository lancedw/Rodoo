import 'package:flutter/material.dart';
import 'package:livent/widgets/buttons/roundedLogRegButton.dart';
import 'package:photo_view/photo_view.dart';
import 'package:livent/dao/fire_storage.dart';
import 'package:livent/utils/constants.dart';
import 'package:livent/widgets/fullscreen_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';

//TODO: optimize loading and pass the first loaded image from the resto_card directly
class DetailedRestaurant extends StatefulWidget {
  static const String route = '/detailedRestaurant';

  final Map<String, dynamic> restaurantData;

  DetailedRestaurant({required this.restaurantData});

  @override
  State<DetailedRestaurant> createState() => _DetailedRestaurantState();
}

class _DetailedRestaurantState extends State<DetailedRestaurant> {
  // this list holds images in the right format to pass to the fullscreen image viewer
  late List<Widget> images = [];
  // initially the list is just a loading animation
  late List<Widget> carouselWidgets = [
    Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: CircularProgressIndicator(
          color: rodoRose,
        ),
      ),
    ),
  ];

  fetchAllImages() async {
    List<Widget> result = [];
    // for (int i = 0; i < widget.restaurantData['imageName'].length; i++) {
    //   String url = await FireStorageService.loadImage(
    //       context, widget.restaurantData['imageName'][i]);
    // PhotoView photoView =
    // PhotoView(imageProvider: NetworkImage(url)); // extended image widget
    for (int i = 1; i < 4; i++) {
      Image img = await FireStorageService.getImage(
          context, "${widget.restaurantData['imageName']}$i.jpeg");
      PhotoView photoView = PhotoView(
        imageProvider: AssetImage(
          "${widget.restaurantData['imageName']}${[i]}.jpeg",
        ),
      ); // extended image widget
      images.add(photoView);
      Container container = Container(
        height: MediaQuery.of(context).size.width * 0.5,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            // child: Image.network(
            //   url,
            //   fit: BoxFit.cover,
            // ),
            child: img),
      );
      result.add(container);
    }
    setState(() {
      images = images;
      carouselWidgets = result;
    });
  }

  @override
  void initState() {
    fetchAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.restaurantData['Name'],
          style: appBarTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          child: ListView(children: <Widget>[
            //TODO: fix route generator for full screen view
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                FullscreenCarousel.route,
                arguments: images,
              ),
              child: Hero(
                tag: 'carouselSlider',
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    viewportFraction: 1,
                  ),
                  items: carouselWidgets,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurantData['Name'],
                        style: restoNameTextStyle,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.star,
                        size: 20,
                      ),
                      Text(
                        widget.restaurantData['Rating'].toString(),
                        style: ratingTextStyle,
                      )
                    ],
                  ),
                  Text(
                    widget.restaurantData['Address'],
                  ),
                  RoundedLogRegButton(
                    color: rodoRose,
                    buttonTitle: "Reserve Table",
                    onPressed: () => {},
                  ),
                  RoundedLogRegButton(
                    color: rodoRose,
                    buttonTitle: "View Menu",
                    onPressed: () => {},
                  ),
                  const Text(
                    "Location",
                    style: restoNameTextStyle,
                  ),
                  Text(
                    // data['Address'].join(' • '),
                    widget.restaurantData['Address'],
                    style: generalTextStyle,
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
              height: 260,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/images/maps.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 15,
              ),
            ),
            const Text(
              "Experiences",
              style: restoNameTextStyle,
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 7,
              ),
            ),
            Column(
              children: const [
                Text(
                  "John Smit: Had a great time here! Food was top quality, friendly personnel and very cosy interior!",
                ),
                SizedBox(height: 7),
                Text(
                  "John Smit: Had a great time here! Food was top quality, friendly personnel and very cosy interior!",
                ),
                SizedBox(height: 7),
                Text(
                  "John Smit: Had a great time here! Food was top quality, friendly personnel and very cosy interior!",
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 15,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
