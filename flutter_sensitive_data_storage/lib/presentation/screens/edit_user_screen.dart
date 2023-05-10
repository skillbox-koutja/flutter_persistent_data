import 'package:flutter/material.dart';
import 'package:flutter_sensitive_data_storage/domain/user.dart';
import 'package:flutter_sensitive_data_storage/domain/user_entity.dart';
import 'package:flutter_sensitive_data_storage/presentation/screens/widgets/edit_field.dart';

class EditUserScreen extends StatefulWidget {
  final UserEntity userEntity;

  const EditUserScreen({super.key, required this.userEntity});

  @override
  State<EditUserScreen> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<EditUserScreen> {
  UserEntity get userEntity => widget.userEntity;
  User get user => userEntity.user;

  final _lastNameFieldController = TextEditingController();
  final _firstNameFieldController = TextEditingController();
  final _ageFieldController = TextEditingController();
  final _phoneFieldController = TextEditingController();
  final _avatarFieldController = TextEditingController();
  final _creditCardNumberFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameFieldController.text = user.firstName;
    _lastNameFieldController.text = user.lastName;
    _ageFieldController.text = user.age.toString();
    _phoneFieldController.text = user.phoneNumber;
    _avatarFieldController.text = user.avatar;
    userEntity.cardNumber().then((value) => _creditCardNumberFieldController.text = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit user'),
      ),
      body: _Body(
        userEntity: userEntity,
        lastNameFieldController: _lastNameFieldController,
        firstNameFieldController: _firstNameFieldController,
        ageFieldController: _ageFieldController,
        phoneFieldController: _phoneFieldController,
        avatarFieldController: _avatarFieldController,
        creditCardNumberFieldController: _creditCardNumberFieldController,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final UserEntity userEntity;
  final TextEditingController lastNameFieldController;
  final TextEditingController firstNameFieldController;
  final TextEditingController ageFieldController;
  final TextEditingController phoneFieldController;
  final TextEditingController avatarFieldController;
  final TextEditingController creditCardNumberFieldController;

  const _Body({
    super.key,
    required this.userEntity,
    required this.lastNameFieldController,
    required this.firstNameFieldController,
    required this.ageFieldController,
    required this.phoneFieldController,
    required this.avatarFieldController,
    required this.creditCardNumberFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            EditField(
              controller: firstNameFieldController,
              label: 'First name',
            ),
            EditField(
              controller: lastNameFieldController,
              label: 'Last name',
            ),
            EditField(
              controller: ageFieldController,
              label: 'Age',
            ),
            EditField(
              controller: phoneFieldController,
              label: 'Phone Number',
            ),
            EditField(
              controller: avatarFieldController,
              label: 'Avatar link',
            ),
            EditField(
              controller: creditCardNumberFieldController,
              label: 'Credit card number',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          _addUser();
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addUser() async {
    final firstName = firstNameFieldController.text;
    final lastName = lastNameFieldController.text;
    final age = ageFieldController.text;
    final phoneNumber = phoneFieldController.text;
    final avatar = avatarFieldController.text;
    final creditCardNumber = creditCardNumberFieldController.text;

    await userEntity.edit(
      User(
        firstName: firstName,
        lastName: lastName,
        age: int.parse(age),
        phoneNumber: phoneNumber,
        avatar: avatar,
      ),
      creditCardNumber,
    );
  }
}
