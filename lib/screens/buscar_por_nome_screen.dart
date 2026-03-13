import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'dart:io';

class BuscarPorNomeScreen extends StatefulWidget {
  const BuscarPorNomeScreen({super.key});

  @override
  State<BuscarPorNomeScreen> createState() => _BuscarPorNomeScreenState();
}

class _BuscarPorNomeScreenState extends State<BuscarPorNomeScreen> {

  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> resultados = [];

  Future<void> buscar() async {
    final lista = await DatabaseHelper.instance
        .buscarProdutoPorNome(_controller.text);

    setState(() {
      resultados = lista;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar por Nome"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Digite o nome do produto",
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: buscar,
              child: const Text("Buscar"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: resultados.length,
                itemBuilder: (context, index) {

                  final produto = resultados[index];

                  return ListTile(

                    leading: produto['imagem'] != null
                        ? Image.file(
                            File(produto['imagem']),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image),

                    title: Text(produto['nome']),

                    subtitle: Text("R\$ ${produto['preco']}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}