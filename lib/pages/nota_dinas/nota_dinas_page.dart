// import 'package:aplikasi_kepegawaian/pages/nota_dinas/create_nota_dinas_page.dart';
// import 'package:aplikasi_kepegawaian/pages/nota_dinas/edit_nota_dinas_page.dart';
// import 'package:aplikasi_kepegawaian/pages/nota_dinas/laporan_nota_dinas.dart';
// import 'package:aplikasi_kepegawaian/pages/spt/create_spt_page.dart';
// import 'package:aplikasi_kepegawaian/pages/spt/edit_spt_page.dart';
// import 'package:aplikasi_kepegawaian/pages/spt/report_spt.dart';
// import 'package:aplikasi_kepegawaian/widget/drawer.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';

// class NotaDinasPage extends StatefulWidget {
//   const NotaDinasPage({super.key});

//   @override
//   State<NotaDinasPage> createState() => _NotaDinasPageState();
// }

// class _NotaDinasPageState extends State<NotaDinasPage> {
//   TextEditingController noSpt = TextEditingController();
//   TextEditingController noSppd = TextEditingController();

//   Stream? stream;
//   bool isAdmin = false;

//   @override
//   void initState() {
//     super.initState();
//     getNoSuratSpt();
//     getNoSuratSppd();
//     checkRoles();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const FaIcon(FontAwesomeIcons.bars),
//           iconSize: 30,
//           onPressed: () => scaffoldKey.currentState!.openDrawer(),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             top: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Text(
//                   "Nota Permintaan Perjalanan Dinas",
//                   style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               StreamBuilder(
//                   stream: stream,
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else {
//                       return SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 30, left: 20),
//                           child: DataTable(
//                               border: TableBorder.all(),
//                               columns: const [
//                                 DataColumn(label: Text('No')),
//                                 DataColumn(label: Text('No Surat')),
//                                 DataColumn(label: Text('Nama')),
//                                 DataColumn(label: Text('Perihal')),
//                                 DataColumn(label: Text('Dasar')),
//                                 DataColumn(label: Text('Maksud Tujuan')),
//                                 DataColumn(label: Text('Tempat Tujuan')),
//                                 DataColumn(label: Text('Tanggal Berangkat')),
//                                 DataColumn(label: Text('Tanggal Kembali')),
//                                 DataColumn(label: Text('Status')),
//                                 DataColumn(label: Text('Action')),
//                               ],
//                               rows: List<DataRow>.generate(
//                                   snapshot.data!.docs.length, (index) {
//                                 int no = index + 1;
//                                 return DataRow(cells: [
//                                   DataCell(Text(no.toString())),
//                                   DataCell(Text(
//                                       snapshot.data!.docs[index]['no_surat'])),
//                                   DataCell(
//                                       Text(snapshot.data!.docs[index]['nama'])),
//                                   DataCell(Container(
//                                     width: 300,
//                                     child: Text(
//                                       snapshot.data!.docs[index]['perihal'],
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 3,
//                                     ),
//                                   )),
//                                   DataCell(Container(
//                                     width: 300,
//                                     child: Text(
//                                       snapshot.data!.docs[index]['dasar'],
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 3,
//                                     ),
//                                   )),
//                                   DataCell(Container(
//                                     width: 300,
//                                     child: Text(
//                                       snapshot.data!.docs[index]
//                                           ['maksud_tujuan'],
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 3,
//                                     ),
//                                   )),
//                                   DataCell(Text(snapshot.data!.docs[index]
//                                       ['tempat_tujuan'])),
//                                   DataCell(Text(formatDate(snapshot.data!
//                                       .docs[index]['tanggal_berangkat']))),
//                                   DataCell(Text(formatDate(snapshot
//                                       .data!.docs[index]['tanggal_kembali']))),
//                                   DataCell(
//                                     Text(
//                                       snapshot.data!.docs[index]['verifikasi']
//                                           ? 'Verified'
//                                           : 'Belum Verifikasi',
//                                     ),
//                                   ),
//                                   DataCell(Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       ElevatedButton(
//                                         child: Text(
//                                           "Edit",
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                         style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.yellow),
//                                         onPressed: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     EditNotaDinasPage(
//                                                   idSuratTugas: snapshot
//                                                       .data!.docs[index].id,
//                                                   noSurat: snapshot.data!
//                                                       .docs[index]['no_surat'],
//                                                   pegawai: snapshot.data!
//                                                       .docs[index]['nama'],
//                                                   tempatTujuan:
//                                                       snapshot.data!.docs[index]
//                                                           ['tempat_tujuan'],
//                                                   maksudTujuan:
//                                                       snapshot.data!.docs[index]
//                                                           ['maksud_tujuan'],
//                                                   perihal: snapshot.data!
//                                                       .docs[index]['perihal'],
//                                                   dasar: snapshot.data!
//                                                       .docs[index]['dasar'],
//                                                   tanggalBerangkat: snapshot
//                                                       .data!
//                                                       .docs[index]
//                                                           ['tanggal_berangkat']
//                                                       .toDate(),
//                                                   tanggalKembali: snapshot
//                                                       .data!
//                                                       .docs[index]
//                                                           ['tanggal_kembali']
//                                                       .toDate(),
//                                                 ),
//                                               ));
//                                         },
//                                       ),
//                                       const SizedBox(
//                                         width: 8,
//                                       ),
//                                       ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.red),
//                                         child: const Text(
//                                           "Hapus",
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                         onPressed: () {
//                                           showAlertHapus(context,
//                                               snapshot.data!.docs[index].id);
//                                         },
//                                       ),
//                                       const SizedBox(
//                                         width: 8,
//                                       ),
//                                       snapshot.data!.docs[index]['verifikasi']
//                                           ? ElevatedButton(
//                                               child: const Text(
//                                                 "Cetak",
//                                                 style: TextStyle(
//                                                     color: Colors.black),
//                                               ),
//                                               onPressed: () {
//                                                 laporanNotaDinas(
//                                                   snapshot.data!.docs[index]
//                                                       ['no_surat'],
//                                                   snapshot.data!.docs[index]
//                                                       ['nama'],
//                                                   snapshot.data!.docs[index]
//                                                       ['perihal'],
//                                                   snapshot.data!.docs[index]
//                                                       ['dasar'],
//                                                   snapshot.data!.docs[index]
//                                                       ['maksud_tujuan'],
//                                                   snapshot.data!.docs[index]
//                                                       ['tempat_tujuan'],
//                                                   snapshot.data!.docs[index]
//                                                       ['maksud_tujuan'],
//                                                   formatDate(snapshot
//                                                               .data!.docs[index]
//                                                           ['tanggal_berangkat'])
//                                                       .toString(),
//                                                   formatDate(snapshot
//                                                               .data!.docs[index]
//                                                           ['tanggal_kembali'])
//                                                       .toString(),
//                                                   hitungHari(
//                                                       snapshot.data!.docs[index]
//                                                           ['tanggal_kembali'],
//                                                       snapshot.data!.docs[index]
//                                                           [
//                                                           'tanggal_berangkat']),
//                                                   formatDate(snapshot
//                                                               .data!.docs[index]
//                                                           ['send_time'])
//                                                       .toString(),
//                                                 );
//                                               },
//                                             )
//                                           : const SizedBox.shrink(),
//                                       const SizedBox(
//                                         width: 8,
//                                       ),
//                                       isAdmin
//                                           ? snapshot.data!.docs[index]
//                                                   ['verifikasi']
//                                               ? const SizedBox.shrink()
//                                               : ElevatedButton(
//                                                   style:
//                                                       ElevatedButton.styleFrom(
//                                                           backgroundColor:
//                                                               Colors
//                                                                   .greenAccent),
//                                                   onPressed: () async {
//                                                     showAlertVerifikasi(
//                                                         context,
//                                                         snapshot.data!
//                                                             .docs[index].id,
//                                                         snapshot.data!
//                                                                 .docs[index]
//                                                             ['nama'],
//                                                         snapshot.data!
//                                                                 .docs[index]
//                                                             ['maksud_tujuan'],
//                                                         snapshot.data!
//                                                                 .docs[index]
//                                                             ['tempat_tujuan'],
//                                                         snapshot.data!
//                                                                 .docs[index][
//                                                             'tanggal_berangkat'],
//                                                         snapshot.data!
//                                                                 .docs[index]
//                                                             ['tanggal_kembali'],
//                                                         snapshot.data!
//                                                                 .docs[index]
//                                                             ['userId']);
//                                                   },
//                                                   child: const Text(
//                                                     "Verifikasi",
//                                                     style: TextStyle(
//                                                         color: Colors.black),
//                                                   ),
//                                                 )
//                                           : const SizedBox.shrink(),
//                                     ],
//                                   )),
//                                 ]);
//                               })),
//                         ),
//                       );
//                     }
//                   }),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border(top: BorderSide(color: Colors.grey)),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.grey.shade500,
//                             offset: Offset(0, -1),
//                             blurRadius: 7,
//                             spreadRadius: 1)
//                       ],
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     height: 60,
//                     child: ElevatedButton(
//                       child: const Text("Ajukan Surat Perjalanan Dinas"),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const CreateNotaDinasPage(),
//                             ));
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       drawer: const MyDrawer(
//         id: '2',
//       ),
//     );
//   }

//   void checkRoles() async {
//     var uid = FirebaseAuth.instance.currentUser?.uid;
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get()
//         .then((value) {
//       if (value.get('roles') == 'admin') {
//         setState(() {
//           stream = FirebaseFirestore.instance
//               .collection('nota_dinas')
//               .orderBy('send_time')
//               .snapshots();
//           isAdmin = true;
//         });
//       } else {
//         setState(() {
//           stream = FirebaseFirestore.instance
//               .collection('nota_dinas')
//               .where('userId', isEqualTo: uid)
//               .snapshots();
//           isAdmin = false;
//         });
//       }
//     });
//   }

//   void getNoSuratSpt() async {
//     var snap = await FirebaseFirestore.instance
//         .collection('spt')
//         .orderBy('send_time', descending: true)
//         .limit(1)
//         .get();

//     if (snap.docs.isNotEmpty) {
//       String data = snap.docs[0]["no_spt"];
//       data = data.substring(4, 7);
//       int noSurat = int.parse(data);
//       noSurat += 1;
//       data = noSurat.toString().padLeft(3, '0');
//       noSpt.text = "870/$data-KIP/Diskominfo";
//     } else {
//       noSpt.text = "870/001-KIP/Diskominfo";
//     }
//   }

//   Future getNoSuratSppd() async {
//     var snap = await FirebaseFirestore.instance
//         .collection('sppd')
//         .orderBy('send_time', descending: true)
//         .limit(1)
//         .get();

//     if (snap.docs.isNotEmpty) {
//       String data = snap.docs[0]["no_sppd"];
//       data = data.substring(4, 7);
//       int noSurat = int.parse(data);
//       noSurat += 1;
//       data = noSurat.toString().padLeft(3, '0');
//       noSppd.text = "090/$data-LD/DisKominfo";
//     } else {
//       noSppd.text = "090/001-LD/DisKominfo";
//     }
//   }

//   Future<void> buatSptSppd(
//     id,
//     nama,
//     maksudTujuan,
//     tempatTujuan,
//     tglBerangkat,
//     tglKembali,
//     userId,
//   ) async {
//     try {
//       await FirebaseFirestore.instance.collection('spt').add({
//         'no_spt': noSpt.text,
//         'nama': nama,
//         'maksud_tujuan': maksudTujuan,
//         'tempat_tujuan': tempatTujuan,
//         'alat_transportasi': 'Mobil Dinas',
//         'tanggal_berangkat': tglBerangkat,
//         'tanggal_kembali': tglKembali,
//         'userId': userId,
//         'send_time': DateTime.now(),
//       });
//       await FirebaseFirestore.instance.collection('sppd').add({
//         'no_sppd': noSppd.text,
//         'nama': nama,
//         'maksud_tujuan': maksudTujuan,
//         'tempat_tujuan': tempatTujuan,
//         'alat_transportasi': 'Mobil Dinas',
//         'tanggal_berangkat': tglBerangkat,
//         'tanggal_kembali': tglKembali,
//         'keterangan_lain': "",
//         'userId': userId,
//         'send_time': DateTime.now(),
//       });
//       await FirebaseFirestore.instance.collection('nota_dinas').doc(id).update(
//         {'verifikasi': true},
//       );
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   showAlertHapus(BuildContext context, id) {
//     Widget cancelButton = TextButton(
//       child: const Text("Batal"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     Widget continueButton = TextButton(
//       child: const Text(
//         "Hapus",
//         style: TextStyle(color: Colors.redAccent),
//       ),
//       onPressed: () {
//         deleteData(id);
//         Navigator.of(context).pop();
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: const Text("Hapus Data Ini?"),
//       content: const Text(
//           "Yakin ingin menghapus data ini? Data akan dihapus secara permanen"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   showAlertVerifikasi(
//     BuildContext context,
//     id,
//     nama,
//     maksudTujuan,
//     tempatTujuan,
//     tglBerangkat,
//     tglKembali,
//     userId,
//   ) {
//     Widget cancelButton = TextButton(
//       child: const Text("Batal"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     Widget continueButton = TextButton(
//       child: const Text(
//         "Verifikasi",
//         style: TextStyle(color: Colors.green),
//       ),
//       onPressed: () {
//         buatSptSppd(
//           id,
//           nama,
//           maksudTujuan,
//           tempatTujuan,
//           tglBerangkat,
//           tglKembali,
//           userId,
//         );
//         Navigator.of(context).pop();
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: const Text("Verifikasi Data Ini?"),
//       content: const Text("Verifikasi data ini?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   String hitungHari(tglKembali, tglBerangkat) {
//     tglKembali = tglKembali.toDate();
//     tglBerangkat = tglBerangkat.toDate();
//     var hari = tglKembali.difference(tglBerangkat).inDays + 1;

//     return hari.toString();
//   }

//   void deleteData(id) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('nota_dinas')
//           .doc(id)
//           .delete();

//       Fluttertoast.showToast(
//           msg: "Data Berhasil Dihapus",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 3,
//           backgroundColor: Colors.blue,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     } catch (e) {
//       print(e);
//     }
//   }

//   String formatDate(date) {
//     return DateFormat(
//       'd MMMM yyyy',
//       'id',
//     ).format(date.toDate());
//   }
// }

// // class MyData extends DataTableSource {
// //   MyData(this.data, this.context);

// //   final BuildContext context;
// //   final List<dynamic> data;

// //   final NotaDinasPage nota = const NotaDinasPage();

// //   @override
// //   bool get isRowCountApproximate => false;
// //   @override
// //   int get rowCount => data.length;
// //   @override
// //   int get selectedRowCount => 0;
// //   @override
// //   DataRow getRow(int index) {
// //     print(data[0].data());
// //     return DataRow(cells: [
// //       DataCell(Text('${index + 1}')),
// //       DataCell(Text(data[index].data()["no_surat"])),
// //       DataCell(Text(data[index].data()["nama"])),
// //       DataCell(Text(data[index].data()["perihal"])),
// //       DataCell(Text(data[index].data()["dasar"])),
// //       DataCell(Text(data[index].data()["maksud_tujuan"])),
// //       DataCell(Text(data[index].data()["tempat_tujuan"])),
// //       DataCell(Text(formatDate(data[index].data()["tanggal_berangkat"]))),
// //       DataCell(Text(formatDate(data[index].data()["tanggal_kembali"]))),
// //       DataCell(
// //         Text(
// //           data[index].data()["verifikasi"] ? 'Verified' : 'Belum Verifikasi',
// //         ),
// //       ),
// //       DataCell(Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //         children: [
// //           ElevatedButton(
// //             child: const Text(
// //               "Edit",
// //               style: TextStyle(color: Colors.black),
// //             ),
// //             style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
// //             onPressed: () {
// //               Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => EditNotaDinasPage(
// //                       idSuratTugas: data[index].reference.id,
// //                       noSurat: data[index].data()["no_surat"],
// //                       pegawai: data[index].data()['nama'],
// //                       tempatTujuan: data[index].data()['tempat_tujuan'],
// //                       maksudTujuan: data[index].data()['maksud_tujuan'],
// //                       perihal: data[index].data()['perihal'],
// //                       dasar: data[index].data()['dasar'],
// //                       tanggalBerangkat:
// //                           data[index].data()['tanggal_berangkat'].toDate(),
// //                       tanggalKembali:
// //                           data[index].data()['tanggal_kembali'].toDate(),
// //                     ),
// //                   ));
// //             },
// //           ),
// //           const SizedBox(
// //             width: 8,
// //           ),
// //           ElevatedButton(
// //             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
// //             child: const Text(
// //               "Hapus",
// //               style: TextStyle(color: Colors.black),
// //             ),
// //             onPressed: () {
// //               showAlertHapus(
// //                 context,
// //                 data[index].reference.id,
// //               );
// //             },
// //           ),
// //           const SizedBox(
// //             width: 8,
// //           ),
// //           ElevatedButton(
// //             child: const Text(
// //               "Cetak",
// //               style: TextStyle(color: Colors.black),
// //             ),
// //             onPressed: () {
// //               laporanNotaDinas(
// //                 data[index].data()['no_surat'],
// //                 data[index].data()['nama'],
// //                 data[index].data()['maksud_tujuan'],
// //                 data[index].data()['perihal'],
// //                 data[index].data()['dasar'],
// //                 data[index].data()['tempat_tujuan'],
// //                 data[index].data()['tempat_tujuan'],
// //                 formatDate(data[index].data()['tanggal_berangkat']).toString(),
// //                 formatDate(data[index].data()['tanggal_kembali']).toString(),
// //                 hitungHari(data[index].data()['tanggal_kembali'],
// //                     data[index].data()['tanggal_berangkat']),
// //                 formatDate(data[index].data()['send_time']).toString(),
// //               );
// //             },
// //           ),
// //           const SizedBox(
// //             width: 8,
// //           ),
// //           data[index].data()['verifikasi']
// //               ? const SizedBox.shrink()
// //               : ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.greenAccent),
// //                   onPressed: () async {
// //                     showAlertVerifikasi(
// //                         context,
// //                         data[index].reference.id,
// //                         data[index].data()['nama'],
// //                         data[index].data()['maksud_tujuan'],
// //                         data[index].data()['tempat_tujuan'],
// //                         data[index].data()['tanggal_berangkat'],
// //                         data[index].data()['tanggal_kembali'],
// //                         data[index].data()['userId']);
// //                   },
// //                   child: const Text(
// //                     "Verifikasi",
// //                     style: TextStyle(color: Colors.black),
// //                   ),
// //                 )
// //         ],
// //       )),
// //     ]);
// //   }
// // }

// //  StreamBuilder(
// //                   stream: stream,
// //                   builder: (context, snapshot) {
// //                     if (!snapshot.hasData) {
// //                       return const Center(child: Text('Belum ada data'));
// //                     } else {
// //                       return SingleChildScrollView(
// //                         scrollDirection: Axis.horizontal,
// //                         child: Padding(
// //                           padding: const EdgeInsets.only(right: 30, left: 20),
// //                           child: DataTable(
// //                               border: TableBorder.all(),
// //                               columns: const [
// //                                 DataColumn(label: Text('No')),
// //                                 DataColumn(label: Text('No Surat')),
// //                                 DataColumn(label: Text('Nama')),
// //                                 DataColumn(label: Text('Perihal')),
// //                                 DataColumn(label: Text('Dasar')),
// //                                 DataColumn(label: Text('Maksud Tujuan')),
// //                                 DataColumn(label: Text('Tempat Tujuan')),
// //                                 DataColumn(label: Text('Tanggal Berangkat')),
// //                                 DataColumn(label: Text('Tanggal Kembali')),
// //                                 DataColumn(label: Text('Status')),
// //                                 DataColumn(label: Text('Action')),
// //                               ],
// //                               rows: List<DataRow>.generate(
// //                                   snapshot.data!.docs.length, (index) {
// //                                 int no = index + 1;
// //                                 return DataRow(cells: [
// //                                   DataCell(Text(no.toString())),
// //                                   DataCell(Text(
// //                                       snapshot.data!.docs[index]['no_surat'])),
// //                                   DataCell(
// //                                       Text(snapshot.data!.docs[index]['nama'])),
// //                                   DataCell(Container(
// //                                     width: 300,
// //                                     child: Text(
// //                                       snapshot.data!.docs[index]['perihal'],
// //                                       overflow: TextOverflow.ellipsis,
// //                                       maxLines: 3,
// //                                     ),
// //                                   )),
// //                                   DataCell(Container(
// //                                     width: 300,
// //                                     child: Text(
// //                                       snapshot.data!.docs[index]['dasar'],
// //                                       overflow: TextOverflow.ellipsis,
// //                                       maxLines: 3,
// //                                     ),
// //                                   )),
// //                                   DataCell(Container(
// //                                     width: 300,
// //                                     child: Text(
// //                                       snapshot.data!.docs[index]
// //                                           ['maksud_tujuan'],
// //                                       overflow: TextOverflow.ellipsis,
// //                                       maxLines: 3,
// //                                     ),
// //                                   )),
// //                                   DataCell(Text(snapshot.data!.docs[index]
// //                                       ['tempat_tujuan'])),
// //                                   DataCell(Text(formatDate(snapshot.data!
// //                                       .docs[index]['tanggal_berangkat']))),
// //                                   DataCell(Text(formatDate(snapshot
// //                                       .data!.docs[index]['tanggal_kembali']))),
// //                                   DataCell(
// //                                     Text(
// //                                       snapshot.data!.docs[index]['verifikasi']
// //                                           ? 'Verified'
// //                                           : 'Belum Verifikasi',
// //                                     ),
// //                                   ),
// //                                   DataCell(Row(
// //                                     mainAxisAlignment:
// //                                         MainAxisAlignment.spaceAround,
// //                                     children: [
// //                                       ElevatedButton(
// //                                         child: Text(
// //                                           "Edit",
// //                                           style: TextStyle(color: Colors.black),
// //                                         ),
// //                                         style: ElevatedButton.styleFrom(
// //                                             backgroundColor: Colors.yellow),
// //                                         onPressed: () {
// //                                           Navigator.push(
// //                                               context,
// //                                               MaterialPageRoute(
// //                                                 builder: (context) =>
// //                                                     EditNotaDinasPage(
// //                                                   idSuratTugas: snapshot
// //                                                       .data!.docs[index].id,
// //                                                   noSurat: snapshot.data!
// //                                                       .docs[index]['no_surat'],
// //                                                   pegawai: snapshot.data!
// //                                                       .docs[index]['nama'],
// //                                                   tempatTujuan:
// //                                                       snapshot.data!.docs[index]
// //                                                           ['tempat_tujuan'],
// //                                                   maksudTujuan:
// //                                                       snapshot.data!.docs[index]
// //                                                           ['maksud_tujuan'],
// //                                                   perihal: snapshot.data!
// //                                                       .docs[index]['perihal'],
// //                                                   dasar: snapshot.data!
// //                                                       .docs[index]['dasar'],
// //                                                   tanggalBerangkat: snapshot
// //                                                       .data!
// //                                                       .docs[index]
// //                                                           ['tanggal_berangkat']
// //                                                       .toDate(),
// //                                                   tanggalKembali: snapshot
// //                                                       .data!
// //                                                       .docs[index]
// //                                                           ['tanggal_kembali']
// //                                                       .toDate(),
// //                                                 ),
// //                                               ));
// //                                         },
// //                                       ),
// //                                       const SizedBox(
// //                                         width: 8,
// //                                       ),
// //                                       ElevatedButton(
// //                                         style: ElevatedButton.styleFrom(
// //                                             backgroundColor: Colors.red),
// //                                         child: const Text(
// //                                           "Hapus",
// //                                           style: TextStyle(color: Colors.black),
// //                                         ),
// //                                         onPressed: () {
// //                                           showAlertHapus(context,
// //                                               snapshot.data!.docs[index].id);
// //                                         },
// //                                       ),
// //                                       const SizedBox(
// //                                         width: 8,
// //                                       ),
// //                                       ElevatedButton(
// //                                         child: const Text(
// //                                           "Cetak",
// //                                           style: TextStyle(color: Colors.black),
// //                                         ),
// //                                         onPressed: () {
// //                                           laporanNotaDinas(
// //                                             snapshot.data!.docs[index]
// //                                                 ['no_surat'],
// //                                             snapshot.data!.docs[index]['nama'],
// //                                             snapshot.data!.docs[index]
// //                                                 ['maksud_tujuan'],
// //                                             snapshot.data!.docs[index]
// //                                                 ['perihal'],
// //                                             snapshot.data!.docs[index]['dasar'],
// //                                             snapshot.data!.docs[index]
// //                                                 ['tempat_tujuan'],
// //                                             snapshot.data!.docs[index]
// //                                                 ['tempat_tujuan'],
// //                                             formatDate(
// //                                                     snapshot.data!.docs[index]
// //                                                         ['tanggal_berangkat'])
// //                                                 .toString(),
// //                                             formatDate(
// //                                                     snapshot.data!.docs[index]
// //                                                         ['tanggal_kembali'])
// //                                                 .toString(),
// //                                             hitungHari(
// //                                                 snapshot.data!.docs[index]
// //                                                     ['tanggal_kembali'],
// //                                                 snapshot.data!.docs[index]
// //                                                     ['tanggal_berangkat']),
// //                                             formatDate(snapshot.data!
// //                                                     .docs[index]['send_time'])
// //                                                 .toString(),
// //                                           );
// //                                         },
// //                                       ),
// //                                       const SizedBox(
// //                                         width: 8,
// //                                       ),
// //                                       snapshot.data!.docs[index]['verifikasi']
// //                                           ? const SizedBox.shrink()
// //                                           : ElevatedButton(
// //                                               style: ElevatedButton.styleFrom(
// //                                                   backgroundColor:
// //                                                       Colors.greenAccent),
// //                                               onPressed: () async {
// //                                                 showAlertVerifikasi(
// //                                                     context,
// //                                                     snapshot
// //                                                         .data!.docs[index].id,
// //                                                     snapshot.data!.docs[index]
// //                                                         ['nama'],
// //                                                     snapshot.data!.docs[index]
// //                                                         ['maksud_tujuan'],
// //                                                     snapshot.data!.docs[index]
// //                                                         ['tempat_tujuan'],
// //                                                     snapshot.data!.docs[index]
// //                                                         ['tanggal_berangkat'],
// //                                                     snapshot.data!.docs[index]
// //                                                         ['tanggal_kembali'],
// //                                                     snapshot.data!.docs[index]
// //                                                         ['userId']);
// //                                               },
// //                                               child: const Text(
// //                                                 "Verifikasi",
// //                                                 style: TextStyle(
// //                                                     color: Colors.black),
// //                                               ),
// //                                             )
// //                                     ],
// //                                   )),
// //                                 ]);
// //                               })),
// //                         ),
// //                       );
// //                     }
// //                   }),
