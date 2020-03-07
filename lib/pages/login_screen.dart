import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_app/model/user_model.dart';
import 'package:loja_virtual_app/pages/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text('CRIAR CONTA', style: TextStyle(fontSize: 15.0),),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key:  _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "E-mail"),
                    validator: (value){
                      if(value.isEmpty || !value.contains("@")) return "E-mail inválido"; else return "";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (value){
                      if(value.isEmpty || value.length < 6) return "senha inválida"; else return "";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        _recuperarEmail(model, _emailController.text);
                      },
                      child: Text('Esqueci minha senha', textAlign: TextAlign.right,),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text('Entrar',style: TextStyle(fontSize: 18.0),),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                        }
                        model.signIn(
                            email: _emailController.text,
                            pass: _senhaController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSuccess(){
      Navigator.of(context).pop();
  }


  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Falha ao logar Usuário"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),)
    );

  }

  void _recuperarEmail(model, String email){

    if(email.isEmpty){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Insira seu e-mail para recuperação"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),)
      );
    }else{
      model.recoverPassword(email);

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Confira seu email!"),
            backgroundColor: Theme.of(context).primaryColor,
            duration: Duration(seconds: 2),)
      );

    }
  }
}
