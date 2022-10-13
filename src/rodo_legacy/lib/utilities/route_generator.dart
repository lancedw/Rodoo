import 'package:flutter/material.dart';
import 'package:rodo/screens/detailed_restaurant.dart';
import 'package:rodo/screens/root.dart';
import 'package:rodo/widgets/fullscreen_carousel.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {

      /// initial route is the root of our application tree
      case Root.route:
        return MaterialPageRoute(builder: (context) => Root());

      /// screen with detailed restaurant information, needs the data of the
      /// restaurant for which this screen was called
      case DetailedRestaurant.route:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
              builder: (context) => DetailedRestaurant(restaurantData: args));
        }
        return errorRoute(); // type of args is not int

      case FullscreenCarousel.route:
        if (args is List<Widget>) {
          return MaterialPageRoute(
              builder: (context) => FullscreenCarousel(imageArray: args));
        }
        return errorRoute(); // type of args is not int

      /// Default route when no matching route was found
      default:
        return errorRoute(); // route identifier does not exist
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Error"),
          ),
          body: Center(
            child: Text("Error"),
          ),
        );
      },
    );
  }
}

// routes: {
// Root.route: (context) => Root(),
// Favorites.route: (context) => Favorites(),
// OrderPay.route: (context) => OrderPay(),
// Notifications.route: (context) => Notifications(),
// Account.route: (context) => Account(),
// },
