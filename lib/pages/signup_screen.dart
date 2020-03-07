import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loja_virtual_app/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
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
                      controller: _nomeController,
                      decoration: InputDecoration(hintText: "Nome Completo"),
                      validator: (value){
                        if(value.isEmpty) return "Nome inválido";
                      }
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "E-mail"),
                      validator: (value){
                        if(value.isEmpty || !value.contains("@")) return "E-mail inválido";
                      }
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                      controller: _enderecoController,
                      decoration: InputDecoration(hintText: "Endereço"),
                      validator: (value){
                        if(value.isEmpty) return "Endereço inválido";
                      }
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (value){
                        if(value.isEmpty || value.length < 6) return "senha inválida";
                      }
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text('Criar Conta',style: TextStyle(fontSize: 18.0)),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          Map<String, dynamic> dataUser = {
                            "name": _nomeController.text,
                            "email":_emailController.text,
                            "address": _enderecoController.text
                          };
                          model.signUp(
                              userData: dataUser,
                              pass: _senhaController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
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
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),)
    );

    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }


  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Falha ao criar Usuário"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),)
    );

  }
}

