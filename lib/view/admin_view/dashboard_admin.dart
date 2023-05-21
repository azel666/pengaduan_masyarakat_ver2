import 'package:flutter/material.dart';
import 'package:pengaduan_masyarakat_ver2/shared/my_color.dart';
import 'package:pengaduan_masyarakat_ver2/view/admin_view/data_users.dart';
import 'package:pengaduan_masyarakat_ver2/view/admin_view/feed_admin.dart';
import 'package:pengaduan_masyarakat_ver2/view/admin_view/history_aduan.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
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

  final pages = [
    const FeedAdmin(),
    const HistoryAduan(),
    const DataUsers(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.only(bottom: 5),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: "#2E4053".toColor().withOpacity(0.8),
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.only(right: 20),
                    onPressed: () {
                      _updated_index(0);
                    },
                    icon: Icon(
                      Icons.verified,
                      color: _selected_index == 0
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      _updated_index(1);
                    },
                    icon: Icon(
                      Icons.history,
                      color: _selected_index == 1
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    padding: EdgeInsets.only(left: 10),
                    onPressed: () {
                      _updated_index(2);
                    },
                    icon: Icon(
                      Icons.assignment_ind,
                      color: _selected_index == 2
                          ? Colors.white
                          : "#99A3A4".toColor(),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _selected_index,
          children: pages,
        ),
      ),
    );
  }
}
