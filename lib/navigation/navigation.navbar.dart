import 'package:apiflutter/screens/screens.teladelete.dart';
import 'package:apiflutter/screens/screens.telaget.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  //lógica aq
  int indexAtual = 0; // variavel para ver qual tela está selecionada

  List pages = [ //lista para armazenar as paginas
    TelaGet(),
    TelaDelete()
  ];

void mudarIndex(int novoIndex){ // função para mudar a tela
  setState(() {
    indexAtual = novoIndex;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(indexAtual),
      bottomNavigationBar: BottomNavigationBar(items:  [
        BottomNavigationBarItem(icon:Icon(Icons.get_app), label: 'Get'),
        BottomNavigationBarItem(icon:Icon(Icons.delete), label: 'Delete')
      ],
      currentIndex: indexAtual,
      onTap: mudarIndex,
      ),
    );
  }
}