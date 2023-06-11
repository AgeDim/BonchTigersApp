import 'package:bonch_tigers_app/features/calendar/calendar_page.dart';
import 'package:bonch_tigers_app/features/profile/profile_page.dart';
import 'package:bonch_tigers_app/features/stats/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFFE4500),
          selectedItemColor: const Color(0xFFFE4500),
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          currentIndex: currentPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentPageIndex == 0
                    ? 'assets/images/CalendarEnable.svg'
                    : 'assets/images/CalendarDisable.svg',
                width: 40,
                height: 40,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentPageIndex == 1
                    ? 'assets/images/StatsEnable.svg'
                    : 'assets/images/StatsDisable.svg',
                width: 40,
                height: 40,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentPageIndex == 2
                    ? 'assets/images/ProfileEnable.svg'
                    : 'assets/images/ProfileDisable.svg',
                width: 40,
                height: 40,
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: <Widget>[
        const CalendarPage(),
        const StatsPage(),
        const ProfilePage()
      ][currentPageIndex],
    );
  }
}
