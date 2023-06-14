import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/states/users_state.dart';
import 'package:registro_lotes_app/user.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the user's information
    final usersState = Provider.of<UsersState>(context, listen: false);
    _nameController = TextEditingController(text: usersState.user.name);
    _emailController = TextEditingController(text: usersState.user.email);
    _phoneController = TextEditingController(text: usersState.user.phoneNumber);
  }

  @override
  void dispose() {
    // Dispose the text controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final usersState = Provider.of<UsersState>(context, listen: false);
    // Save the changes made to the user's information
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;

    usersState.editUser(name, email, phone);

    // Show a success message or perform any other desired action
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Changes saved successfully.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              // Add an image for the user's avatar if desired
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Registered Acres: 0',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
