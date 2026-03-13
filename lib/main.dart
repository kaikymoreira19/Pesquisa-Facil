import 'package:flutter/material.dart';

import 'screens/buscar_por_nome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cadastro_screen.dart';
import 'screens/buscar_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/product_form_screen.dart';
import 'screens/lista_editar_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pesquisa Fácil',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const HomeScreen(),
        '/scan': (context) => const ScanScreen(),
        '/product_form': (context) => const ProductFormScreen(),
        '/cadastro': (context) => const CadastroScreen(),
        '/buscar': (context) => const BuscarScreen(),
        '/lista_editar': (context) => const ListaEditarScreen(),
        '/buscar_nome': (context) => const BuscarPorNomeScreen(),
      },
    );
  }
}