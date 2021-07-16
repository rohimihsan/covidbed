import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: 100,
                  width: 100,
                  image: AssetImage('images/logo.png')),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              child: Text(
            "Semoga aplikasi ini dapat bermanfaat untuk yang membutuhkan. Doa terbaik untuk kita semua yang sedang berjuang dalam keadaan ini. Stay safe dan jalankan protokol kesehatan semaksimal mungkin.",
            textAlign: TextAlign.center,
          )),
          SizedBox(
            height: 10,
          ),
          InkWell(
              child: new Text(
                'Thanks to Agallio Samai',
                style: TextStyle(
                  color: Colors.purple,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () => launch('https://github.com/agallio')),
          Text("For providing API used within this app")
        ],
      ),
    );
  }
}
