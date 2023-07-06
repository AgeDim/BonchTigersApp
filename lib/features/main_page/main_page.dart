import 'package:bonch_tigers_app/features/calendar/calendar_page.dart';
import 'package:bonch_tigers_app/features/main_page/main_presenter.dart';
import 'package:bonch_tigers_app/features/profile/profile_page.dart';
import 'package:bonch_tigers_app/features/stats/stats_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/style_library.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/mainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  late MainPresenter _presenter;
  String? role;

  Future<void> getCurrentUserRole() async {
    final userRole = await _presenter.getCurrentUserRole();
    setState(() {
      role = userRole;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    DatabaseReference userRef = FirebaseDatabase.instance.ref();
    _presenter = MainPresenter(firebaseAuth, userRef);
    getCurrentUserRole();
  }

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
          backgroundColor: StyleLibrary.color.orange,
          selectedItemColor: StyleLibrary.color.orange,
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
        CalendarPage(
          role: role,
        ),
        const StatsPage(),
        ProfilePage(role:role)
      ][currentPageIndex],
    );
  }
}
