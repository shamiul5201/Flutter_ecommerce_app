import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}





class _LoginState extends State<Login>
{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/login.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Login to your account",
                style: TextStyle(color: Colors.white),
              ),
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [

                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.person,
                    hintText: "Password",
                    isObsecure: true,
                  ),

                  RaisedButton(
                    onPressed: () {
                      _emailTextEditingController.text.isNotEmpty && _passwordTextEditingController.text.isNotEmpty 
                          ? loginUser()
                          :showDialog(
                              context: context,
                        builder: (c) {
                                return ErrorAlertDialog(message: "Please write your email and password",);
                              }
                          );
                    },
                    color: Colors.pink,
                    child: Text("Sign up", style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    height: 4.0,
                    width: _screenWidth * 0.8,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSignInPage())),
                    icon: (Icon(Icons.nature_people, color: Colors.pink,)),
                    label: Text("I am an Admin", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),),

                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async {
    showDialog(
      context: context,
      builder: (c) {
        return LoadingAlertDialog(message: "Authenticating please wait",);
      }
    );
    FirebaseUser firebaseUser;
    await _auth.signInWithEmailAndPassword(
      email:  _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    ).then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(message: error.message.toString(),);
          }
      );

    });
    if (firebaseUser != null){
      readData(firebaseUser);
    }
  }

 Future readData(FirebaseUser fUser) async {

 }

}
