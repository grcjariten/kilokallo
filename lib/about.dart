import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: const Text("About"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\u2022"" TDEE is calculated using the original Harris-Benedict equation.", style: boldStyle(),),
              const Divider(),
              Text("Formula for men", style: boldStyle(),),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Metric : BMR = 66.5 + ( 13.76 × weight in kg ) + ( 5.003 × height in cm ) – ( 6.755 × age in years ) "),
                    Text("Imperial: BMR = 66 + ( 6.2 × weight in pounds ) + ( 12.7 × height in inches ) – ( 6.76 × age in years )"),
                  ],
                ),
              ),

              const Divider(),
              Text("Formula for women", style: boldStyle(),),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: const [
                    Text("Metric: BMR = 655 + ( 9.563 × weight in kg ) + ( 1.850 × height in cm ) – ( 4.676 × age in years ) "),
                    Text("Imperial: BMR = 655 + ( 4.35 × weight in pounds ) + ( 4.7 × height in inches ) - ( 4.7 × age in years )"),
                  ],
                ),
              ),

              const Divider(),
              Text("\u2022"" When you fill out the body fat percentage field, TDEE is calculated using the Katch-McArdle Formula:", style: boldStyle(),),
              const Divider(),
              const Text("Katch = 370 + (21.6 * LBM)"),
              const Divider(),
              Text("\u2022 Ideal Weight is calculated using the Lorenz Formula:", style: boldStyle(),),
              const Divider(),
              const Text("Men: height in cm – 100 - (height in cm – 150)/4"),
              const Text("Women: height in cm – 100 - (height in cm – 150)/2"),
              const Divider(),
              const Text("The main app icon has been designed using resources from Flaticon.com")
            ],
          ),
        ),
      ),
    );
  }

  TextStyle boldStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold
    );
  }

}
