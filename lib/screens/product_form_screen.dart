import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {

  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();

  File? _imagem;

  // 📸 Tirar foto
  Future<void> _tirarFoto() async {
    final picker = ImagePicker();

    final XFile? foto =
        await picker.pickImage(source: ImageSource.camera);

    if (foto != null) {
      setState(() {
        _imagem = File(foto.path);
      });
    }
  }

  // 💾 Salvar produto
  Future<void> _salvarProduto(String codigo) async {

    final db = await DatabaseHelper.instance.database;

    await db.insert('products', {
      'codigo': codigo,
      'nome': _nomeController.text,
      'preco': double.tryParse(_precoController.text) ?? 0.0,
      'imagem': _imagem?.path, // 👈 salva caminho da imagem
    });

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produto salvo com sucesso!")),
    );
  }

  @override
  Widget build(BuildContext context) {

    final String codigo =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text("Código: $codigo"),

            const SizedBox(height: 20),

            // Nome
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: "Nome do Produto",
              ),
            ),

            const SizedBox(height: 10),

            // Preço
            TextField(
              controller: _precoController,
              decoration: const InputDecoration(
                labelText: "Preço",
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            // 📸 Botão foto
            ElevatedButton(
              onPressed: _tirarFoto,
              child: const Text("Adicionar Foto"),
            ),

            const SizedBox(height: 10),

            // 👁 Preview da imagem
            _imagem != null
                ? Image.file(
                    _imagem!,
                    height: 150,
                  )
                : const Text("Nenhuma imagem selecionada"),

            const SizedBox(height: 30),

            // 💾 Salvar
            ElevatedButton(
              onPressed: () => _salvarProduto(codigo),
              child: const Text("SALVAR"),
            ),
          ],
        ),
      ),
    );
  }
}