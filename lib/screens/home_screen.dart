import 'package:celes_store_magic/screens/add_debt_screen.dart';
import 'package:celes_store_magic/screens/client_list_screen.dart';
import 'package:celes_store_magic/screens/register_payment_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio - Tiendita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientListScreen()),
                );
              },
              icon: Icon(Icons.people), // Icono para Lista de Clientes
              label: Text('Lista de Clientes'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {
                                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDebtScreen()),
                );
              },
              icon: Icon(Icons.add_shopping_cart), // Icono para Agregar Deuda
              label: Text('Agregar Deuda'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {
                // Navegar a la pantalla de Registrar Pago
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPaymentScreen()),
                );
              },
              icon: Icon(Icons.payment), // Icono para Registrar Pago
              label: Text('Registrar Pago'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {
                // Navegar a la pantalla de Resumen/Historial
              },
              icon: Icon(Icons.history), // Icono para Ver Resumen/Historial
              label: Text('Ver Resumen/Historial'),
            ),
          ],
        ),
      ),
    );
  }
}
