import 'package:celes_store_magic/providers/db_provider.dart';
import 'package:flutter/material.dart';


class RegisterPaymentScreen extends StatefulWidget 
{
  @override
  _RegisterPaymentScreenState createState() => _RegisterPaymentScreenState();
}

class _RegisterPaymentScreenState extends State<RegisterPaymentScreen> 
{
  List<Map<String, dynamic>> clients = [];
  List<Map<String, dynamic>> filteredClients = [];

  @override
  void initState() 
  {
    super.initState();
    _loadClients();
  }


  // Cargar la lista de clientes desde la base de datos
  void _loadClients() async 
  {
    final db = DBProvider();
    List<Map<String, dynamic>> clientList = await db.database.then((db) 
    {
      return db.query('clientes');
    });

    setState(() 
    {
      clients = clientList;
      filteredClients = clients; // Inicialmente mostrar todos los clientes
    });
  }


  // Filtrar la lista de clientes según la búsqueda
  void _filterClients(String searchTerm) 
  {
    setState(() 
    {
      filteredClients = clients
          .where((client) =>
              client["nombre"].toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }


  // Mostrar el modal para registrar un pago
  void _showRegisterPaymentDialog(int clienteId, String clientName) 
  {
    String paymentAmount = '';

    showDialog
    (
      context: context,
      builder: (ctx) 
      {
        return AlertDialog
        (
          title   : Text('Registrar Pago para $clientName'),
          content : Column
          (
            mainAxisSize: MainAxisSize.min,
            children: 
            [
              TextField
              (
                decoration: InputDecoration(labelText: 'Monto del Pago'),
                keyboardType: TextInputType.number,
                onChanged: (value) 
                {
                  paymentAmount = value;
                },
              ),

            ],
          ),

          actions: 
          [
            TextButton
            (
              onPressed: () 
              {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancelar'),
            ),

            ElevatedButton
            (
              onPressed: () 
              {
                if (paymentAmount.isNotEmpty) 
                {
                  _registerPayment(clienteId, double.parse(paymentAmount));
                  Navigator.of(ctx).pop();
                }
              },
              child: Text('Registrar'),
            ),

          ],
        );

      },
    );
  }


  // Método para registrar el pago en la base de datos
  void _registerPayment(int clienteId, double amount) async 
  {
    final db = DBProvider();

    // Insertar el pago en la tabla pagos
    await db.database.then((db) 
    {
      db.insert('pagos', 
      {
        'cliente_id'  :   clienteId,
        'monto'       :   amount,
        'fecha'       :   DateTime.now().toString().split(' ')[0], // Fecha actual
      });
    });

    // Ya no es necesario actualizar manualmente la deuda_total
    _loadClients(); // Recargar la lista de clientes después de registrar el pago
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar  : AppBar
      (
        title : Text('Registrar Pago'),
      ),

      body  : Column
      (
        children: 
        [
          Padding
          (
            padding: const EdgeInsets.all(16.0),
            child: TextField
            (
              decoration: InputDecoration
              (
                labelText   :   'Buscar Cliente',
                prefixIcon  :   Icon(Icons.search),
                border      :   OutlineInputBorder(),
              ),

              onChanged: (value) 
              {
                _filterClients(value);
              },
            ),

          ),

          Expanded
          (
            child : ListView.builder
            (
              itemCount   : filteredClients.length,
              itemBuilder : (ctx, index) 
              {
                return ListTile
                (
                  title     :   Text(filteredClients[index]['nombre']),
                  subtitle  :   Text('Debe: \$${filteredClients[index]['deuda_total']}'),
                  onTap: () 
                  {
                    _showRegisterPaymentDialog
                    (
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
