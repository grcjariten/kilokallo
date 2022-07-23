import 'package:flutter/material.dart';

void main() {
  runApp(
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "TDEE Calculator",
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          toolbarHeight: 80,
          title: const Text("KILOkallo"),
          centerTitle: true,
          actions: [
            metricImperial(),
              ],
            ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(19,17,16,19),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(6))
            ),

            height: 500, //TODO: Mettere altezza e larghezza in relazione allo schermo
            width: 400,
            child:
                Padding(
                  padding: const EdgeInsets.fromLTRB(18,10,0,0),
                  child:
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              fieldText("Gender",18),
                              fieldText("Age" , 10),
                              fieldText("Weight" , 32),
                              fieldText("Height" , 10),
                              fieldText("Activity" , 31),
                              fieldText("BodyFat\n(Opt.)" , 7),
                              fieldText("Goal" , 26),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Switch(value: false, onChanged: null),
                                    Text("Man")
                                  ],
                                ),
                                fieldBox(60, "", null),
                                fieldBox(60, "Kg", null),
                                fieldBox(60, "cm", null),
                                fieldBox(150, "Sedentary", null),
                                fieldBox(60, "15%", null),
                                goals(),
                                calculateButton()
                              ],
                            ),
                          ),
                        ],
                      ),


                ),




          ),
        ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.blueGrey,
        child: const Center(child: Text("Banner Admob")),
      ),
    );
  }

  Column metricImperial() {
    return Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 13.0, 9, 0),
            child: Text("Metric/Imperial"),
          ),
          Switch(value: false, onChanged: null)
        ]
    );

  }

  Padding fieldText(String text, double padding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, padding, 0, padding),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold),),
    );
  }

  Padding fieldBox(double width, String labelText, function) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
              width: width,
              height: 43,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: labelText,
                ),
            ),

            ),

    );
  }

  Padding calculateButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey
          ),
          onPressed: () {}, child: const Text("Calculate")),
    );

  }

  ToggleButtons goals() {

    Padding choice(String text, IconData iconData, double left, double top, double right, double bottom) {
      return Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: Column(
          children: [
            Text(text),
            Icon(iconData, color: Colors.blueGrey,)
          ],
        ),
      );
    }

    return ToggleButtons(
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(70),
      borderColor: Colors.black,
      isSelected: const [true, true, true],
      children: [
            choice("Maintain", Icons.accessibility, 20,10,10,10),
            choice(" Lose ", Icons.arrow_downward, 18,10,18,10),
            choice(" Gain  ", Icons.arrow_upward, 10,10,25,10)
          ],

    );

  }

}
