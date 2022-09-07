import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/controllers/auth_controller.dart';
import 'package:tiktok/views/screens/auth/login_screen.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';


class SignUpScreen extends StatelessWidget {
   SignUpScreen({Key? key}) : super(key: key);


  final TextEditingController _emailController  = TextEditingController();
  final TextEditingController _passwordController  = TextEditingController();
   final TextEditingController _userNameController  = TextEditingController();


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
            Text('Register',
              style: TextStyle(fontSize: 25,
                  fontWeight:FontWeight.w700 ),
            ),

            // IMAGE
            Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/1053/1053244.png?w=360'),
               backgroundColor: Colors.black,
                ),

                // ADD IMG ICON ON IMAGE
                Positioned(
                  bottom: -10,
                    left: 80,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () => authController.pickImage(),
                    ),
                ),

              ],
            ),
            SizedBox(height: 15,),
            Container(
              width:  MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              // TEXT INPUT FIELD
              child: TextInputField(
                controller: _userNameController,
                labelText:  'Username',
                icon: Icons.person,
              ),
            ),
            SizedBox(height: 15,),
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
            SizedBox(height: 15,),
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
              height: 30,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(5),),
              ),
              child: InkWell(
                onTap: () => authController.registerUser(
                    _userNameController.text,
                    _emailController.text,
                    _passwordController.text,
                    authController.profilePhoto,
                ),
                child: Center(
                  child: Text('Register',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(height:  15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? ', style: TextStyle(fontSize: 20,),),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),)),
                  child: Text('LogIn ',
                    style: TextStyle(
                        fontSize: 20,color: buttonColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
