import 'package:firestore_example/models/user_model.dart';
import 'package:firestore_example/services/firestore_services.dart';
import 'package:flutter/material.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  List<UserModel> users = [];
  bool isLoading = true;
  @override
  void initState() {
    fetchUsers();
    super.initState();
  }
  
  Future<void> fetchUsers() async {
    isLoading = true;
    users = await FirestoreServices.getAllUsers();
    setState(() {
      isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading? Center(child: CircularProgressIndicator(),):users.isEmpty? Center(child: Text("No users found")): ListView.builder(
        itemBuilder: (context,counter)=> ListTile(
          title: Text(users[counter].name),
          subtitle: Text("Hobby: ${users[counter].hobby}"),
          trailing: Text(users[counter].age),
        ),
        itemCount: users.length,
      )
    );
  }
}
