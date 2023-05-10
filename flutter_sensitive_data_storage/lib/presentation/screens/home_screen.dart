import 'package:flutter/material.dart';
import 'package:flutter_sensitive_data_storage/domain/user_entity.dart';
import 'package:flutter_sensitive_data_storage/domain/user_entity_repository.dart';
import 'package:flutter_sensitive_data_storage/presentation/screens/edit_user_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserEntityRepository userEntityRepository;

  const HomeScreen({
    super.key,
    required this.userEntityRepository,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: StreamBuilder<List<UserEntity>>(
        initialData: const [],
        stream: widget.userEntityRepository.users$(),
        builder: (BuildContext context, AsyncSnapshot<List<UserEntity>> snapshot) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Users list is empty'),
            );
          } else {
            final userEntities = snapshot.data!;

            return ListView.builder(
              itemCount: userEntities.length,
              itemBuilder: (context, index) {
                final userEntity = userEntities[index];
                final user = userEntity.user;

                return ListTile(
                  key: ValueKey(userEntity.id),
                  title: Text(
                    user.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(user.phoneNumber),
                  leading: user.avatar.isEmpty
                      ? const CircleAvatar(
                          child: Icon(Icons.person),
                        )
                      : CircleAvatar(
                          foregroundImage: NetworkImage(
                          user.avatar,
                        )),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditUserScreen(
                          userEntity: userEntity,
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await userEntity.delete();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.userEntityRepository.add().then((userEntity) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditUserScreen(
                  userEntity: userEntity,
                ),
              ),
            );
          });
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ),
    );
  }
}
