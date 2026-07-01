import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/admin_cubit.dart';
import '../../bloc/admin_state.dart';

class AdminUsersTab extends StatelessWidget {
  const AdminUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          return state.maybeMap(
            loading: (_) => const Center(child: CircularProgressIndicator()),
            error: (e) => Center(child: Text('Error: ${e.message}')),
            loaded: (loaded) {
              final users = loaded.users;
              if (users.isEmpty) {
                return const Center(child: Text('No users found.'));
              }

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final name = user['displayName'] ?? 'Unknown User';
                  final email = user['email'] ?? '';
                  final role = user['userRole'] ?? 'patient';

                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(name),
                    subtitle: Text('$email • Role: $role'),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'view',
                          child: Text('View Profile'),
                        ),
                        const PopupMenuItem(
                          value: 'suspend',
                          child: Text('Suspend Account'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
