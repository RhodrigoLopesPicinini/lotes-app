import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/states/users_state.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersState = Provider.of<UsersState>(context);
    String name = usersState.user.name;
    String email = usersState.user.email;
    String phoneNumber = usersState.user.phoneNumber;

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
              onChanged: (value) => name = value,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              controller: TextEditingController(text: usersState.user.name),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) => email = value,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              controller: TextEditingController(text: usersState.user.email),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) => phoneNumber = value,
              decoration: const InputDecoration(
                labelText: 'Celular',
              ),
              controller: TextEditingController(
                text: usersState.user.phoneNumber,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                usersState.editUser(name, email, phoneNumber);
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
              },
              child: const Text('Salvar alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
