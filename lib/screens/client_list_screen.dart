import 'package:celes_store_magic/providers/db_provider.dart';
import 'package:flutter/material.dart';


class ClientListScreen extends StatefulWidget {
  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  List<Map<String, dynamic>> clients = [];
  List<Map<String, dynamic>> filteredClients = [];

  @override
  void initState() {
    super.initState();
    _loadClients();  // Cargar clientes desde la base de datos
  }

  // Método para cargar los clientes desde la base de datos
  void _loadClients() async {
    final db = DBProvider();  // Instancia del DBProvider
    List<Map<String, dynamic>> clientList = await db.database.then((db) {
      return db.query('clientes');
    });

    setState(() {
      clients = clientList;
      filteredClients = clients; // Inicialmente mostrar todos los clientes
    });
  }

  // Método para agregar un nuevo cliente
  void _addNewClient(String name, double debt) async {
    final db = DBProvider();
    await db.database.then((db) {
      db.insert('clientes', {
        'nombre': name,
        'deuda_total': debt,
        'telefono': null, // Puedes agregar un teléfono si lo deseas
      });
    });
    _loadClients(); // Recargar la lista de clientes después de agregar uno nuevo
  }

  // Método para filtrar los clientes según la búsqueda
  void _filterClients(String searchTerm) {
    setState(() {
      filteredClients = clients
          .where((client) =>
              client["nombre"].toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  // Formulario para agregar un cliente
  void _showAddClientDialog() {
    String clientName = '';
    String clientDebt = '';

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Agregar Nuevo Cliente'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre del Cliente'),
                onChanged: (value) {
                  clientName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Deuda Inicial'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  clientDebt = value;
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
                if (clientName.isNotEmpty && clientDebt.isNotEmpty) {
                  _addNewClient(clientName, double.parse(clientDebt));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
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
  title: Text(
    filteredClients[index]['nombre'] != null ? filteredClients[index]['nombre'] : 'Sin nombre',
  ),
  subtitle: Text(
    'Debe: \$${filteredClients[index]['deuda_total'] != null ? filteredClients[index]['deuda_total'] : 0.0}',
  ),
                  onTap: () {
                    // Aquí podrías navegar al detalle del cliente
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddClientDialog,
        child: Icon(Icons.add),
        tooltip: 'Agregar Cliente',
      ),
    );
  }
}

