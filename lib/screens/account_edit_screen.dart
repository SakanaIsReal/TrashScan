import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashscan/widgets/custom_back_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:path_provider/path_provider.dart';
import '../functions/user_data.dart';
import 'package:go_router/go_router.dart';

class AccountEditScreen extends StatefulWidget {
  const AccountEditScreen({super.key});

  @override
  _AccountEditScreenState createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: "");
  final FocusNode _usernameFocusNode = FocusNode();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  DateTime? _registrationDate;
  String? _usernameErrorText;
  String? _profileImageErrorText;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final savedData = await UserStorage.loadUserData();
    if (savedData != null) {
      _usernameController.text = savedData.username;
      _registrationDate = savedData.registrationDate;
      if (savedData.profileImagePath != null) {
        final file = File(savedData.profileImagePath!);
        if (await file.exists()) {
          setState(() {
            _profileImage = file;
          });
        }
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        final directory = await getApplicationDocumentsDirectory();
        final profileDir = Directory('${directory.path}/profile');
        if (!await profileDir.exists()) {
          await profileDir.create(recursive: true);
        }

        final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedImage =
            await File(pickedFile.path).copy('${profileDir.path}/$fileName');

        setState(() {
          _profileImage = savedImage;
          _profileImageErrorText = null;
        });
      }
    } catch (e) {
      setState(() {
        _profileImageErrorText = "Failed to pick image: ${e.toString()}";
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.account_circle, size: 40),
                  const SizedBox(width: 4),
                  const Text(
                    'Account',
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  CustomBackButton(),
                ],
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 5,
                          )
                        ],
                        image: _profileImage != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(_profileImage!),
                              )
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/profile/profile_placeholder.png'),
                              ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(width: 6, color: Colors.white),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 30),
                      ),
                    )
                  ],
                ),
              ),
              if (_profileImageErrorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _profileImageErrorText!,
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                ),
              const SizedBox(height: 42),
              TextField(
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Enter username",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: _usernameErrorText != null ? Colors.red : Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: _usernameErrorText != null
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  errorText: _usernameErrorText,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _usernameController.text = "";
                      setState(() {
                        _profileImage = null;
                      });
                    },
                    child: const Text("Revert"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final newUsername = _usernameController.text.trim();
                      final isTooLong = newUsername.length > 10;
                      final isNotEnglish = !RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(newUsername);
                      setState(() {
                        _usernameErrorText = null;
                        _profileImageErrorText = null;
                      });

                      // if (_profileImage == null) {
                      //   setState(() => _profileImageErrorText =
                      //       "Profile image upload failed. Please try again.");
                      //   return;
                      // }

                      if (isTooLong || isNotEnglish) {
                        setState(() {
                          _usernameErrorText = isTooLong && isNotEnglish
                              ? "Username can only contain English letters and must not exceed 10 characters."
                              : isTooLong
                                  ? "Username must not exceed 10 characters."
                                  : "Username can only contain English letters.";
                        });
                        return;
                      }

                      final userData = UserData(
                        username: newUsername,
                        profileImagePath: _profileImage?.path,
                        registrationDate: _registrationDate,
                      );

                      await UserStorage.saveUserData(userData);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("✅ Saved successfully!")),
                      );

                      await Future.delayed(const Duration(seconds: 1));
                      if (context.mounted) {
                        context.push('/account');
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
    );
  }
}