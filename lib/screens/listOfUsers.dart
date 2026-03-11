import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '/screens/dashboard.dart';
import '/sqlDatabase/databaseHelper.dart';

class Listofusers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListofusersHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListofusersHome extends StatefulWidget {
  @override
  State<ListofusersHome> createState() => _ListofusersHomeState();
}

class _ListofusersHomeState extends State<ListofusersHome> {
  var students = [];

  void getAllStudents() async {
    final data = await DatabaseHelper().getAllStudents();
    setState(() {
      students = data;
    });
    print(students.toString());
  }

  @override
  void initState() {
    super.initState();
    getAllStudents();
  }

  //Create a BottomModalSheet for Editing
  void editUser(BuildContext context, int userId, String fullName, String username, String password){
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context){
          var fullNameController = TextEditingController();
          var usernameController = TextEditingController();
          var passwordController = TextEditingController();

          fullNameController.text = fullName;
          usernameController.text = username;
          passwordController.text = password;

          return Padding(
            padding: const EdgeInsets.all(8.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.5),
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.5),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.5),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.5,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.orange),
                        ),
                        onPressed: () async{
                          final updateResult = await DatabaseHelper().updateStudent(userId, fullNameController.text, usernameController.text , passwordController.text);
                          if(updateResult > 0){
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                title: 'Success',
                                desc: 'User Updated',
                                btnOkOnPress: (){
                                  getAllStudents();
                                  setState(() {

                                  });

                                }
                            ).show();
                          }
                          else{
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                title: 'Error',
                                desc: 'Error',
                                btnOkOnPress: (){

                                }
                            ).show();

                          }
                        },
                        child: Text('Update Po', style: TextStyle(color: Colors.black),)
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Users"),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DashboardHome(),
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, index) {
                var id = students[index]['id'];
                var fullName = students[index]["fullName"];
                var username = students[index]["username"];
                var password = students[index]["password"];

                return ListTile(
                  leading: Icon(
                    Icons.people,
                    color: Colors.blueAccent,
                  ),
                  title: Text("$fullName"),
                  subtitle: Text("$username"),
                  trailing: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            editUser(context, id, fullName, username, password);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            AwesomeDialog(
                                context: context,
                                title: 'Warning',
                                desc: 'Delete?',
                                dialogType: DialogType.warning,
                                btnOkOnPress: () async{
                                  final deleteResult = await DatabaseHelper().deleteStudent(id);
                                  getAllStudents();


                                },
                                btnCancelOnPress: (){

                                }
                            ).show();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
