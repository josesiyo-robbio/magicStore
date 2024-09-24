
# 📦 CelesStoreMagic - Gestión de Fiados para Tiendas Locales 🏪

### Aplicación para gestionar fiados y pagos en tiendas locales de México

![CelesStoreMagic App](./assets/images/preview.png) <!-- Puedes agregar capturas de pantalla si tienes imágenes -->

---

## 🚀 Descripción

**CelesStoreMagic** es una aplicación móvil diseñada para reemplazar las libretas físicas que las tiendas locales en México utilizan para registrar los fiados de sus clientes. Con esta app, los dueños de tiendas pueden llevar un control digital de las deudas, pagos y estados financieros de los clientes de manera fácil y rápida. 

La app permite:
- 📝 Registrar deudas a los clientes.
- 💸 Registrar pagos realizados por los clientes.
- 📊 Consultar un historial detallado de transacciones (deudas y pagos).
- 🔍 Buscar clientes de forma rápida para facilitar el registro de nuevas operaciones.

---

## 🛠️ Características

- **Gestión de clientes**: Lista de clientes donde se pueden registrar nuevas deudas o pagos.
- **Resumen de deudas**: Consulta rápida de la deuda total por cliente y el número de pagos registrados.
- **Historial detallado**: Visualización completa de todas las transacciones, con fechas y montos.
- **Interfaz amigable**: Una UI diseñada para ser simple y rápida, adecuada para usuarios no técnicos.
- **Compatibilidad con SQLite**: Toda la información se guarda de manera local, sin necesidad de conexión a internet.

---

## 🎯 Objetivo

El objetivo principal de **CelesStoreMagic** es digitalizar el proceso de manejo de deudas en tiendas locales, facilitando la gestión de clientes y mejorando la eficiencia en el control de pagos, evitando el uso de libretas físicas que pueden perderse o dañarse.

---

## 📱 Capturas de pantalla

> **Pantalla Principal**  
![Pantalla Principal](./assets/images/screen1.png)  

> **Registro de Deudas y Pagos**  
![Registro de Deudas](./assets/images/screen2.png)  

> **Historial de Transacciones**  
![Historial](./assets/images/screen3.png)  

---

## 🚧 Funcionalidades en desarrollo

- [ ] Notificaciones para recordar el pago a los clientes.
- [ ] Exportar los datos en formato PDF o Excel.
- [ ] Soporte multi-usuario (para varias tiendas).
- [ ] Gráficos y estadísticas financieras.

---

## 🔧 Estructura del Proyecto

El proyecto sigue una estructura organizada para facilitar el desarrollo y el mantenimiento. Aquí está una breve descripción de las carpetas clave:

- **lib/screens**: Contiene todas las pantallas de la app (pantalla de clientes, historial, agregar deuda, etc.).
- **lib/widgets**: Widgets personalizados reutilizables en la interfaz.
- **lib/providers**: Archivos relacionados con la base de datos y la gestión de datos (SQLite).
- **lib/services**: Funciones o servicios que se reutilizan a lo largo de la app.

---

## 📦 Instalación

### Requisitos

- Flutter 2.x o superior
- Xcode (para iOS)
- Android Studio (para Android)
- Dispositivo físico o emulador

### Pasos para ejecutar la app:

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tuusuario/celes_store_magic.git
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Conecta un dispositivo o abre un emulador.

4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

---

## 🚀 Compilación en iOS

Para compilar la app en iOS y ejecutarla en un dispositivo, sigue los siguientes pasos:

1. Abre el proyecto en Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Asegúrate de seleccionar tu dispositivo de destino y un equipo de desarrollo válido.

3. Compila y ejecuta la app con `Cmd + R`.

---

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework principal de la app.
- **SQLite**: Base de datos local para almacenar la información de clientes, deudas y pagos.
- **Dart**: Lenguaje de programación utilizado para desarrollar la app.

---

## 🏆 Créditos

**CelesStoreMagic** fue creado con mucho 💙 por mi como una solución digital para facilitar el manejo de fiados en tiendas locales.

---

## 📄 Licencia

Este proyecto está bajo la **Licencia MIT**. Consulta el archivo [LICENSE](./LICENSE) para más detalles.

---

## 🤝 Contribuciones

¡Contribuciones, reportes de errores y sugerencias son bienvenidos! Si deseas contribuir, por favor sigue estos pasos:

1. Haz un fork del proyecto.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza los cambios y commitea (`git commit -am 'Añadir nueva funcionalidad'`).
4. Sube los cambios a tu fork (`git push origin feature/nueva-funcionalidad`).
5. Abre un **Pull Request**.

---

¡Gracias por usar **CelesStoreMagic**! 😊 Si te ha gustado este proyecto, no dudes en darle una ⭐ en GitHub y compartirlo con otros.
