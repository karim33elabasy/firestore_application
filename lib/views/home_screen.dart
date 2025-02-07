import 'package:firestore_example/models/user_model.dart';
import 'package:firestore_example/services/firestore_services.dart';
import 'package:firestore_example/views/all_users_screen.dart';
import 'package:firestore_example/views/widgets/my_tff.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController name = TextEditingController();
    TextEditingController age = TextEditingController();
    TextEditingController hobby = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? validator (String? value) {
      if(value == null || value.isEmpty){
        return "This field is required";
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      MyTff(label: 'Name', controller: name, validator: validator,),
                      MyTff(label: 'Age', controller: age, validator: validator,),
                      MyTff(label: 'Hobby', controller: hobby, validator: validator,),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: ()async{
                          if(formKey.currentState!.validate()){
                            UserModel user = UserModel(name: name.text,age:  age.text,hobby:  hobby.text);
                            String message = await FirestoreServices.addUserToFirestore(user);
                            name.clear();
                            age.clear();
                            hobby.clear();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                          }
                        },
                        child: Text('Save')
                    ),
                    OutlinedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AllUsersScreen()));
                        },
                        child: Text('Display')
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
