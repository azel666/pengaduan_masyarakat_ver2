import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan_masyarakat_ver2/shared/my_color.dart';
import 'package:pengaduan_masyarakat_ver2/utils/global_variable.dart';
import 'package:pengaduan_masyarakat_ver2/view/user_view/tambah_aduan.dart';

// import '../../utils/colors.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({super.key});

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  int _selected_index = 0;

  void _updated_index(int index) {
    setState(() {
      _selected_index = index;
    });
  }

  Future<bool> onBackPressed() {
    if (_selected_index != 0) {
      setState(() {
        _selected_index = 0;
      });
      return Future.value(false); // Tidak tindak lanjuti navigasi kembali
    }
    return Future.value(true); // Tindak lanjuti navigasi kembali
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.only(bottom: 8),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: "#2E4053".toColor().withOpacity(0.8),
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                Spacer(),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.only(right: 20),
                    onPressed: () {
                      _updated_index(0);
                    },
                    icon: Icon(
                      Icons.home,
                      color: _selected_index == 0
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 30,
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      _updated_index(1);
                    },
                    icon: Icon(
                      Icons.feedback,
                      color: _selected_index == 1
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 25,
                    ),
                  ),
                ),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      _updated_index(2);
                    },
                    icon: Icon(
                      Icons.help_center,
                      color: _selected_index == 2
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 25,
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.only(left: 10),
                    onPressed: () {
                      _updated_index(3);
                    },
                    icon: Icon(
                      Icons.person,
                      color: _selected_index == 3
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 30,
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: "#99A3A4".toColor(),
            child: Icon(
              Icons.add,
              size: 35,
            ),
            onPressed: () {
              Get.to(TambahAduan());
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: dashboardItems.elementAt(_selected_index),
      ),
    );
  }
}
