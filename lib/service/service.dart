import 'dart:convert';

import 'package:covidbed/model/rs_bed.dart';
import 'package:http/http.dart' as http;

class ProvinceService {
  static final List<String> provinces = [
    "Aceh",
    "Sumatera Utara",
    "Sumatera Barat",
    "Riau",
    "Jambi",
    "Sumatera Selatan",
    "Bengkulu",
    "Lampung",
    "Kepulauan Bangka Belitung",
    "Kepulauan Riau",
    "Jakarta",
    "Jawa Barat",
    "Jawa Tengah",
    "Yogyakarta",
    "Jawa Timur",
    "Banten",
    "Bali",
    "Nusa Tenggara Barat",
    "Nusa Tenggara Timur",
    "Kalimantan Barat",
    "Kalimantan Tengah",
    "Kalimantan Selatan",
    "Kalimantan Timur",
    "Kalimantan Utara",
    "Sulawesi Utara",
    "Sulawesi Tengah",
    "Sulawesi Selatan",
    "Sulawesi Tenggara",
    "Gorontalo",
    "Sulawesi Barat",
    "Maluku",
    "Maluku Utara",
    "Papua Barat",
    "Papua"
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(provinces);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static bool searchProvince(String query) {
    List<String> matches = <String>[];
    matches.addAll(provinces);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches.isEmpty ? false : true;
  }
}

class BedService {
  static Future<dynamic> getBedList(String query) async {
    List<RSbed> beds = [];

    final response = await http.get(
        Uri.parse(
            'https://ina-covid-bed.vercel.app/api/bed?prov=$query&revalidate=false'),
        headers: {"Access-Control-Allow-Origin": "*"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List bed = data['data'];
      beds = bed.map((item) => RSbed.fromJson(item)).toList();
    }

    return beds;
  }
}
