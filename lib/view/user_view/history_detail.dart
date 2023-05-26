import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan_masyarakat_ver2/resource/firestore_method.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HistoryDetail extends StatefulWidget {
  final detail;
  const HistoryDetail({this.detail, super.key});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  String aduanid = "";
  String imageUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF2E4053)),
          elevation: 1,
          actions: [
            // Text(
            //   'hapus',
            // ),
            IconButton(
              onPressed: () {
                if (widget.detail['progress3'] != false) {
                  deleteAduan();
                  Get.back();
                }
              },
              icon: Icon(
                Icons.delete,
                color: Color(0xFF2E4053),
              ),
            )
          ],
          // backgroundColor: "#2E4053".toColor(),
          backgroundColor: Colors.white,
          title: const Text(
            'History Detail',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF2E4053),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: 950,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 10, right: 15, left: 15),
              child: content(),
            ),
          ),
        ));
  }

  Widget content() {
    return PhysicalModel(
      elevation: 3,
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              Image.network(widget.detail['imageUrl']).image)),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Lokasi : ${widget.detail['lokasi']}",
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            widget.detail['judul'],
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            widget.detail['deskripsi'],
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            const Divider(
              thickness: 2,
              color: Colors.black38,
              indent: 5,
              endIndent: 5,
            ),
            PhysicalModel(
              color: Color(0xFF2E4053),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 380,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Progres Aduan',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        SizedBox(
                            width: 250,
                            height: 100,
                            child: TimelineTile(
                              afterLineStyle: LineStyle(
                                color: widget.detail['progress2'] == false
                                    ? Colors.grey
                                    : Colors.lightBlue,
                              ),
                              indicatorStyle: IndicatorStyle(
                                  iconStyle: IconStyle(
                                      iconData:
                                          widget.detail['progress1'] != false
                                              ? Icons.check
                                              : Icons.circle,
                                      color: Colors.white),
                                  color: widget.detail['progress1'] == false
                                      ? Colors.grey
                                      : Colors.lightBlue,
                                  width: 30,
                                  height: 30),
                              endChild: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Aduan sudah diverifikasi',
                                  style: TextStyle(
                                    color: widget.detail['progress1'] == false
                                        ? Colors.grey
                                        : Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                              isFirst: true,
                              isLast: false,
                            )),
                        SizedBox(
                          width: 250,
                          height: 100,
                          child: TimelineTile(
                            afterLineStyle: LineStyle(
                                color: widget.detail['progress3'] == false
                                    ? Colors.grey
                                    : Colors.lightBlue),
                            beforeLineStyle: LineStyle(
                                color: widget.detail['progress2'] == false
                                    ? Colors.grey
                                    : Colors.lightBlue),
                            indicatorStyle: IndicatorStyle(
                              iconStyle: IconStyle(
                                  iconData: widget.detail['progress2'] != false
                                      ? Icons.check
                                      : Icons.circle,
                                  color: Colors.white),
                              color: widget.detail['progress2'] == false
                                  ? Colors.grey
                                  : Colors.lightBlue,
                              width: 30,
                              height: 30,
                            ),
                            endChild: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Masalah sedang diproses',
                                style: TextStyle(
                                  color: widget.detail['progress2'] == false
                                      ? Colors.grey
                                      : Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.white,
                                ),
                              ),
                            ),
                            isFirst: false,
                            isLast: false,
                          ),
                        ),
                        SizedBox(
                            width: 250,
                            height: 100,
                            child: TimelineTile(
                              beforeLineStyle: LineStyle(
                                  color: widget.detail['progress3'] == false
                                      ? Colors.grey
                                      : Colors.lightBlue),
                              indicatorStyle: IndicatorStyle(
                                  iconStyle: IconStyle(
                                      iconData:
                                          widget.detail['progress3'] != false
                                              ? Icons.check
                                              : Icons.circle,
                                      color: Colors.white),
                                  color: widget.detail['progress3'] == false
                                      ? Colors.grey
                                      : Colors.lightBlue,
                                  width: 30,
                                  height: 30),
                              isFirst: false,
                              isLast: true,
                              endChild: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Masalah sudah terselesaikan',
                                  style: TextStyle(
                                    color: widget.detail['progress3'] == false
                                        ? Colors.grey
                                        : Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteAduan() async {
    await FirestoreMethod().deleteDataHistory(imageUrl, aduanid);
  }

  void getData() async {
    await FirebaseFirestore.instance
        .collection('history_aduan')
        .doc(widget.detail['aduanid'])
        .get()
        .then((snap) {
      if (snap.exists) {
        setState(() {
          aduanid = snap.get('aduanid');
          imageUrl = snap.get('imageUrl');
        });
      }
    });
  }
}
