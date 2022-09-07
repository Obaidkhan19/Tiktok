
import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/views/screens/auth/signup.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);


  final TextEditingController _emailController  = TextEditingController();
  final TextEditingController _passwordController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('TikTok',
              style: TextStyle(fontSize: 35,
                  color: buttonColor,
                  fontWeight:FontWeight.w900 ),
            ),
            Text('LogIn',
              style: TextStyle(fontSize: 25,
                  fontWeight:FontWeight.w700 ),
            ),
            SizedBox(height: 25,),
            Container(
              width:  MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              // TEXT INPUT FIELD
              child: TextInputField(
                controller: _emailController,
                labelText:  'Email',
                icon: Icons.email,
              ),
            ),
            SizedBox(height: 25,),
            Container(
              width:  MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              // TEXT INPUT FIELD
              child: TextInputField(
                controller: _passwordController,
                labelText:  'Password',
                icon: Icons.lock,
                isObsecure: true,
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width:  MediaQuery.of(context).size.width-40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(5),),
              ),
              child: InkWell(
                onTap: () =>authController.loginUser(
                    _emailController.text,
                    _passwordController.text
                ),
                child: Center(
                    child: Text('Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                ),
              ),
            ),
            SizedBox(height:  15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? ', style: TextStyle(fontSize: 20,),),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(),)),
                  child: Text('Register ', style: TextStyle(fontSize: 20,color: buttonColor),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
