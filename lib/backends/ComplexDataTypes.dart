class ComplexDataTypes {
  var grades = [1.2, 1.3, 2.0, 1.0];
  List<Map<String, dynamic>> userAccounts = [
    {'id': 1, 'username': 'admin', 'password': 'admin123'},
    {'id': 2, 'username': 'admin', 'password': 'cashier123'},
    {'id': 3, 'username': 'admin', 'password': 'customer123'}
  ];
  void displayGradesOneByOne(){
    for (int i = 0; i < grades.length; i++){
      var grade = grades[i];
      var num = i+1;
      print("$i : $grade");
    }
  }
}