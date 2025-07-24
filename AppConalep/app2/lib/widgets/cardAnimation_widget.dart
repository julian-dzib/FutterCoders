import 'package:flutter/material.dart';

/// Widget de tarjeta genérica para mostrar un modelo con opción de eliminar.
/// - [title]: título principal.
/// - [subtitle]: texto secundario (ej. descripción).
/// - [details]: lista de pares clave-valor para mostrar detalles.
/// - [onDelete]: función que se ejecuta al deslizar o eliminar.
class CardanimationWidget extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final Map<String, String> details;
  final VoidCallback onDelete;
  //Definir ootro callback 
  final VoidCallback onUpdate;
  final VoidCallback onTap;


  const CardanimationWidget({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.details,
    required this.onDelete,
    required this.onUpdate,
    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.horizontal,
      background: _fondo(
        color: Colors.green.shade600,
        icon: Icons.edit,
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: _fondo(
        color: Colors.red.shade600,
        icon: Icons.delete,
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onUpdate();
          return false;
        } else if (direction == DismissDirection.endToStart) {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Confirmar eliminación"),
              content: const Text("¿Deseas eliminar este elemento?"),
              actions: [
                ElevatedButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text("Cancelar")),
                ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text("Eliminar")),
              ],
            ),
          );
          return confirm ?? false;
        }
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      //Es un widget de Flutter que permite detectar gestos táctiles (como toques, doble toques o presiones largas) 
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 4,
                  children: details.entries.map((e) {
                    return Chip(
                      label: Text("${e.key}: ${e.value}"),
                      backgroundColor: Colors.blueGrey.shade50,
                      labelStyle: Theme.of(context).textTheme.bodySmall,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fondo({
    required Color color,
    required IconData icon,
    required Alignment alignment,
  }) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Icon(icon, color: Colors.white, size: 32),
    );
  }
}
