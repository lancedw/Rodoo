import 'package:flutter/material.dart';
import 'package:livent/utils/constants.dart';
import 'package:livent/screens/order-pay.dart';
import 'package:livent/screens/favorites.dart';
import 'package:livent/screens/home.dart';
import 'package:livent/screens/notifications.dart';
import 'package:livent/screens/account.dart';

class Root extends StatefulWidget {
  static const String route = '/';

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedIndex = 0;

  // controls page at selected index, selects from _screens
  PageController pageController = PageController();

  // list of widgets with different screens, must be in same order as nav bar icons
  List<Widget> screens = [
    Home(),
    Favorites(),
    OrderPay(),
    Notifications(),
    Account()
  ];

  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type fixed to disable default animations
        type: BottomNavigationBarType.fixed,
        onTap: (int selectedIndex) {
          pageController.jumpToPage(selectedIndex);
        },
        // Font size set to 0 because there are no labels by the icons
        unselectedFontSize: 0,
        selectedFontSize: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1 ? Icons.favorite : Icons.favorite_border_sharp,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: selectedIndex == 2 ? restoIconBig : restoIconSmall,
              label: ''),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3
                  ? Icons.notifications
                  : Icons.notifications_outlined,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 4 ? Icons.person : Icons.person_outline,
              size: 30,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
