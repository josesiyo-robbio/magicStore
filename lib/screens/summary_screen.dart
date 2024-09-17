import 'package:celes_store_magic/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'client_history_screen.dart'; // Importamos la pantalla de historial

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<Map<String, dynamic>> clients = [];

  @override
  void initState() {
    super.initState();
    _loadClientsSummary();
  }

  // Cargar el resumen de los clientes desde la base de datos
  void _loadClientsSummary() async {
    final db = DBProvider();
    List<Map<String, dynamic>> clientList = await db.database.then((db) {
      return db.rawQuery('''
        SELECT clientes.id, clientes.nombre, clientes.deuda_total,
          (SELECT COUNT(*) FROM deudas WHERE deudas.cliente_id = clientes.id) AS total_deudas,
          (SELECT COUNT(*) FROM pagos WHERE pagos.cliente_id = clientes.id) AS total_pagos
        FROM clientes
      ''');
    });

    setState(() {
      clients = clientList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumen / Historial'),
      ),
      body: clients.isEmpty
          ? Center(child: CircularProgressIndicator()) // Muestra un spinner mientras se cargan los datos
          : ListView.builder(
              itemCount: clients.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(clients[index]['nombre']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deuda Total: \$${clients[index]['deuda_total']}'),
                      Text('Total de Deudas: ${clients[index]['total_deudas']}'),
                      Text('Total de Pagos: ${clients[index]['total_pagos']}'),
                    ],
                  ),
                  onTap: () {
                    // Navegar al historial detallado al hacer clic en el cliente
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientHistoryScreen(
                          clienteId: clients[index]['id'], // Pasar el ID del cliente
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
