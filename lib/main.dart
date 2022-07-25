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
      debugShowCheckedModeBanner: false,
      title: "TDEE Calculator",
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey[300],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[700],
          toolbarHeight: 80,
          title: const Text("TDEE Calculator"),
          centerTitle: true,
          actions: [
            metricImperial(),
              ],
            ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(17,12,17,0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(6))
                ),

                height: 540, //TODO: Mettere altezza e larghezza in relazione allo schermo
                width: 400,
                child:
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18,12,0,5),
                      child:
                          Form(
                            key: formKey,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    fieldText("Gender",17),
                                    fieldText("Age" , 13),
                                    fieldText("Weight" , 29),
                                    fieldText("Height" , 14),
                                    fieldText("Activity" , 25),
                                    fieldText("BodyFat\n(Opt.)" , 12),
                                    fieldText("Goal" , 33),
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
                                      fieldBox(60, "", null, false),
                                      fieldBox(60, "Kg", null, false),
                                      fieldBox(60, "cm", null, false),
                                      activityBox(),
                                      fieldBox(60, "15%", null, true),
                                      goals(),
                                      calculateButton(formKey)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),


                    ),




              ),
            ),
          ),

      bottomNavigationBar: Container(
        height: 70,
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

  Padding ageBox(double width, String labelText, function) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: width,
        height: 43,
        child: TextFormField(

          validator: (value) {
            if (value == null || value.isEmpty) {
                return 'Pleaseeeeeeeeeeeeeee';
            }
            return null;
          },
          obscureText: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
        ),

      ),

    );
  }

  Padding fieldBox(double width, String labelText, function, bool optional) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
              width: width,
              height: 43,
              child: TextFormField(

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    if(optional==false) {
                      return '* Required field';
                    }
                  }
                  return null;
                },
                obscureText: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: labelText,
                ),
            ),

            ),

    );
  }

  Padding calculateButton(GlobalKey<FormState> key) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey[700]
          ),
          onPressed: () {
            if(key.currentState!.validate()) {
              print("CIAO!");
            }

          }, child: const Text("Calculate")),
    );

  }

   Padding activityBox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: 170,
        child: DropdownButtonFormField(
            value: 0,
            items: const <DropdownMenuItem> [
          DropdownMenuItem(
              value: 0,
              child: Text("Sedentary")),
          DropdownMenuItem(
              value: 1,
              child: Text("Light Activity")),
          DropdownMenuItem(
              value: 2,
              child: Text("Moderate Activity")),
          DropdownMenuItem(
              value: 3,
              child: Text("High Activity")),
          DropdownMenuItem(
              value: 4,
              child: Text("Elite")),
        ]
            , onChanged: null
        ),
      ),
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
            choice("Maintain", Icons.accessibility, 20,10,10,10), //TODO: Rendili proporzionali alla larghezza schermo
            choice(" Lose ", Icons.arrow_downward, 18,10,18,10),
            choice(" Gain  ", Icons.arrow_upward, 10,10,25,10)
          ],

    );

  }

}
