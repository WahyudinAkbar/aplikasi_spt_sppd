import 'package:aplikasi_kepegawaian/constant.dart';
import 'package:aplikasi_kepegawaian/pages/homepage/home_page.dart';
import 'package:aplikasi_kepegawaian/pages/homepage/home_page_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ProfilePage extends StatefulWidget {
  final String email;
  final String password;
  const ProfilePage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();

  String? selectedValuePangkat;
  String? selectedValueBidang;

  List golongan = [];
  List bidang = [];

  void getGolongan() async {
    await FirebaseFirestore.instance
        .collection('golongan')
        .orderBy('nama_golongan', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var document in querySnapshot.docs) {
        setState(() {
          golongan.add(document['nama_golongan']);
        });
      }
    });
  }

  void getBidang() async {
    await FirebaseFirestore.instance
        .collection('bidang')
        .orderBy('nama_bidang', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var document in querySnapshot.docs) {
        setState(() {
          bidang.add(document['nama_bidang']);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getGolongan();
    getBidang();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        "Lengkapi Profil",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Username",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 3),
                      decoration: BoxDecoration(
                          color: const Color(0xffEBECF0),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        onTap: () {},
                        controller: usernameController,
                        cursorColor: Colors.black,
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                            hintText: "Username",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.shade700)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Nama",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 3),
                      decoration: BoxDecoration(
                          color: const Color(0xffEBECF0),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        onTap: () {},
                        controller: namaController,
                        cursorColor: Colors.black,
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                            hintText: "Nama",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.shade700)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "NIP",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 3),
                      decoration: BoxDecoration(
                          color: const Color(0xffEBECF0),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        onTap: () {},
                        controller: nipController,
                        maxLength: 16,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        cursorColor: Colors.black,
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                            hintText: "NIP",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.shade700)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Pangkat / Golongan",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    DropdownButtonFormField2(
                      value: selectedValuePangkat,
                      buttonDecoration: BoxDecoration(
                        color: const Color(0xffEBECF0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none, isDense: true),
                      hint: Text(
                        'Pilih Pangkat',
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 50,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: golongan
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih Pangkat';
                        }
                        return value.toString();
                      },
                      onChanged: (value) {
                        selectedValuePangkat = value.toString();
                      },
                      onSaved: (value) {
                        selectedValuePangkat = value.toString();
                      },
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Bidang",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    DropdownButtonFormField2(
                      value: selectedValueBidang,
                      buttonDecoration: BoxDecoration(
                        color: const Color(0xffEBECF0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none, isDense: true),
                      hint: Text(
                        'Pilih Bidang',
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 50,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: bidang
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih Bidang';
                        }
                        return value.toString();
                      },
                      onChanged: (value) {
                        selectedValueBidang = value.toString();
                      },
                      onSaved: (value) {
                        selectedValueBidang = value.toString();
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Jabatan",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, top: 3),
                      decoration: BoxDecoration(
                          color: const Color(0xffEBECF0),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        onTap: () {},
                        controller: jabatanController,
                        cursorColor: Colors.black,
                        style: const TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                            hintText: "Jabatan",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey.shade700)),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: const Border(top: BorderSide(color: Colors.grey)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(0, -1),
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                    child: const Text("Simpan"),
                    onPressed: () {
                      createPegawai();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createPegawai() async {
    try {
      final key = encrypt.Key.fromUtf8(secret);
      final iv = encrypt.IV.fromLength(16);

      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      final encrypted = encrypter.encrypt(widget.password, iv: iv);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: widget.email, password: encrypted.base64)
          .then((value) {
        var user = FirebaseAuth.instance.currentUser;
        print(user!.uid);
        FirebaseFirestore.instance.collection("users").doc(user.uid).set(
          {
            'email': widget.email,
            'username': usernameController.text,
            'password': encrypted.base64,
            'nama': namaController.text,
            'nip': nipController.text,
            'golongan': selectedValuePangkat,
            'bidang': selectedValueBidang,
            'jabatan': jabatanController.text,
            'roles': 'user'
          },
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePageUser(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(
            msg: "Email Telah Terdaftar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}

// void getPegawai() async {
//   await FirebaseFirestore.instance
//       .collection('users')
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     for (var document in querySnapshot.docs) {
//       setState(() {
//         listNama.add(document['nama']);
//       });
//     }
//   });
// }

// void getNoSurat() async {
//   var snap = await FirebaseFirestore.instance
//       .collection('spt')
//       .orderBy('sendTime', descending: true)
//       .limit(1)
//       .get();

//   String data = snap.docs[0]["no_spt"];
//   data = data.substring(4, 7);
//   int noSurat = int.parse(data);
//   noSurat += 1;
//   data = noSurat.toString().padLeft(3, '0');
//   noSuratController.text = "870/$data-KIP/Diskominfo";
// }

// // void tambahSuratTugas() async {
// //   try {
// //     await FirebaseFirestore.instance.collection('spt').add({
// //       'no_spt': noSuratController.text,
// //       'nama': selectedValuePegawai,
// //       'maksud_tujuan': maksudTujuanController.text,
// //       'tempat_tujuan': tempatTujuanController.text,
// //       'tanggal': selectedDate,
// //       'sendTime': DateTime.now(),
// //     });

// //     Fluttertoast.showToast(
// //         msg: "Data Berhasil Disimpan",
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.CENTER,
// //         timeInSecForIosWeb: 3,
// //         backgroundColor: Colors.blue,
// //         textColor: Colors.white,
// //         fontSize: 16.0);
// //   } catch (e) {
// //     debugPrint(e.toString());
// //   }


// Future<void> selectDate() async {
//   final DateTime? picked = await showDatePicker(
//       context: context,
//       locale: const Locale(
//         'id',
//       ),
//       initialDate: selectedDate,
//       firstDate: DateTime(2015, 8),
//       lastDate: DateTime(2101));
//   if (picked != null && picked != selectedDate) {
//     setState(() {
//       selectedDate = picked;
//       formattedDate = DateFormat(
//         'EEEE, d MMM yyyy',
//         'id',
//       ).format(selectedDate);

//       tanggalController.text = formattedDate.toString();
//     });
//   }
// }

