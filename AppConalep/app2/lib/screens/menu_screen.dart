import 'package:app2/screens/camara_screen.dart';
import 'package:app2/screens/cart_screen.dart';
import 'package:app2/screens/reconcimiento_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int indice = 0;
  //bool isCitaSelected = false;

  @override
  Widget build(BuildContext context) {
    //Crear una constante para el color, en lugar de definirlo otra vez
    ////////////const colorMenu = Color.fromARGB(255, 64, 179, 191);
    final screens = [
      //Vista principal
      ReconcimientoScreen(),     
      //Vistas secundarias
      //CartPage(),
      CamaraScreen(),
      CartPage(),
      /////SearchPatientScreen(),
      //ExpedienteScreen(),
      //const User()
      //Ejemplo()
    ];
    return Scaffold(
      //Controlar el cambio de pantalla
      body: IndexedStack(
        index: indice,
        //Para navegar
        children: screens,
      ),
      //Agregarlo en un contenedor para definirle un borde
      bottomNavigationBar: Container(
        //Utilizar box decoration para definir el estilo del borde
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              //Establecerle el color
              ///////color: Color.fromRGBO(171, 165, 165, 1),
              //Agrega un ancho
              width: 1, // Ancho del borde
            ),
          ),
        ),
        //Con bottomNavigationBar establezco el tiempo de boton
        child: BottomNavigationBar(
          //Hacer que el menu se distribuya de manera uniforme
          type: BottomNavigationBarType.fixed,
          currentIndex: indice,
          onTap: (value) {
            setState(() {
              indice = value;
            });
          },
          //Agregar los stilos, estados de los items
          ///////selectedItemColor: colorMenu,
          ///////unselectedItemColor: colorMenu,
          //Agregar las secciones del menu
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
              width: 38,
              height: 38,
              child: Image.asset('assets/reconocimiento.png'),
            ),
            label: 'Reconocimiento',
            tooltip: 'Reconocimiento'
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 38,
                height: 38,
                child: Image.asset('assets/camera.png'),
              ),
            label: 'Camara',  
            tooltip: 'Camara'
  
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 38,
                height: 38,
                child: Image.asset('assets/nosotros.png'),
              ),
            label: 'Nosotros',
            tooltip: 'Sobre Nosotros'

            ),
          ],
        ),
      ),

      /*bottomNavigationBar: Container(
        height: 66,
        width: 390,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colorMenu,
              width: 1,
            ),
          ),
          color: Colors.white,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: indice,
          onTap: (value) {
            setState(() {
              //Cambiar de vista segun el valor seleccionado
              indice = value;
            });
          },
          selectedFontSize: 9,
          unselectedFontSize: 9,
          items: const [
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 41,
                height: 41,
                child: ImageIcon(
                  AssetImage('assets/agenda.png'),
                  color: colorMenu,
                ),
              ),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 41,
                height: 41,
                child: ImageIcon(
                  AssetImage('assets/cita.png'),
                  color:colorMenu,
                ),
              ),
              label: 'Nueva Cita',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 41,
                height: 41,
                child: ImageIcon(
                  AssetImage('assets/expediente.png'),
                  color: colorMenu,
                ),
              ),
              label: 'Expedientes',
            ),
          ],
          selectedItemColor: const Color.fromARGB(255, 64, 179, 191),
          unselectedItemColor: const Color.fromARGB(255, 64, 179, 191),
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),*/
    );
  }
}