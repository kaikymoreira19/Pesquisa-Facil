import 'package:flutter/material.dart';
import 'dart:io';

class ProdutoEncontradoScreen extends StatelessWidget {

  final Map produto;

  const ProdutoEncontradoScreen({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produto Encontrado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            if (produto['imagem'] != null)
              Image.file(
                File(produto['imagem']),
                height: 200,
              ),

            const SizedBox(height: 20),

            Text(
              produto['nome'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "R\$ ${produto['preco']}",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/editar_produto',
                  arguments: produto,
                );
              },
              child: const Text("Editar"),
            ),
          ],
        ),
      ),
    );
  }
}