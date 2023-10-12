import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:smart_case/theme/color.dart';

import '../widgets/bottom_bar_item.dart';
import 'activities_page.dart';
import 'files_page.dart';
import 'home_page.dart';
import 'locator_page.dart';
import 'notifications_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _activeTab = 0;

  _barItems() {
    return [
      {
        "icon": Icons.home_outlined,
        "active_icon": Icons.home_rounded,
        "name": "Home",
        "page": const HomePage(),
      },
      {
        "icon": Icons.file_copy_outlined,
        "active_icon": Icons.file_copy_rounded,
        "name": "Files",
        "page": const FilesPage(),
      },
      {
        "icon": Icons.local_activity_outlined,
        "active_icon": Icons.local_activity_rounded,
        "name": "Activities",
        "page": const ActivitiesPage(),
      },
      {
        "icon": Icons.notifications_none_rounded,
        "active_icon": Icons.notifications_rounded,
        "name": "Alerts",
        "page": const NotificationsPage(),
      },
      {
        "icon": Icons.location_on_outlined,
        "active_icon": Icons.location_on_rounded,
        "name": "Locator",
        "page": const LocatorPage(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: DoubleBack(
        message: 'Tap back again to exit',
        child: _buildPage(),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: _buildFab(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  _buildFab() {
    return ExpandableFab(
      type: ExpandableFabType.up,
      duration: const Duration(milliseconds: 500),
      distance: 65.0,
      pos: ExpandableFabPos.right,
      childrenOffset: const Offset(0, 20),
      overlayStyle: ExpandableFabOverlayStyle(
        // color: Colors.black.withOpacity(0.5),
        blur: 5,
      ),
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary,
        angle: 3.14 * 2,
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary,
      ),
      children: [
        FloatingActionButton.extended(
          heroTag: null,
          icon: const Icon(Icons.list_rounded),
          onPressed: () {},
          label: const Text("Requisitions"),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          icon: const Icon(Icons.handshake_outlined),
          onPressed: () {},
          label: const Text("Engagements"),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          icon: const Icon(Icons.local_activity_outlined),
          onPressed: () {},
          label: const Text("Activity"),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          icon: const Icon(Icons.calendar_month_rounded),
          onPressed: () {},
          label: const Text("Diary"),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          icon: const Icon(Icons.task_outlined),
          onPressed: () {},
          label: const Text("Tasks"),
        ),
      ],
    );
  }

  Widget _buildPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        _barItems().length,
        (index) => _barItems()[index]["page"],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 55,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      // margin: const EdgeInsets.only(
      //   left: 15,
      //   right: 15,
      //   bottom: 5,
      //   top: 5,
      // ),
      // decoration: BoxDecoration(
      //   color: AppColors.appBgColor,
      //   borderRadius: BorderRadius.circular(20),
      //   boxShadow: [
      //     BoxShadow(
      //       color: AppColors.shadowColor.withOpacity(.1),
      //       blurRadius: 1,
      //       spreadRadius: 1,
      //       offset: const Offset(0, 1),
      //     )
      //   ],
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          _barItems().length,
          (index) {
            if (index == 2) {
              return BottomBarItem(
                _activeTab == index
                    ? _barItems()[index]["active_icon"]
                    : _barItems()[index]["icon"],
                _barItems()[index]["name"],
                isActive: _activeTab == index,
                activeColor: AppColors.primary,
                onTap: () {
                  setState(() {
                    _activeTab = index;
                  });
                },
              );
            } else {
              return BottomBarItem(
                _activeTab == index
                    ? _barItems()[index]["active_icon"]
                    : _barItems()[index]["icon"],
                _barItems()[index]["name"],
                isActive: _activeTab == index,
                activeColor: AppColors.primary,
                onTap: () {
                  setState(() {
                    _activeTab = index;
                  });
                },
              );
            }
          },
        ),
      ),
    );
  }
}
