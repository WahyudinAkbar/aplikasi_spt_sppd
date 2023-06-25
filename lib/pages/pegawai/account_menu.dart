import 'package:aplikasi_kepegawaian/pages/pegawai/change_email.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/change_password.dart';
import 'package:aplikasi_kepegawaian/pages/pegawai/edit_pegawai_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountMenu extends StatefulWidget {
  final String username;
  final String nama;
  final String nip;
  final String pangkat;
  final String jabatan;
  final String bidang;
  final String email;
  final String password;
  final String idPegawai;

  const AccountMenu({
    super.key,
    required this.username,
    required this.nama,
    required this.nip,
    required this.pangkat,
    required this.jabatan,
    required this.bidang,
    required this.email,
    required this.password,
    required this.idPegawai,
  });

  @override
  State<AccountMenu> createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {
  String replace = '';
  @override
  void initState() {
    super.initState();
    int length = widget.email.length - 3;
    replace = '*' * length;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdddddd),
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPegawaiPage(
                            title: "Edit Profil",
                            username: widget.username,
                            nama: widget.nama,
                            nip: widget.nip,
                            pangkat: widget.pangkat,
                            jabatan: widget.jabatan,
                            bidang: widget.bidang,
                          ),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profil',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(widget.nama,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 7,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeEmail(
                            email: widget.email,
                            password: widget.password,
                            idPegawai: widget.idPegawai,
                          ),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ganti Email',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(widget.email.replaceRange(3, null, replace),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 7,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePassword(
                            email: widget.email,
                            password: widget.password,
                            idPegawai: widget.idPegawai,
                          ),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ganti Password',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
