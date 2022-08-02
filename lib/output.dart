import 'package:flutter/material.dart';
import 'package:tdeecalculator/about.dart';

class OutputPage extends StatelessWidget {
  const OutputPage(
      {Key? key,
      required this.finalTdee,
      required this.tdee,
      required this.bmr,
      required this.bmi,
      required this.idealWeight
      })
      : super(key: key);

  final double finalTdee;
  final double tdee;
  final double bmr;
  final double bmi;
  final double idealWeight;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: const Text("Your results"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        const InfoPage()
                    )
                );
              },
            )

        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(84, 24, 84, 24),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Your Target Calories", style: titleStyle()),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[700],
                          borderRadius: const BorderRadius.all(Radius.circular(6))),
                      child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("${finalTdee.truncate()}", style: headerNumbersStyle(),),
                                Text("calories per day", style: headerStyle(),),
                                const Divider(color: Colors.white,thickness: 2,),
                                Text("${(finalTdee * 7).truncate()}", style: headerNumbersStyle(),),
                                Text("calories per week", style: headerStyle(),),

                  ],
                ),
                          ),
          ),


    ]),
              ),
            )),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.blueGrey[800], thickness: 2,),
                Text("Your target calories (TDEE): ${(finalTdee).truncate()}", style: bodyStyle(),),
                Text("Your maintenance calories: ${(tdee).truncate()}", style: bodyStyle(),),
                Text("Basal Metabolic Rate (BMR): ${(bmr).truncate()}", style: bodyStyle(),),
                Text("Body Mass Index (BMI): ${(bmi).truncate()}", style: bodyStyle(),),
                Text("Your Ideal Body Weight: ${(idealWeight).truncate()}", style: bodyStyle(),)


              ],
            ),
          ),

        ],
      ));
  }

  TextStyle titleStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18
    );
  }

  TextStyle headerStyle() {
    return const TextStyle(

        color: Colors.white,
        fontSize: 15
    );
  }
  TextStyle headerNumbersStyle() {
    return const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 35
    );
  }

  TextStyle bodyStyle() {
    return const TextStyle(
        fontSize: 16
    );
  }
}
