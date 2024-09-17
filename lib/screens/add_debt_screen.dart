import 'package:celes_store_magic/providers/db_provider.dart';
import 'package:flutter/material.dart';


class AddDebtScreen extends StatefulWidget {
  @override
  _AddDebtScreenState createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends State<AddDebtScreen> {
  List<Map<String, dynamic>> clients = [];
  List<Map<String, dynamic>> filteredClients = [];

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  // Cargar la lista de clientes desde la base de datos
  void _loadClients() async {
    final db = DBProvider();
    List<Map<String, dynamic>> clientList = await db.database.then((db) {
      return db.query('clientes');
    });

    setState(() {
      clients = clientList;
      filteredClients = clients; // Inicialmente mostrar todos los clientes
    });
  }

  // Filtrar la lista de clientes según la búsqueda
  void _filterClients(String searchTerm) {
    setState(() {
      filteredClients = clients
          .where((client) =>
              client["nombre"].toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  // Mostrar el modal para agregar deuda
  void _showAddDebtDialog(int clienteId, String clientName) {
    String debtAmount = '';
    String debtDescription = '';

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Agregar Deuda a $clientName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Monto de la Deuda'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debtAmount = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Descripción'),
                onChanged: (value) {
                  debtDescription = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (debtAmount.isNotEmpty) {
                  _addDebt(clienteId, double.parse(debtAmount), debtDescription);
                  Navigator.of(ctx).pop();
                }
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  // Método para agregar una deuda en la base de datos
  void _addDebt(int clienteId, double amount, String description) async {
    final db = DBProvider();

    // Insertar la deuda en la tabla deudas
    await db.database.then((db) {
      db.insert('deudas', {
        'cliente_id': clienteId,
        'monto': amount,
        'descripcion': description,
        'fecha': DateTime.now().toString().split(' ')[0], // Fecha actual
      });
    });

    // Ya no es necesario actualizar manualmente la deuda_total
    _loadClients(); // Recargar la lista de clientes después de agregar la deuda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Deuda'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar Cliente',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _filterClients(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredClients.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(filteredClients[index]['nombre']),
                  subtitle: Text('Debe: \$${filteredClients[index]['deuda_total']}'),
                  onTap: () {
                    _showAddDebtDialog(
                      filteredClients[index]['id'],
                      filteredClients[index]['nombre'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
