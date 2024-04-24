
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vvims/constants/constants.dart';
import 'package:vvims/screens/home/home_screen.dart';
import 'package:vvims/screens/notifications/notifiactions.dart';
import 'package:vvims/screens/profile/profile.dart';
import 'package:vvims/screens/scan/scan_screen.dart';
import 'package:vvims/screens/visit_info/visit_info.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _ChatsState();
}

class _ChatsState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;
  IconData lastTapped = Icons.notifications;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() => lastTapped = icon);
    }
  }

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  int currentIndex = 0;

  List pages = [
    const HomeScreen(),
    const VisitInfosScreen(),
    const HomeScreen(),
    const NotificationsScreen(),
    const ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: buildFat(),
        body: pages[currentIndex],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      enableFeedback: true,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (value) {
        setState(() {
          if (value != 2) {
            currentIndex = value;
          }
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.folder_rounded), label: "Folder"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_rounded,
              color: kWhiteColor,
            ),
            label: "None"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_rounded,
            ),
            label: "Notifications"),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_rounded),
          label: "Profile",
        ),
      ],
    );
  }

  SpeedDial buildFat() {
    return SpeedDial(
      icon: Icons.qr_code_scanner_outlined,
      openCloseDial: isDialOpen,
      backgroundColor: kPrimaryColor,
      overlayColor: const Color(0xFF2C4364).withOpacity(0.4),
      overlayOpacity: 0.8,
      spacing: 0,
      elevation: 0,
      buttonSize: const Size(56, 56),
      childrenButtonSize: const Size(300, 60),
      spaceBetweenChildren: 5,
      closeManually: true,
      children: [
        SpeedDialChild(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanScreen(
                    title: "Scan Passport/ID Card",
                    index: 1,
                  ),
                ));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: kSecondaryColor.withOpacity(0.1),
                    child: SvgPicture.asset(
                      "assets/icons/car.svg",
                      height: 20,
                    )),
                const SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Flexible(
                  child: Text(
                    "Scan Passport/ID Card",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
          ),
        ),
        SpeedDialChild(
          //backgroundColor: kWhiteColor,
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanScreen(
                    title: "Scan Vehicle",
                    index: 2,
                  ),
                ));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                100.0), // Customize the border radius as needed
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: kSecondaryColor.withOpacity(0.1),
                  child: SvgPicture.asset(
                    "assets/icons/car.svg",
                    height: 20,
                  )),
              const SizedBox(
                width: kDefaultPadding / 2,
              ),
              Text(
                "Scan Vehicle",
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ],
    );
  }
}
