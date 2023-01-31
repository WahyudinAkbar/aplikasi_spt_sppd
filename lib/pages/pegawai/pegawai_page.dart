import 'package:aplikasi_kepegawaian/pages/login/profile_page.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/edit_pegawai_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/create_spt_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/edit_spt_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/report_spt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
                  "Data Pegawai",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
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
                                DataColumn(label: Text('Nama')),
                                DataColumn(label: Text('NIP')),
                                DataColumn(label: Text('Pangkat / Golongan')),
                                DataColumn(label: Text('Jabatan')),
                                DataColumn(label: Text('Action')),
                              ],
                              rows: List<DataRow>.generate(
                                  snapshot.data!.docs.length, (index) {
                                int no = index + 1;
                                return DataRow(cells: [
                                  DataCell(Text(no.toString())),
                                  DataCell(
                                      Text(snapshot.data!.docs[index]['nama'])),
                                  DataCell(
                                      Text(snapshot.data!.docs[index]['nip'])),
                                  DataCell(Text(
                                      snapshot.data!.docs[index]['golongan'])),
                                  DataCell(Text(
                                      snapshot.data!.docs[index]['jabatan'])),
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
                                                    EditPegawaiPage(
                                                  username: snapshot.data!
                                                      .docs[index]['username'],
                                                  nama: snapshot.data!
                                                      .docs[index]['nama'],
                                                  nip: snapshot
                                                      .data!.docs[index]['nip'],
                                                  pangkat: snapshot.data!
                                                      .docs[index]['golongan'],
                                                  jabatan: snapshot.data!
                                                      .docs[index]['jabatan'],
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
                      child: Text("Cetak Data Pegawai"),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                            (Route<dynamic> route) => false);
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
      await FirebaseFirestore.instance.collection('spt').doc(id).delete();

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

