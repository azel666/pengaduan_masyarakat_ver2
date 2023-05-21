import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pengaduan_masyarakat_ver2/view/admin_view/data_user_detail.dart';

class DataUsersCard extends StatefulWidget {
  final listAllDocs;
  const DataUsersCard({required this.listAllDocs, super.key});

  @override
  State<DataUsersCard> createState() => _DataUsersCardState();
}

class _DataUsersCardState extends State<DataUsersCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.listAllDocs.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                var detail =
                    widget.listAllDocs[index].data() as Map<String, dynamic>;
                Get.to(DataUserDetail(detail: detail));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                width: MediaQuery.of(context).size.width,
                height: 145,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    // ignore: prefer_const_constructors
                    BoxShadow(
                      blurRadius: 6,
                      color: Color(0x34000000),
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: (widget.listAllDocs[index].data() as Map<
                                          String, dynamic>)['imageUrl'] ==
                                      ""
                                  ? AssetImage('assets/images/default_user.png')
                                  : Image.network(
                                          '${(widget.listAllDocs[index].data() as Map<String, dynamic>)["imageUrl"]}')
                                      .image)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 230,
                          child: Text(
                            "${(widget.listAllDocs[index].data() as Map<String, dynamic>)["username"]}",
                            style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: 230,
                          child: Text(
                            "${(widget.listAllDocs[index].data() as Map<String, dynamic>)["email"]}",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: 'Poppins'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 230,
                          child: Text(
                            "${(widget.listAllDocs[index].data() as Map<String, dynamic>)["noTelp"]}",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                color: Colors.black54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
