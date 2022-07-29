import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
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

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? selectedActivity = "Sedentary";
  String? selectedGoal = "Maintain";
  String? selectedHeight = "5ft 1in";
  final formKey = GlobalKey<FormState>();
  bool female = false;
  bool imperial = false;
  double ageValue = 25;
  double weightValue = 70;
  double heightValue = 170;
  double bodyfatValue = 0;

  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bodyfatController = TextEditingController();

  List<DropdownMenuItem<String>> activities = const [
    DropdownMenuItem(value: "Sedentary", child: Text("Sedentary")),
    DropdownMenuItem(value: "Light", child: Text("Light Activity")),
    DropdownMenuItem(value: "Moderate", child: Text("Moderate Activity")),
    DropdownMenuItem(value: "High", child: Text("High Activity")),
    DropdownMenuItem(value: "Elite", child: Text("Elite"))
  ];

  List<DropdownMenuItem<String>> goals = const [
    DropdownMenuItem(value: "Maintain", child: Text("Maintain")),
    DropdownMenuItem(value: "Lose", child: Text("Lose")),
    DropdownMenuItem(value: "Gain", child: Text("Gain"))
  ];

  List<DropdownMenuItem<String>> imperialHeights = const [
    DropdownMenuItem(value: "4ft 7in", child: Text("4ft 7in")),
    DropdownMenuItem(value: "4ft 8in", child: Text("4ft 8in")),
    DropdownMenuItem(value: "4ft 9in", child: Text("4ft 9in")),
    DropdownMenuItem(value: "4ft 10in", child: Text("4ft 10in")),
    DropdownMenuItem(value: "4ft 11in", child: Text("4ft 11in")),
    DropdownMenuItem(value: "5ft 0in", child: Text("5ft 0in")),
    DropdownMenuItem(value: "5ft 1in", child: Text("5ft 1in")),
    DropdownMenuItem(value: "5ft 2in", child: Text("5ft 2in")),
    DropdownMenuItem(value: "5ft 3in", child: Text("5ft 3in")),
    DropdownMenuItem(value: "5ft 4in", child: Text("5ft 4in")),
    DropdownMenuItem(value: "5ft 5in", child: Text("5ft 5in")),
    DropdownMenuItem(value: "5ft 6in", child: Text("5ft 6in")),
    DropdownMenuItem(value: "5ft 7in", child: Text("5ft 7in")),
    DropdownMenuItem(value: "5ft 8in", child: Text("5ft 8in")),
    DropdownMenuItem(value: "5ft 9in", child: Text("5ft 9in")),
    DropdownMenuItem(value: "5ft 10in", child: Text("5ft 10in")),
    DropdownMenuItem(value: "5ft 11in", child: Text("5ft 11in")),
    DropdownMenuItem(value: "6ft 0in", child: Text("6ft 0in")),
    DropdownMenuItem(value: "6ft 1in", child: Text("6ft 1in")),
    DropdownMenuItem(value: "6ft 2in", child: Text("6ft 2in")),
    DropdownMenuItem(value: "6ft 3in", child: Text("6ft 3in")),
    DropdownMenuItem(value: "6ft 4in", child: Text("6ft 4in")),
    DropdownMenuItem(value: "6ft 5in", child: Text("6ft 5in")),
    DropdownMenuItem(value: "6ft 6in", child: Text("6ft 6in")),
    DropdownMenuItem(value: "6ft 7in", child: Text("6ft 7in")),
    DropdownMenuItem(value: "6ft 8in", child: Text("6ft 8in")),
    DropdownMenuItem(value: "6ft 9in", child: Text("6ft 9in")),
    DropdownMenuItem(value: "6ft 10in", child: Text("6ft 10in")),
    DropdownMenuItem(value: "6ft 11in", child: Text("6ft 11in")),
    DropdownMenuItem(value: "7ft 0in", child: Text("7ft 0in")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey[300],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.blueGrey[700],
        title: const Text("TDEE Calculator"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
            child: Column(
              children: [
                const Text("Metric/Imperial"),
                Switch(
                    value: imperial,
                    onChanged: (value) {
                      setState(() {
                        value == false ? imperial = false : imperial = true;
                        print(imperial);
                      });
                    })
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(17, 17, 17, 0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(6))),

            height:
                470, //TODO: Mettere altezza e larghezza in relazione allo schermo
            width: 400,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 0, 5),
              child: Form(
                key: formKey,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldText("Gender", 16),
                        fieldText("Age", 12),
                        fieldText("Weight", 29),
                        fieldText("Height", 17),
                        fieldText("Activity", 27),
                        fieldText("BodyFat\n(Opt.)", 8),
                        fieldText("Goal", 25),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Switch(
                                value: female,
                                onChanged: (value) {
                                  setState(() {
                                    value == false
                                        ? female = false
                                        : female = true;
                                  });
                                },
                              ),
                              female == true
                                  ? const Text("Female")
                                  : const Text("Male")
                            ],
                          ),
                          numberBox(
                              160, "25", "age", ageController, 5, 100, false),
                          numberBox(160, imperial == false ? "Kg" : "lbs", "weight", weightController, 35,
                              250, false),
                          imperial == false
                              ? numberBox(160, "cm", "height", heightController,
                                  100, 220, false)
                              : dropdownBox(imperialHeights, selectedHeight),
                          dropdownBox(activities, selectedActivity),
                          numberBox(60, "15%", "bodyfat", bodyfatController, 3,
                              50, true),
                          dropdownBox(goals, selectedGoal),
                          submitButton(formKey)
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

  Padding fieldText(String text, double padding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, padding, 0, padding),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding numberBox(
      double width,
      String labelText,
      String type,
      TextEditingController controller,
      int minInput,
      int maxInput,
      bool optional) {
    String? numberValidator(String? value) {
      if (value == null) {
        return null;
      }
      final number = num.tryParse(value);

      if (number == null || number > maxInput || number < minInput) {
        if (optional == true) {
          return null;
        }
        return "Invalid Input";
      }
      switch (type) {
        case "age":
          ageValue = double.parse(value);
          break;
        case "weight":
          imperial == true? weightValue= double.parse(value) *0.453592 : weightValue = double.parse(value);
          break;
        case "height":
          heightValue = double.parse(value);
          break;
        case "bodyfat":
          bodyfatValue = double.parse(value);
          break;
      }
      controller.clear();
      female = false;
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: width,
        height: 43,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          validator: numberValidator,
          obscureText: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
        ),
      ),
    );
  }

  ElevatedButton submitButton(GlobalKey<FormState> key) {
    double genderIndex = female == true ? 655 : 66;
    double weightIndex = female == true ? 9.6 : 13.7;
    double heightIndex = female == true ? 1.8 : 5;
    double ageIndex = female == true ? 4.7 : 6.8;

    double activityIndex() {
      switch (selectedActivity) {
        case "Sedentary":
          return 1.2;
        case "Light":
          return 1.375;
        case "Moderate":
          return 1.55;
        case "High":
          return 1.725;
        case "Elite":
          return 1.9;
      }
      return 1.2;
    }

    double goalTdee(double tdee) {
      if (selectedGoal == "Lose") {
        return tdee - (tdee * 0.2);
      } else if (selectedGoal == "Gain") {
        return tdee + 200;
      } else {
        return tdee;
      }
    }

    return ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.blueGrey[700]),
          onPressed: () {
            imperial == true
                ? heightValue = imperialConversion(selectedHeight)
                : null;
            double bmr;
            if (key.currentState!.validate()) {
              bodyfatValue == 0
                  ? bmr = genderIndex +
                      (weightIndex * weightValue) +
                      (heightIndex * heightValue) -
                      (ageIndex * ageValue)
                  : bmr =
                      370 + (21.6 * weightValue * (100 - bodyfatValue) / 100);
              double tdee = bmr * activityIndex();
              double finalTdee = goalTdee(tdee);
              print("BMR is $bmr");
              print("TDEE is $tdee");
              print("goal TDEE is $finalTdee");
              bodyfatValue = 0;
            }
          },
          child: const Text("Submit"));

  }

  Padding dropdownBox(
      List<DropdownMenuItem<String>> items, String? selectedValue) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: DropdownButton<String>(
          items: items,
          onChanged: (value) {
            if (selectedValue == selectedActivity) {
              setState(() {
                selectedActivity = value;
              });
            } else if (selectedValue == selectedActivity) {
              setState(() {
                selectedGoal = value;
              });
            } else if (selectedValue == selectedHeight) {
              setState(() {
                selectedHeight = value;
              });
            }
          },
          value: selectedValue,
        ));
  }

  double imperialConversion(String? selectedHeight) {
    switch (selectedHeight) {
      case "4ft 7in":
        return 139.7;
      case "4ft 8in":
        return 142.24;
      case "4ft 9in":
        return 144.78;
      case "4ft 10in":
        return 147.32;
      case "4ft 11in":
        return 149.86;
      case "5ft 0in":
        return 152.4;
      case "5ft 1in":
        return 154.94;
      case "5ft 2in":
        return 157.48;
      case "5ft 3in":
        return 160.02;
      case "5ft 4in":
        return 162.56;
      case "5ft 5in":
        return 165.1;
      case "5ft 6in":
        return 167.64;
      case "5ft 7in":
        return 170.18;
      case "5ft 8in":
        return 172.72;
      case "5ft 9in":
        return 175.26;
      case "5ft 10in":
        return 177.8;
      case "5ft 11in":
        return 180.34;
      case "6ft 0in":
        return 182.88;
      case "6ft 1in":
        return 185.42;
      case "6ft 2in":
        return 187.96;
      case "6ft 3in":
        return 190.5;
      case "6ft 4in":
        return 193.04;
      case "6ft 5in":
        return 195.58;
      case "6ft 6in":
        return 198.12;
      case "6ft 7in":
        return 200.66;
      case "6ft 8in":
        return 203.2;
      case "6ft 9in":
        return 205.74;
      case "6ft 10in":
        return 208.28;
      case "6ft 11in":
        return 210.82;
      case "7ft 0in":
        return 213.36;
    }
    return 154.94;
  }
}
