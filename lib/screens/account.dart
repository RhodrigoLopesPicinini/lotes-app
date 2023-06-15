import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/states/users_state.dart';

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
    final usersState = Provider.of<UsersState>(context, listen: false);
    _nameController = TextEditingController(text: usersState.user.name);
    _emailController = TextEditingController(text: usersState.user.email);
    _phoneController = TextEditingController(text: usersState.user.phoneNumber);
  }

  void _saveChanges() {
    final usersState = Provider.of<UsersState>(context, listen: false);
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;

    usersState.editUser(name, email, phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sucesso'),
        content: const Text('Alterações salvas.'),
        actions: [
          TextButton(
            child: const Text('OK'),
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
        title: const Text('Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Celular',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Salvar alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
