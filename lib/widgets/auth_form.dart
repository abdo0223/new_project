import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roovies/widgets/auth_title.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  GlobalKey field;
  bool hidePassword, hideconfirmPasswod, loginmod;
  double height;
  @override
  void initState() {
    super.initState();
    field = GlobalKey();
    hidePassword = hideconfirmPasswod = loginmod = true;
    height = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: (loginmod)
                      ? AuthTitle(UniqueKey(), 'Login into')
                      : AuthTitle(UniqueKey(), 'Create'),
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      //بعرف ال height بتاعه TextFormField
                      key: field,

                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          labelText: 'Email',
                          hintText: "@example.abdo.com",
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: Icon(
                              (hidePassword)
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                          labelText: 'Password',
                          hintText: "********",
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.bounceOut,
                      height: height,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: (loginmod) ? 0 : 1,
                        child: TextFormField(
                          obscureText: hideconfirmPasswod,
                          decoration: InputDecoration(
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    hideconfirmPasswod = !hideconfirmPasswod;
                                  });
                                },
                                child: Icon(
                                  (hideconfirmPasswod)
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 3),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              labelText: 'Confirm Password',
                              hintText: "********",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      child: Text(
                        'Reset password',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: 50,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      shape: StadiumBorder(),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: Duration(microseconds: 400),
                          child: (loginmod)
                              ? Text(
                                  'Login',
                                  key: UniqueKey(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : Text(
                                  'Register',
                                  key: UniqueKey(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                        ),
                      ),
                      color: Colors.black,
                      onPressed: () {}),
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: (loginmod)
                        // ignore: deprecated_member_use
                        ? FlatButton(
                            key: UniqueKey(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Dont Have An Account ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Reister',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                            onPressed: () {
                              // currentContext  بيشيل كل المعلومات عن اي حاجه
                              final c = field.currentContext;
                              final box = c.findRenderObject() as RenderBox;

                              setState(() {
                                height = box.size.height;
                                loginmod = !loginmod;
                              });
                            },
                          )
                        // ignore: deprecated_member_use
                        : FlatButton(
                            key: UniqueKey(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already Have An Account ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                height = 0;
                                loginmod = !loginmod;
                              });
                            },
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
