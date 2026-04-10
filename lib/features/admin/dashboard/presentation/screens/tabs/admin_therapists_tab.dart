import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../bloc/admin_cubit.dart';
import '../../bloc/admin_state.dart';

class AdminTherapistsTab extends StatelessWidget {
  const AdminTherapistsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Therapist Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending Verification'),
              Tab(text: 'Approved'),
            ],
          ),
        ),
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (msg) => Center(child: Text('Error: $msg')),
              loaded: (_, __, pending, approved) => TabBarView(
                children: [
                  _PendingList(pendingTherapists: pending),
                  _ApprovedList(approvedTherapists: approved),
                ],
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}

class _PendingList extends StatelessWidget {
  final List<dynamic> pendingTherapists;

  const _PendingList({required this.pendingTherapists});

  @override
  Widget build(BuildContext context) {
    if (pendingTherapists.isEmpty) {
      return const Center(child: Text('No pending verifications'));
    }
    
    return ListView.builder(
      itemCount: pendingTherapists.length,
      itemBuilder: (context, index) {
        final therapist = pendingTherapists[index];
        final tId = therapist['id'];
        final name = therapist['displayName'] ?? 'Unknown';

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(name),
            subtitle: const Text('License: Pending Verification'),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check_circle, color: Colors.green),
                  onPressed: () => context.read<AdminCubit>().verifyTherapist(tId, approve: true),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () => context.read<AdminCubit>().verifyTherapist(tId, approve: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ApprovedList extends StatelessWidget {
  final List<dynamic> approvedTherapists;

  const _ApprovedList({required this.approvedTherapists});

  @override
  Widget build(BuildContext context) {
    if (approvedTherapists.isEmpty) {
      return const Center(child: Text('No approved therapists'));
    }

    return ListView.builder(
      itemCount: approvedTherapists.length,
      itemBuilder: (context, index) {
        final therapist = approvedTherapists[index];
        final name = therapist['displayName'] ?? 'Unknown';
        
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(name),
          subtitle: const Text('Active Therapist'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        );
      },
    );
  }
}

