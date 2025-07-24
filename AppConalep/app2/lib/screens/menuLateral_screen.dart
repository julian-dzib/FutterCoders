// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:app2/widgets/buttonIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class MenuLateralScreen extends StatefulWidget {
  const MenuLateralScreen({super.key});

  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateralScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/flutter_logo.png',
                ),
              ),
              ListTile(
                onTap: () async {
                    _advancedDrawerController.hideDrawer(); // Oculta el drawer
                    await Future.delayed(Duration(milliseconds: 300)); // Espera la animación
                    Navigator.of(context).pushNamed('/camera'); // Navega
                },
                leading: Icon(Icons.home),
                title: Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  Navigator.of(context).pushNamed('/reco');
                },
                leading: Icon(Icons.account_circle_rounded),
                title: Text('Reconocimiento'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),


              ExpansionTile(
                  leading: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/camera.png'),
                  ) ,
                  title: Text('InicioHome'),

                  children: [
                    ListTile(
                      leading: Icon(Icons.add),
                      title: Text("SubMenu"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/ejem');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.add),
                      title: Text("Submenu2"),
                      onTap: () {
                        Navigator.of(context).pushNamed('/ejem3');
                      },
                    ),
                  ],
                ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Drawer Example'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Semantics(
                    label: 'Menu',
                    onTapHint: 'expand drawer',
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        body: Container(),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}