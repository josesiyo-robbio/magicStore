import 'package:celes_store_magic/providers/db_provider.dart';
import 'package:flutter/material.dart';



class ClientHistoryScreen extends StatefulWidget 
{
  final int clienteId;

  ClientHistoryScreen({required this.clienteId});

  @override
  _ClientHistoryScreenState createState() => _ClientHistoryScreenState();
}

class _ClientHistoryScreenState extends State<ClientHistoryScreen> 
{
  List<Map<String, dynamic>> deudas = [];
  List<Map<String, dynamic>> pagos = [];

  @override
  void initState() 
  {
    super.initState();
    _loadClientHistory();
  }


  // Cargar deudas y pagos para el cliente seleccionado
  void _loadClientHistory() async 
  {
    final db = DBProvider();

    // Cargar deudas del cliente
    List<Map<String, dynamic>> deudasList = await db.database.then((db) 
    {
      return db.rawQuery('''
        SELECT monto, descripcion, fecha FROM deudas
        WHERE cliente_id = ?
        ORDER BY fecha ASC
      ''', [widget.clienteId]);
    });

    // Cargar pagos del cliente
    List<Map<String, dynamic>> pagosList = await db.database.then((db) 
    {
      return db.rawQuery('''
        SELECT monto, fecha FROM pagos
        WHERE cliente_id = ?
        ORDER BY fecha ASC
      ''', [widget.clienteId]);
    });

    setState(() 
    {
      deudas = deudasList;
      pagos = pagosList;
    });
  }


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar  : AppBar
      (
        title : Text('Historial Detallado'),
      ),

      body  : SingleChildScrollView
      (
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            Padding
            (
              padding: const EdgeInsets.all(16.0),
              child: Text
              (
                'Deudas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

            ),

            deudas.isEmpty
                ? Padding
                (
                    padding : const EdgeInsets.all(16.0),
                    child   : Text('No se encontraron deudas.'),
                )

                : ListView.builder
                (
                    physics     : NeverScrollableScrollPhysics(), // Para evitar conflictos de scroll
                    shrinkWrap  : true,
                    itemCount   : deudas.length,
                    itemBuilder : (ctx, index) 
                    {
                      return ListTile
                      (
                        title     : Text('Monto: \$${deudas[index]['monto']}'),
                        subtitle  : Column
                        (
                          crossAxisAlignment  : CrossAxisAlignment.start,
                          children  : 
                          [
                            Text('Descripción: ${deudas[index]['descripcion']}'),
                            Text('Fecha: ${deudas[index]['fecha']}'),
                          ],
                        ),

                      );

                    },
                  
                ),

            Padding
            (
              padding :   const EdgeInsets.all(16.0),
              child   :   Text
              (
                'Pagos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

            ),

            pagos.isEmpty
                ? Padding
                (
                    padding : const EdgeInsets.all(16.0),
                    child   : Text('No se encontraron pagos.'),
                )

                : ListView.builder
                (
                    physics     : NeverScrollableScrollPhysics(),
                    shrinkWrap  : true,
                    itemCount   : pagos.length,
                    itemBuilder : (ctx, index) 
                    {
                      return ListTile
                      (
                        title       :   Text('Monto: \$${pagos[index]['monto']}'),
                        subtitle    :   Text('Fecha: ${pagos[index]['fecha']}'),
                      );
                    },
                ),

          ],
        ),

      ),
      
    );

  }
}
