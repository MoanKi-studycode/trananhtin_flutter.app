import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign in")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SupaEmailAuth(
            onSignInComplete: (response) {},
            onSignUpComplete: (response) {
              if(response?.user !=null){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> PageVerifyUser(email: response!.user!.email!))
                  );
              }
            },
            showConfirmPasswordField: true,
          ),
        ],
      ),
    );
  }
}

class PageVerifyUser extends StatelessWidget {
   PageVerifyUser({super.key, required this.email} );
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verifying user"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OtpTextField(
            numberOfFields: 6,
            borderColor: Colors.black,
            showFieldAsBox: true,
            borderWidth: 4.0,
            fieldWidth: 45,
            textStyle: TextStyle(fontSize: 18),

            onSubmit: (String verificationCode) async{
              var response = await Supabase.instance.client.auth.verifyOTP(
                type: .email,
                token: verificationCode,
                email: email
                );
              if(response?.session!=null && response?.user!=null){
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => PageThongTinUser()), (route) => false
                  );
              }
            },
          )
        ],
      ),
    );
  }
}

class PageThongTinUser extends StatelessWidget {
  const PageThongTinUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information of User"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
