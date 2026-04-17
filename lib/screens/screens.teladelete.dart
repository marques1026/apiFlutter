import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 
class TelaDelete extends StatefulWidget {
  const TelaDelete({super.key});
 
  @override
  State<TelaDelete> createState() => _TelaDeleteState();
}
 
class _TelaDeleteState extends State<TelaDelete> {
 
  List listaApi = [];
 
  @override
  void initState() {
    super.initState();
    fazerGet();
  }
 
  void fazerGet() async {
    final respostaServidor = await http.get(
      Uri.parse("http://10.109.72.23:3000/tasks"),
    );
 
    if (respostaServidor.statusCode == 200) {
      final dados = jsonDecode(respostaServidor.body);
 
      setState(() {
        listaApi = dados;
      });
    }
  }       
 
  void fazerDelete(final id) async {
    final respostaServidor = await http.delete(
      Uri.parse("http://10.109.72.23:3000/tasks/$id"),
    );
 
    if (respostaServidor.statusCode == 200) {
      fazerGet();
 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Dado deletado com sucesso"),
          backgroundColor: Color(0xFF5D4037),
        ),
      );
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEBE9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Deletar Tarefas", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xFF5D4037),
      ),
      body: listaApi.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6D4C41),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                for (final item in listaApi)
                  Card(
                    color: const Color(0xFFD7CCC8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      title: Text(
                        item["title"] ?? "Sem título",
                        style: const TextStyle(
                          color: Color(0xFF3E2723),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () => _confirmarDelete(item["id"]),
                        child: const Icon(
                          Icons.delete,
                          color: Color(0xFF8D6E63),
                        ),
                      ),
                    ),
                  ),
 
                const SizedBox(height: 20),
 
                const Center(
                  child: Text(
                    "Você chegou ao final da lista :)",
                    style: TextStyle(
                      color: Color(0xFF6D4C41),
                    ),
                  ),
                )
              ],
            ),
    );
  }
 
 
  void _confirmarDelete(id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFEFEBE9),
        title: const Text(
          "Confirmar exclusão",
          style: TextStyle(color: Color(0xFF3E2723)),
        ),
        content: const Text(
          "Tem certeza que deseja deletar?",
          style: TextStyle(color: Color(0xFF5D4037)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              fazerDelete(id);
            },
            child: const Text(
              "Deletar",
              style: TextStyle(color: Color(0xFF5D4037)),
            ),
          ),
        ],
      ),
    );
  }
}