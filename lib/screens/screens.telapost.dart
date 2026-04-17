import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
class TelaPost extends StatefulWidget {
  const TelaPost({super.key});
 
  @override
  State<TelaPost> createState() => _TelaPostState();
}
 
class _TelaPostState extends State<TelaPost> {
  //Variavel que observa o que o usuario digita 👀 🚀🚀
  TextEditingController valorDigitado = TextEditingController(); //Agora vai funcionar
 
  void fazerPost() async {
    final respostaServidor = await http.post(Uri.parse("https://arquivoapiflutter.onrender.com/tasks"),
    headers: {"Content-Type": "application/json"}, //Estou enviando um json para o POST
    body: jsonEncode({
      "title": valorDigitado.text //O novo registro da API receberá no campo Title o valor digitado
    })
    );
    if(respostaServidor.statusCode == 201 || respostaServidor.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dado enviado com sucesso"))
      );
    }
 
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Tela Post")),
      body: Center(
        child: Column(
          children: [
            TextField(controller: valorDigitado,),
            TextButton(onPressed: fazerPost, child: Text("Adicionar Dado"))
          ],
        )
      )
    );
  }
}