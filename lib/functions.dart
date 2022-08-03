import 'package:flutter/material.dart';
import 'output.dart';

void formValidate(BuildContext context, double bodyfatValue, double weightValue, double weightIndex, double idealWeight, double heightValue, double heightIndex,double ageValue,double ageIndex, double genderIndex, String? selectedActivity, String? selectedGoal, double tdee,double finalTdee,double bmr, double bmi)  {
  double activityIndex(String? selectedActivity) {
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

  double goalTdee(double tdee, selectedGoal) {
    if (selectedGoal == "Lose") {
      return tdee - (tdee * 0.2);
    } else if (selectedGoal == "Gain") {
      return tdee + 200;
    } else {
      return tdee;
    }
  }


  bodyfatValue == 0
      ? bmr = genderIndex +
      (weightIndex * weightValue) +
      (heightIndex * heightValue) -
      (ageIndex * ageValue)
      : bmr =
      370 + (21.6 * weightValue * (100 - bodyfatValue) / 100);
  tdee = bmr * activityIndex(selectedActivity);
  finalTdee = goalTdee(tdee, selectedGoal);
  bmi = weightValue / ((heightValue/100)*(heightValue/100));

  Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
          OutputPage(finalTdee: finalTdee, tdee: tdee, bmi: bmi, bmr: bmr, idealWeight: idealWeight)
      )
  );

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


