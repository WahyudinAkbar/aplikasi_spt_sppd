import 'package:aplikasi_kepegawaian/pages/login/register_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/account_menu.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/create_pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/edit_pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/report_pegawai.dart';
import 'package:aplikasi_kepegawaian/widget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _rowsPerPage = 4;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.bars),
          iconSize: 30,
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Data Pegawai",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            const Border(top: BorderSide(color: Colors.grey)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset: const Offset(0, -1),
                              blurRadius: 7,
                              spreadRadius: 1)
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 4,
                      height: 40,
                      child: ElevatedButton(
                        child: const Text("Tambah"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreatePegawaiPage(),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FirestoreQueryBuilder(
                query: FirebaseFirestore.instance.collection('users'),
                builder: (context, snapshot, _) {
                  return PaginatedDataTable(
                    rowsPerPage: _rowsPerPage,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('No'),
                      ),
                      DataColumn(
                        label: Text('Nama'),
                      ),
                      DataColumn(
                        label: Text('NIP'),
                      ),
                      DataColumn(
                        label: Text('Pangkat / Golongan'),
                      ),
                      DataColumn(
                        label: Text('Jabatan'),
                      ),
                      DataColumn(
                        label: Text('Bidang'),
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    onPageChanged: (int? n) {
                      snapshot.fetchMore();
                    },
                    source: MyData(snapshot.docs, context),
                  );
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: Colors.grey)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(0, -1),
                            blurRadius: 7,
                            spreadRadius: 1)
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      child: Text("Cetak Data Pegawai"),
                      onPressed: () {
                        reportPegawai();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(id: '5'),
    );
  }
}

Widget verticalDivider = const VerticalDivider(
  color: Colors.black,
  thickness: 1,
);

void deleteData(id) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(id).delete();

    Fluttertoast.showToast(
        msg: "Data Berhasil Dihapus",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  } catch (e) {
    print(e);
  }
}

class MyData extends DataTableSource {
  MyData(this.data, this.context);

  final BuildContext context;
  final List<dynamic> data;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(data[index].data()["nama"])),
      DataCell(Text(data[index].data()["nip"])),
      DataCell(Text(data[index].data()["golongan"])),
      DataCell(Text(data[index].data()["jabatan"])),
      DataCell(Text(data[index].data()["bidang"])),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => EditPegawaiPage(
              //         title: "Edit Pegawai",
              //         username: data[index].data()["username"],
              //         nama: data[index].data()["nama"],
              //         nip: data[index].data()["nip"],
              //         pangkat: data[index].data()["golongan"],
              //         jabatan: data[index].data()["jabatan"],
              //         bidang: data[index].data()["bidang"],
              //       ),
              //     ));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountMenu(
                        idPegawai: data[index].reference.id,
                        username: data[index].data()["username"],
                        nama: data[index].data()["nama"],
                        nip: data[index].data()["nip"],
                        pangkat: data[index].data()["golongan"],
                        jabatan: data[index].data()["jabatan"],
                        bidang: data[index].data()["bidang"],
                        email: data[index].data()["email"],
                        password: data[index].data()["password"]),
                  ));
            },
          ),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
            child: Text("Hapus"),
            onPressed: () {
              deleteData(data[index].reference.id);
            },
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      )),
    ]);
  }
}


 // final CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('spt');

  // List dataSpt = [];

  // Future<void> getData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();

  //   // Get data from docs and convert map to List
  //   dataSpt = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   print(dataSpt[0]['id_users']);
  // }

              // StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection('users')
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         return const Center(child: CircularProgressIndicator());
              //       } else {

              //         return SingleChildScrollView(
              //           scrollDirection: Axis.vertical,
              //           child: SingleChildScrollView(
              //             scrollDirection: Axis.horizontal,
              //             child: Padding(
              //               padding: const EdgeInsets.only(right: 30, left: 20),
              //               child: DataTable(
              //                   border: TableBorder.all(),
              //                   columns: const [
              //                     DataColumn(label: Text('No')),
              //                     DataColumn(label: Text('Nama')),
              //                     DataColumn(label: Text('NIP')),
              //                     DataColumn(label: Text('Pangkat / Golongan')),
              //                     DataColumn(label: Text('Jabatan')),
              //                     DataColumn(label: Text('Bidang')),
              //                     DataColumn(label: Text('Action')),
              //                   ],
              //                   rows: List<DataRow>.generate(
              //                       snapshot.data!.docs.length, (index) {
              //                     int no = index + 1;
              //                     return DataRow(cells: [
              //                       DataCell(Text(no.toString())),
              //                       DataCell(Text(
              //                         snapshot.data!.docs[index]['nama'],
              //                       )),
              //                       DataCell(Text(
              //                           snapshot.data!.docs[index]['nip'])),
              //                       DataCell(Text(snapshot.data!.docs[index]
              //                           ['golongan'])),
              //                       DataCell(Text(
              //                           snapshot.data!.docs[index]['jabatan'])),
              //                       DataCell(Text(
              //                           snapshot.data!.docs[index]['bidang'])),
              //                       DataCell(Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceAround,
              //                         children: [
              //                           ElevatedButton(
              //                             child: Text("Edit"),
              //                             onPressed: () {
              //                               Navigator.push(
              //                                   context,
              //                                   MaterialPageRoute(
              //                                     builder: (context) =>
              //                                         EditPegawaiPage(
              //                                       title: "Edit Pegawai",
              //                                       username: snapshot
              //                                               .data!.docs[index]
              //                                           ['username'],
              //                                       nama: snapshot.data!
              //                                           .docs[index]['nama'],
              //                                       nip: snapshot.data!
              //                                           .docs[index]['nip'],
              //                                       pangkat: snapshot
              //                                               .data!.docs[index]
              //                                           ['golongan'],
              //                                       jabatan: snapshot.data!
              //                                           .docs[index]['jabatan'],
              //                                       bidang: snapshot.data!
              //                                           .docs[index]['bidang'],
              //                                     ),
              //                                   ));
              //                             },
              //                           ),
              //                           const SizedBox(
              //                             width: 8,
              //                           ),
              //                           ElevatedButton(
              //                             child: Text("Hapus"),
              //                             onPressed: () {
              //                               deleteData(
              //                                   snapshot.data!.docs[index].id);
              //                             },
              //                           ),
              //                           const SizedBox(
              //                             width: 8,
              //                           ),
              //                         ],
              //                       )),
              //                     ]);
              //                   })),
              //             ),
              //           ),
              //         );
              //       }
              //     }),