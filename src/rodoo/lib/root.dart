import 'package:flutter/material.dart';
import 'package:rodoo/utils/constants.dart';
import 'package:rodoo/screens/order_pay.dart';
import 'package:rodoo/screens/search.dart';
import 'package:rodoo/screens/home.dart';

class Root extends StatefulWidget {
  static const String route = '/';

  const Root({super.key});

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedIndex = 0;

  // controls page at selected index, selects from _screens
  PageController pageController = PageController();

  // list of widgets with different screens, must be in same order as nav bar icons
  List<Widget> screens = [Home(), OrderPay(), Search()];

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
              size: 38,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 1 ? restoIconBig : restoIconSmall,
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: selectedIndex == 2 ? 42 : 38,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
