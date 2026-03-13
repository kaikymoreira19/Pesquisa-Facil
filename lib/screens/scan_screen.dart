import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../database/database_helper.dart';
import 'produto_encontrado_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escanear Produto"),
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) async {
  if (!_isScanning) return;

  final List<Barcode> barcodes = capture.barcodes;

  for (final barcode in barcodes) {
    final String? code = barcode.rawValue;

    if (code != null) {
      setState(() {
        _isScanning = false;
      });

      final produto = await DatabaseHelper.instance
          .buscarProdutoPorCodigo(code);

      if (!mounted) return;

      if (produto != null) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          ProdutoEncontradoScreen(produto: produto),
    ),
  );
} else {
        Navigator.pushNamed(
          context,
          '/product_form',
          arguments: code,
        );
      }

      break;
    }
  }
},
          ),

          // Caixa visual no meio da tela
          Center(
            child: Container(
              width: 250,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}