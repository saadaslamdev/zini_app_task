import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zini_pay_task/src/core/utils/app_colors.dart';
import 'package:zini_pay_task/src/features/data/helpers/dio_helper.dart';
import '../../data/models/message_model.dart';

class AllMessagesPage extends StatelessWidget {
  const AllMessagesPage({super.key});

  Future<List<Message>> fetchMessages() async {
    final dioHelper = DioHelper(dio: Dio());
    final response = await dioHelper.fetchMessages();

    return response.fold(
      (failure) {
        throw Exception('Failed to load messages: ${failure.message}');
      },
      (result) {
        if (result['success']) {
          return (result['data'] as List)
              .map((messageJson) => Message.fromJson(messageJson))
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
        title: const Text(
          'All Messages',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: FutureBuilder<List<Message>>(
        future: fetchMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No messages found.'));
          }

          final messages = snapshot.data!;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: const CircleAvatar(
                    // Use a placeholder or user image
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    message.message,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'From: ${message.from}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  trailing: Text(
                    '${message.time.hour}:${message.time.minute < 10 ? '0${message.time.minute}' : message.time.minute}',
                    style: const TextStyle(color: Colors.black54, fontSize: 15),
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
