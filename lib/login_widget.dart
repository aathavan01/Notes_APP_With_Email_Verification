import 'package:crud1/forgotPassword.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_email/main.dart';
// import 'package:firebase_auth_email/utils/utils.dart';
import 'package:flutter/gestures.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  get key => null;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              TextFormField(
                controller: passwordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "password"),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter min. 6 characters'
                    : null,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: signin,
                icon: Icon(Icons.lock_open),
                label: Text(
                  "Signin",
                  style: TextStyle(fontSize: 24),
                 
                ),
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              ),
               
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                    child:Text('forgotPassword',
                    style: TextStyle(
                      decoration:TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                    ),),
                    onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordPage(),
                    ),
                    ),
                  ),
                  SizedBox(height: 16,),
               
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      text: 'No account?',
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: "Sign Up",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary))
                  ],),),
            ],
          ),
        ),
      );

  Future signin() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    //     showDialog(
    // context: context,
    // barrierDismissible: false,
    // builder: (context) => Center(child: CircularProgressIndicator())
    // );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    // navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
}
