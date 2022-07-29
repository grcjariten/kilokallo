import 'package:flutter/material.dart';

class OutputPage extends StatelessWidget {
  const OutputPage(
      {Key? key,
      required this.finalTdee,
      required this.tdee,
      required this.bmr,
      required this.bmi})
      : super(key: key);

  final double finalTdee;
  final double tdee;
  final double bmr;
  final double bmi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: const Text("Your results"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(84, 24, 84, 24),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("Your Maintenance Calories", style: titleStyle()),
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
                          Text("${finalTdee.truncate()}", style: numberStyle(),),
                          Text("calories per day", style: bodyStyle(),),
                          const Divider(color: Colors.white,thickness: 2,),
                          Text("${(finalTdee * 7).truncate()}", style: numberStyle(),),
                          Text("calories per week", style: bodyStyle(),),

            ],
          ),
                    ),
      ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Divider(color: Colors.blueGrey[800], thickness: 2,),
                    Text("To lose blabla, based on FORMULA ${(finalTdee).truncate()}"),
                    Text("tdee is ${(tdee).truncate()}"),
                    Text("basic blabl rate is ${(bmr).truncate()}"),
                    Text("bmi score, your normal weight is [...] is ${(bmi).truncate()}"),
                  ],
                ),
              )
    ]),
        )));
  }

  TextStyle titleStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18
    );
  }

  TextStyle bodyStyle() {
    return const TextStyle(

        color: Colors.white,
        fontSize: 15
    );
  }
  TextStyle numberStyle() {
    return const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 35
    );
  }
}
