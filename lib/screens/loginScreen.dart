import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/screens/dashboard.dart';
import '/screens/homePage.dart';
import '/screens/signupScreen.dart';
import '/sqlDatabase/databaseHelper.dart';

//Primary Class
class Loginscreen extends StatelessWidget{
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenHome(),
    ); // MaterialApp
  }
}

//Secondary Class
class LoginScreenHome extends StatefulWidget{
  const LoginScreenHome({super.key});

  @override
  State<LoginScreenHome> createState() => _LoginScreenHomeState();
}

class _LoginScreenHomeState extends State<LoginScreenHome> {
  //Declare Variable Here..
  //Initialize Controllers for Username and Password
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var hidePassword = false;
  //Show or Hide Password
  void showHidePassword(){
    // hidePassword?true:false;
    if(hidePassword == true){
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

  void valiidateInput() async{
    if(usernameController.text.isEmpty) {
      AwesomeDialog(
          context: context,
          title: 'Error',
          desc: 'username is empty',
          btnOkOnPress: (){}
      ).show();

    } else if(passwordController.text.isEmpty) {
      AwesomeDialog(
          context: context,
          title: 'Error',
          desc: 'password is empty',
          btnOkOnPress: (){}
      ).show();
    } else {

      //Execute the Login Algorithm
      final users = await DatabaseHelper().loginUser(usernameController.text, passwordController.text);
      if(users.isEmpty){
        AwesomeDialog(
            context: context,
            title:  'Invalid Username or Password',
            dialogType: DialogType.error,
            desc: 'User not found in the Database',
            btnOkOnPress: (){}
        ).show();
      } else {
        //Navigate to Dashboard
        AwesomeDialog(
            context: context,
            title:  'Login Success',
            dialogType: DialogType.success,
            desc: 'User Successfully Valid',
            btnOkOnPress: (){}
        ).show();
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context)=>Homepage()
            )
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Card(
          elevation: 30.0,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Please Login to Continue',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),//TextStyle
                  ), //Center
                ),
                //Text Field Username
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.supervised_user_circle),
                          label: Text("Username"),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.orange
                            ),
                          )
                      ),
                    ),
                  ),
                ),
                //Password TextField
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration:  InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: (){
                            showHidePassword();
                          },
                          icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,),
                        ),
                        label: Text("Password"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orange
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/15,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.orange)
                      ),
                      onPressed: (){
                        valiidateInput();
                      },
                      child: Text('Login',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Account'),
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context)=> Signupscreen()));
                        },
                        child: Text('SignUp'))
                  ],

                ),
              ]

          ),
        ),
      ), //Column
    ); //Scaffold
  }
}
