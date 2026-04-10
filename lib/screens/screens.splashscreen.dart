import 'package:apiflutter/navigation/navigation.navbar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // aqui coda a lógica
  @override // garante que a função reseta toda vez q inciar o app
  void initState(){
    super.initState();
    Future.delayed(// espera 2 segundos e dps realiza uma ação
    Duration(seconds: 2),
    (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Navbar()));
    }
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(210, 161, 227, 247), // Define a cor azul
      body:Center(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task,size: 80),
          Text("App Tasks da Gi"),
          Divider(indent: 20, endIndent: 20),
          Text("Bem vindo ao App de Gerenciamento de Tarefas")
        ],
      )
      )
    );
  }
}
