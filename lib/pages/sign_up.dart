// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_cats_shop_app/cubits/signup_cubit/signup_cubit.dart';
import 'package:the_cats_shop_app/cubits/signup_cubit/signup_states.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailContorller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pop(context);
        }

        if (state is SignupFailure) {
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.errorMessage!),
            action: SnackBarAction(
              backgroundColor: Colors.red,
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Signup'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailContorller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                obscureText: obsecure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecure = !obsecure;
                      });
                    },
                    icon: Icon(
                      obsecure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 100,
              ),
              BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<SignupCubit>().signup(
                        email: emailContorller.text,
                        password: passwordController.text);
                  },
                  child: state is SignupLoading
                      ? CircularProgressIndicator()
                      : Text('Sing up'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
