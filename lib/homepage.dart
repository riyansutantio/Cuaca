import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? wilayah;
  String _baseUrl = "https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json";
  String _uri = "https://ibnux.github.io/BMKG-importer/cuaca/501397.json";
  List<dynamic> _dataProvince = [];
  List<dynamic> _dataDetails = [];
  String? _valProvince;
  DateTime datetime = DateTime.now();

  Future<void> getProvince() async {
    final respose = await http
        .get(Uri.parse(_baseUrl), headers: {"Accept": "application/json"});
    var listData = jsonDecode(respose.body);
    print("data : $listData");
    setState(() {
      _dataProvince = listData;
    });
  }

  Future<void> getDetails() async {
    final respose = await http
        .get(Uri.parse(_uri), headers: {"Accept": "application/json"});
    var listData = jsonDecode(respose.body);
    print("data : $listData");
    setState(() {
      _dataDetails = listData;
    });
  }

  @override
  void initState() {
    super.initState();
    getProvince();
    getDetails();
    print(datetime.toString());
  }

  @override
  Widget build(BuildContext context) {
    bool _todaybool = true;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff695BFC), Color(0xfff6ebff)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cuaca Daerah",
              style: GoogleFonts.roboto(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  "Select Province",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                dropdownColor: Colors.black12,
                value: _valProvince,
                items: _dataProvince.map((item) {
                  return DropdownMenuItem(
                    child: Text(
                      item['propinsi'] +
                          " - " +
                          item['kota'] +
                          " - " +
                          item['kecamatan'],
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    value: item['id'],
                  );
                }).toList(),
                onChanged: (val) => setState(() {
                  Fluttertoast.showToast(
                      msg: "Data Changed",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white10,
                      textColor: Colors.blueAccent,
                      fontSize: 16.0);
                  _valProvince = val as String;
                  _uri =
                      "https://ibnux.github.io/BMKG-importer/cuaca/$_valProvince.json";
                  getDetails();
                }),
              ),
            ),
            // Text(
            //   datetime.toString(),
            //   style: GoogleFonts.roboto(fontSize: 15, color: Colors.white),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: _dataDetails.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 4,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                child: Text(
                                  _dataDetails[i]["tempC"] + "°",
                                  style: GoogleFonts.roboto(
                                      fontSize: 100, color: Colors.white),
                                ),
                              ),
                              Text(
                                _dataDetails[i]['jamCuaca'],
                                style: GoogleFonts.roboto(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: Text(
                                  _dataDetails[i]['cuaca'],
                                  style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const Image(
                                image: AssetImage("assets/images/0Cerah.png"),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.black,
                          endIndent: 10,
                          indent: 10,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
