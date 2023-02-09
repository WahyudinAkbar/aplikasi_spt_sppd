import 'package:aplikasi_kepegawaian/pages/sppd/edit_sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/create_spt_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/edit_spt_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/report_spt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'create_sppd_page.dart';

class SppdPage extends StatefulWidget {
  const SppdPage({super.key});

  @override
  State<SppdPage> createState() => _SppdPageState();
}

class _SppdPageState extends State<SppdPage> {
  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  stream: FirebaseFirestore.instance
                      .collection('sppd')
                      .orderBy('send_time')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
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
                                        child: Text("Edit"),
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
                                        child: Text("Hapus"),
                                        onPressed: () {
                                          deleteData(
                                              snapshot.data!.docs[index].id);
                                        },
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      ElevatedButton(
                                        child: Text("Cetak"),
                                        onPressed: () {
                                          reportSpt(
                                            context,
                                            snapshot.data!.docs[index]
                                                ['no_spt'],
                                            snapshot.data!.docs[index]['nama'],
                                            snapshot.data!.docs[index]
                                                ['maksud_tujuan'],
                                            snapshot.data!.docs[index]
                                                ['tempat_tujuan'],
                                            formatDate(snapshot.data!
                                                    .docs[index]['tanggal'])
                                                .toString(),
                                            formatDate(snapshot.data!
                                                    .docs[index]['sendTime'])
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
                      child: Text("Tambah Sppd Baru"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateSppdPage(),
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

  String formatDate(date) {
    return DateFormat(
      'EEEE, d MMMM yyyy',
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

