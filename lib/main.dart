import 'package:flutter/cupertino.dart';
import 'screens/loginScreen.dart';
import 'backends/ComplexDataTypes.dart';
import 'classActivity.dart';

void main(){
  runApp(Loginscreen());
  int cY = 2025;
  int bY = 2004;

  //Consuming a method that returns nothings
  ClassLesson().displayName();
  //Consuming a method that returns a date
  var age = ClassLesson().calculateUserAge(cY, bY);
  print('The Current year is $cY the birth year is $bY and the age is $age');
  ComplexDataTypes().displayGradesOneByOne();
  var users = ComplexDataTypes().userAccounts;
  for(int i = 0; i < users.length; i++){
    var id = users[i]['id'];
    var username = users[i]['username'];
    var password = users[i]['password'];
    print("ID: $id, Username: $username, Password: $password");
  }


  // //print fullname
  // print("Lanz Dominic Laga");
  // //for loop
  //
  // int even = 0;
  // int odd = 0;
  // for(int i = 0; i < 100; i++) {
  //   if (i % 2 == 0) {
  //     even += i;
  //   } else {
  //     odd += i;
  //   }
  // }
  // print("Odd: $odd");
  // print("Even: $even");
  //
  // //Counter from 100 to 1 using Decrement
  //
  // print("--100 to 1--");
  // for(int i = 100; i > 0; i--) {
  //   print(i);
  // }
  //
  // // Print the age by getting the difference between currentYear and birthYear
  //
  // int currentYear = 2025;
  // int birthYear = 2004;
  //
  // age = currentYear -  birthYear;
  //
  // print("Age:$age");
  //
  // //Create an arithmetic calculator using four functions addition(), multiplication(), division(), these functions will
  // //accept 2 numbers as parameters, pass any numbers(stored in 2 variable) as argument and store the result to its corresponding variables
  // //sum, difference, product, quotient, then print the values of each variable using interpolation(in sum ofb1 and 2 is 3)
  //
  // // store any two numbers
  // var num1 = 10;
  // var num2 = 5;
  //
  // // function variables
  // addition(a, b) => a + b;
  // subtraction(a, b) => a - b;
  // multiplication(a, b) => a * b;
  // division(a, b) => a / b;
  //
  // // compute results
  // var sum = addition(num1, num2);
  // var difference = subtraction(num1, num2);
  // var product = multiplication(num1, num2);
  // var quotient = division(num1, num2);
  //
  // // print with interpolation
  // print("The sum of $num1 and $num2 is $sum");
  // print("The difference of $num1 and $num2 is $difference");
  // print("The product of $num1 and $num2 is $product");
  // print("The quotient of $num1 and $num2 is $quotient");



}
