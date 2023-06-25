import 'package:aplikasi_kepegawaian/pages/nota_dinas/create_nota_dinas_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/edit_sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/sppd/laporan_sppd.dart';
import 'package:aplikasi_kepegawaian/pages/spt/create_spt_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/edit_spt_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/report_spt.dart';
import 'package:aplikasi_kepegawaian/widget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'create_sppd_page.dart';

class SppdPage extends StatefulWidget {
  const SppdPage({super.key});

  @override
  State<SppdPage> createState() => _SppdPageState();
}

class _SppdPageState extends State<SppdPage> {
  Stream? stream;

  @override
  void initState() {
    super.initState();
    isAdmin();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
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
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Surat Perintah Perjalanan Dinas",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text('Belum ada data'));
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30, left: 20),
                          child: DataTable(
                              border: TableBorder.all(),
                              columns: const [
                                DataColumn(label: Text('No')),
                                DataColumn(label: Text('No Surat')),
                                DataColumn(label: Text('Nama')),
                                DataColumn(label: Text('Maksud Tujuan')),
                                DataColumn(label: Text('Tempat Tujuan')),
                                DataColumn(label: Text('Tanggal Berangkat')),
                                DataColumn(label: Text('Tanggal Kembali')),
                                DataColumn(label: Text('Alat Transportasi')),
                                DataColumn(label: Text('Keterangan Lain-lain')),
                                DataColumn(label: Text('Action')),
                              ],
                              rows: List<DataRow>.generate(
                                  snapshot.data!.docs.length, (index) {
                                int no = index + 1;
                                return DataRow(cells: [
                                  DataCell(Text(no.toString())),
                                  DataCell(Text(
                                      snapshot.data!.docs[index]['no_sppd'])),
                                  DataCell(
                                      Text(snapshot.data!.docs[index]['nama'])),
                                  DataCell(SizedBox(
                                    width: 300,
                                    child: Text(
                                      snapshot.data!.docs[index]
                                          ['maksud_tujuan'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  )),
                                  DataCell(Text(snapshot.data!.docs[index]
                                      ['tempat_tujuan'])),
                                  DataCell(
                                    Text(
                                      formatDate(snapshot.data!.docs[index]
                                          ['tanggal_berangkat']),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      formatDate(snapshot.data!.docs[index]
                                          ['tanggal_kembali']),
                                    ),
                                  ),
                                  DataCell(Text(snapshot.data!.docs[index]
                                      ['alat_transportasi'])),
                                  DataCell(Text(snapshot.data!.docs[index]
                                      ['keterangan_lain'])),
                                  DataCell(Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.yellow),
                                        child: const Text(
                                          "Edit",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditSppdPage(
                                                  idSuratTugas: snapshot
                                                      .data!.docs[index].id,
                                                  noSurat: snapshot.data!
                                                      .docs[index]['no_sppd'],
                                                  pegawai: snapshot.data!
                                                      .docs[index]['nama'],
                                                  tempatTujuan:
                                                      snapshot.data!.docs[index]
                                                          ['tempat_tujuan'],
                                                  maksudTujuan:
                                                      snapshot.data!.docs[index]
                                                          ['maksud_tujuan'],
                                                  tanggalBerangkat: snapshot
                                                      .data!
                                                      .docs[index]
                                                          ['tanggal_berangkat']
                                                      .toDate(),
                                                  tanggalKembali: snapshot
                                                      .data!
                                                      .docs[index]
                                                          ['tanggal_kembali']
                                                      .toDate(),
                                                  transportasi:
                                                      snapshot.data!.docs[index]
                                                          ['alat_transportasi'],
                                                  keterangan:
                                                      snapshot.data!.docs[index]
                                                          ['keterangan_lain'],
                                                ),
                                              ));
                                        },
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        child: const Text(
                                          "Hapus",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          showAlertDialog(context,
                                              snapshot.data!.docs[index].id);
                                        },
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      ElevatedButton(
                                        child: const Text(
                                          "Cetak",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          laporanSppd(
                                            snapshot.data!.docs[index]
                                                ['no_sppd'],
                                            snapshot.data!.docs[index]['nama'],
                                            snapshot.data!.docs[index]
                                                ['maksud_tujuan'],
                                            snapshot.data!.docs[index]
                                                ['tempat_tujuan'],
                                            formatDate(
                                                    snapshot.data!.docs[index]
                                                        ['tanggal_berangkat'])
                                                .toString(),
                                            formatDate(
                                                    snapshot.data!.docs[index]
                                                        ['tanggal_kembali'])
                                                .toString(),
                                            hitungHari(
                                                snapshot.data!.docs[index]
                                                    ['tanggal_kembali'],
                                                snapshot.data!.docs[index]
                                                    ['tanggal_berangkat']),
                                            snapshot.data!.docs[index]
                                                ['alat_transportasi'],
                                            snapshot.data!.docs[index]
                                                ['keterangan_lain'],
                                            formatDate(snapshot.data!
                                                    .docs[index]['send_time'])
                                                .toString(),
                                          );
                                        },
                                      )
                                    ],
                                  )),
                                ]);
                              })),
                        ),
                      );
                    }
                  }),
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
                      child: const Text("Ajukan Surat Perjalanan Dinas"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateNotaDinasPage(),
                            ));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(id: '3'),
    );
  }

  void deleteData(id) async {
    try {
      await FirebaseFirestore.instance.collection('sppd').doc(id).delete();

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

  showAlertDialog(BuildContext context, id) {
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Hapus",
        style: TextStyle(color: Colors.redAccent),
      ),
      onPressed: () {
        deleteData(id);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Hapus Data Ini?"),
      content: const Text(
          "Yakin ingin menghapus data ini? Data akan dihapus secara permanen"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void isAdmin() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      if (value.get('roles') == 'admin') {
        setState(() {
          stream = FirebaseFirestore.instance
              .collection('sppd')
              .orderBy('send_time')
              .snapshots();
        });
      } else {
        setState(() {
          stream = FirebaseFirestore.instance
              .collection('sppd')
              .where('userId', isEqualTo: uid)
              .snapshots();
        });
      }
    });
  }

  String hitungHari(tglKembali, tglBerangkat) {
    tglKembali = tglKembali.toDate();
    tglBerangkat = tglBerangkat.toDate();
    var hari = tglKembali.difference(tglBerangkat).inDays + 1;

    return hari.toString();
  }

  String formatDate(date) {
    return DateFormat(
      'd MMMM yyyy',
      'id',
    ).format(date.toDate());
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
