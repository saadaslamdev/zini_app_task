import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zini_pay_task/src/core/utils/app_colors.dart';
import 'package:zini_pay_task/src/features/data/models/credential_model.dart';

import '../../data/helpers/dio_helper.dart';

class AllCredentialsPage extends StatefulWidget {
  const AllCredentialsPage({super.key});

  @override
  State<AllCredentialsPage> createState() => _AllCredentialsPageState();
}

class _AllCredentialsPageState extends State<AllCredentialsPage> {
  late Future<List<Credential>> _credentialsFuture;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _credentialsFuture = fetchCredentials();
  }

  Future<List<Credential>> fetchCredentials() async {
    final dioHelper = DioHelper(dio: Dio());
    final response = await dioHelper.fetchCredentials();

    return response.fold(
      (failure) {
        throw Exception('Failed to load credentials: ${failure.message}');
      },
      (result) {
        if (result['success']) {
          return (result['data'] as List)
              .map((messageJson) => Credential.fromJson(messageJson))
              .toList();
        } else {
          throw Exception('Failed to load messages.');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('All Credentials',
              style: TextStyle(color: AppColors.white))),
      body: FutureBuilder<List<Credential>>(
        future: _credentialsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No credentials found.'));
          }

          final credentials = snapshot.data!;

          return ListView.builder(
            itemCount: credentials.length,
            itemBuilder: (context, index) {
              final credential = credentials[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading:
                      Icon(Icons.lock, color: Theme.of(context).primaryColor),
                  title: Text(
                    credential.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    credential.id,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () => _showCredentialDetails(context, credential),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showCredentialDetails(BuildContext context, Credential credential) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            credential.deviceName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${credential.id}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Email: ${credential.email}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('API Key: ${credential.apiKey}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Device Model: ${credential.deviceModel}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Registered At: ${credential.registeredAt.toLocal()}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
