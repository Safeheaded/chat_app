import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
      String email, String password, String? username, File? userImageFile, bool isLogin) submitFn;
  final bool isLoading;
  const AuthForm(this.submitFn, this.isLoading, {Key? key, required})
      : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String? _userEmail;
  String? _userName;
  String? _userPassword;
  File? _userImageFile;

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('User image must be selected'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState?.save();

      widget.submitFn(
          _userEmail!.trim(), _userPassword!, _userName?.trim(), _userImageFile, _isLogin);
    }
  }

  void _pickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                if (!_isLogin) UserImagePicker(imagePickFn: _pickedImage),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email address'),
                  onSaved: ((value) {
                    _userEmail = value;
                  }),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator: ((value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    }),
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: ((value) {
                      _userName = value;
                    }),
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: ((value) {
                    if (value == null || value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  }),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: ((value) {
                    _userPassword = value;
                  }),
                ),
                const SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Sign Up')),
                if (!widget.isLoading)
                  TextButton(
                    child: Text(
                      _isLogin
                          ? 'Create new account'
                          : 'I already have an account',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
