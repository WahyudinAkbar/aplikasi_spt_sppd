import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class SptPage extends StatefulWidget {
  const SptPage({super.key});

  @override
  State<SptPage> createState() => _SptPageState();
}

class _SptPageState extends State<SptPage> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('spt');

  List dataSpt = [];

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    dataSpt = querySnapshot.docs.map((doc) => doc.data()).toList();

    // users = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(dataSpt[0]['id_users'])
    //     .get();
    // print(geta.get('nama'));

    // var getNama = await FirebaseFirestore.instance
    //     .collection('users')
    //     .where(FieldPath.documentId, whereIn: dataSpt[0]['id_users'])
    //     .get();
    // print(getNama);
    print(dataSpt[0]['id_users']);
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          children: [
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('spt').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30, left: 1),
                        child: DataTable(
                            border: TableBorder.all(),
                            columns: const [
                              DataColumn(label: Text('No')),
                              DataColumn(label: Text('No Surat')),
                              DataColumn(label: Text('Nama')),
                              DataColumn(label: Text('Maksud Tujuan')),
                              DataColumn(label: Text('Tempat Tujuan')),
                              DataColumn(label: Text('Tanggal')),
                            ],
                            rows: List<DataRow>.generate(
                                snapshot.data!.docs.length, (index) {
                              int no = index + 1;
                              return DataRow(cells: [
                                DataCell(Text(no.toString())),
                                DataCell(
                                    Text(snapshot.data!.docs[index]['no_spt'])),
                                DataCell(
                                    Text(snapshot.data!.docs[index]['nama'])),
                                DataCell(Text(snapshot.data!.docs[index]
                                    ['maksud_tujuan'])),
                                DataCell(Text(snapshot.data!.docs[index]
                                    ['tempat_tujuan'])),
                                DataCell(Text(formatDate(
                                    snapshot.data!.docs[index]['tanggal']))),
                              ]);
                            })),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    ));
  }

  String formatDate(date) {
    return DateFormat(
      'EEEE, d MMM yyyy',
      'id',
    ).format(date.toDate());
  }
}
