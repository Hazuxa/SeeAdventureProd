import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '/sqlDatabase/databaseHelper.dart';

class Signupscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignupScreenHome();
  }
}

class SignupScreenHome extends StatefulWidget {
  @override
  State<SignupScreenHome> createState() => _SignupScreenHomeState();
}

class _SignupScreenHomeState extends State<SignupScreenHome> {

  // Hide / Show password variables (LIKE LOGIN)
  var hidePassword = true;
  var hideConfirmPassword = true;

  // Controllers
  var fullNameController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();



  // Toggle password
  void showHidePassword() {
    // or     setState(() {
    //       hidePassword = !hidePassword;
    //     });
    if (hidePassword == true) {
      setState(() {
        hidePassword = false;
      });
    }
    else {
      setState(() {
        hidePassword = true;
      });
    }
  }
  // Toggle confirm password
  void showHideConfirmPassword() {
    // or     setState(() {
    //       hideConfirmPassword = !hideConfirmPassword;
    //     });
    if (hideConfirmPassword == true) {
      setState(() {
        hideConfirmPassword = false;
      });
    }
    else {
      setState(() {
        hideConfirmPassword = true;
      });
    }
  }

  void displayInputs(){
    var fullName = fullNameController.text;
    var userName = usernameController.text;
    var password = passwordController.text;
    var cPassword = confirmPasswordController.text;
    //Print  all values using interpolation
    print("The Full name is $fullName");
    print("The Username is $userName");
    print("The Password is $password");
    print("The Confirm Password is $cPassword");
  }
  void inputValidations() async{
    if(fullNameController.text.isEmpty){
      AwesomeDialog(
          width: 300.0,
          context: context,
          title: 'Error',
          desc: 'Full name is required',
          dialogType: DialogType.error,
          btnOkOnPress: (){}
      ).show();
    }
    else if(usernameController.text.isEmpty){
      AwesomeDialog(
          width: 300.0,
          context: context,
          title: 'Error',
          desc: 'Username is required',
          dialogType: DialogType.error,
          btnOkOnPress: (){}
      ).show();
    }
    else if(passwordController.text.isEmpty){
      AwesomeDialog(
          width: 300.0,
          context: context,
          title: 'Error',
          desc: 'Password is required',
          dialogType: DialogType.error,
          btnOkOnPress: (){}
      ).show();
    }
    else if(confirmPasswordController.text.isEmpty){
      AwesomeDialog(
          width: 300.0,
          context: context,
          title: 'Error',
          desc: 'Confirm password is required',
          dialogType: DialogType.error,
          btnOkOnPress: (){}
      ).show();
    }
    else if(confirmPasswordController.text != confirmPasswordController.text){
      AwesomeDialog(
          width: 300.0,
          context: context,
          title: 'Error',
          desc: 'Password does not match',
          dialogType: DialogType.error,
          btnOkOnPress: (){}
      ).show();
    }
    else{
      final result = await DatabaseHelper().insertStudent(fullNameController.text, usernameController.text, passwordController.text);
      if(result > 0){
        AwesomeDialog(
            width: 300.0,
            context: context,
            title: 'Success',
            desc: 'User successfully registered!',
            dialogType: DialogType.success,
            btnOkOnPress: (){}
        ).show();
      } else {
        AwesomeDialog(
            width: 300.0,
            context: context,
            title: 'Error',
            desc: 'ERROR!!',
            dialogType: DialogType.error,
            btnOkOnPress: (){}
        ).show();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Card(
          elevation: 30.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(
                  child: Text(
                    'Registration Screen',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Full Name
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        label: Text("Full Name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),

                // Username
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        label: Text("Username"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),

                // Password (LIKE LOGIN)
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            showHidePassword();
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        label: Text("Password"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),

                // Confirm Password (LIKE LOGIN)
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: hideConfirmPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            showHideConfirmPassword();
                          },
                          icon: Icon(
                            hideConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        label: Text("Confirm Password"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),

                // Sign Up Button
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 16,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.orange),
                      ),
                      onPressed: () {
                        displayInputs();
                        inputValidations();
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Registered?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Login Here'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
