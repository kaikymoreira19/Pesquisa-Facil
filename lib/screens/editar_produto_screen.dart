import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class EditarProdutoScreen extends StatefulWidget {
  final Map<String, dynamic> produto;

  const EditarProdutoScreen({super.key, required this.produto});

  @override
  State<EditarProdutoScreen> createState() => _EditarProdutoScreenState();
}

class _EditarProdutoScreenState extends State<EditarProdutoScreen> {
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.produto['nome'];
    _precoController.text = widget.produto['preco'].toString();
  }

  Future<void> _salvar() async {
    await DatabaseHelper.instance.updateProduto({
      'id': widget.produto['id'],
      'codigo': widget.produto['codigo'],
      'nome': _nomeController.text,
      'preco': double.tryParse(_precoController.text) ?? 0.0,
      'imagem': widget.produto['imagem'], // importante
    });

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvar,
              child: const Text('Salvar Alterações'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await DatabaseHelper.instance.deleteProduto(
                  widget.produto['id'],
                );

                if (!mounted) return;
                Navigator.pop(context);
              },
              child: const Text('Excluir Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
