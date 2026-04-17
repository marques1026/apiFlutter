import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
class TelaPut extends StatefulWidget {
  const TelaPut({super.key});
 
  @override
  State<TelaPut> createState() => _TelaPutState();
}
 
class _TelaPutState extends State<TelaPut> {
  //Code a sua logica aqui
  List listaApi = []; //Lista que ira armazenar os dados da API
  List controladores = []; //Lista que ira armazenar todos os controladores
 
  @override //Garante que toda vez que resetar a pagina o estado inicial é resetado
  //ou seja faz um get novamente
  void initState() { //Funcao do estado inicial do Flutter
  super.initState();
  fazerGet();
  }
 
  void fazerGet() async {
    final respostaServidor = await http.get(Uri.parse("http://10.109.72.23:3000/tasks"));
    if(respostaServidor.statusCode == 200){
      final dados = jsonDecode(respostaServidor.body); //Decodifico os pacotes recebidos do http
    setState(() {
      listaApi = dados;
      for(final item in listaApi){
        //Para cada item da lista , eu adiciono um Controlador 👀😛
        controladores.add(TextEditingController());
      }
    });
    }
  }
 
  void fazerPut(final id, final index) async {//precisa do id do item a ser alterado , precisa do index da lista
   //dos controladores para subir o valor novo.
   final respostaServidor = await http.patch(Uri.parse("http://10.109.72.23:3000/tasks/$id"),
   headers: {"Content-type":"application/json"}, //declaro qual tipo de conteúdo estou subindo na requisição
   body: jsonEncode({
    "title": controladores[index].text
   }));
   if (respostaServidor.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Dado alterado com sucesso")));
   }
   fazerGet();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Put/Patch")),
      body: ListView(
        children: [
          for(final item in listaApi)
          Card(
            child: ListTile(
              title: Text(item["title"]),
              subtitle: TextField(
                controller: controladores[listaApi.indexOf(item)]
              ),
              trailing: GestureDetector(
                onTap: () => fazerPut(item["id"], listaApi.indexOf(item)),
                child: Icon(Icons.edit),
              ),
            )
          )
        ],
      )
    );
  }
}