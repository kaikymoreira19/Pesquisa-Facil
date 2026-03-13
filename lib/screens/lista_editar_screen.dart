import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'editar_produto_screen.dart';

class ListaEditarScreen extends StatefulWidget {
  const ListaEditarScreen({super.key});

  @override
  State<ListaEditarScreen> createState() => _ListaEditarScreenState();
}

class _ListaEditarScreenState extends State<ListaEditarScreen> {
  List<Map<String, dynamic>> produtos = [];

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    final lista = await DatabaseHelper.instance.getAllProdutos();
    setState(() {
      produtos = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar Produto')),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return ListTile(
            title: Text(produto['nome']),
            subtitle: Text('R\$ ${produto['preco']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditarProdutoScreen(produto: produto),
                ),
              ).then((_) => carregarProdutos());
            },
          );
        },
      ),
    );
  }
}