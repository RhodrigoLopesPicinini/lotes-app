import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/screens/account.dart';
import 'package:registro_lotes_app/states/users_state.dart';
import 'package:registro_lotes_app/states/acres_state.dart';
import 'package:registro_lotes_app/utils/dialog_utils.dart';
import 'package:registro_lotes_app/screens/acre_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.grass),
            Text('LOTES BUSINESS'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => AcreDialogUtils().openCreateAcreDialog(context),
          ),
        ],
      ),
      body: Consumer2<AcresState, UsersState>(
        builder: (context, acresState, usersState, _) {
          return ListView.builder(
            itemCount: acresState.acres.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  AcreDialogUtils().openEditAcreDialog(context, acresState.acres[index], index);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      acresState.acres[index].address,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'R\$${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(acresState.acres[index].price)}',
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AcreDetailsScreen(
                            acre: acresState.acres[index],
                            userName: usersState.user.name,
                            userEmail: usersState.user.email,
                            userPhone: usersState.user.phoneNumber,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
