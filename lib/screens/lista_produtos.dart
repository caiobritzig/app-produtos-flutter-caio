import 'package:flutter/material.dart';
import '../models/produto.dart';
import 'cadastro_produto.dart';
import 'detalhe_produto.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  final List<Produto> produtos = [];

  Future<void> _irParaCadastro() async {
    final Produto? novoProduto = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CadastroProduto(),
      ),
    );

    if (novoProduto != null) {
      setState(() {
        produtos.add(novoProduto);
      });
    }
  }

  void _abrirDetalhes(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalheProduto(produto: produto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
      ),
      body: produtos.isEmpty
          ? const Center(
              child: Text('Nenhum produto cadastrado'),
            )
          : ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];

                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
                  onTap: () => _abrirDetalhes(produto),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _irParaCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}