import 'package:app2/widgets/button_widget.dart';
import 'package:app2/widgets/calendar_widget.dart';
import 'package:app2/widgets/textField_widget.dart';
import 'package:app2/widgets/time_widget.dart';
import 'package:flutter/material.dart';

class FeymanScreen extends StatefulWidget {
  const FeymanScreen({super.key});

  @override
  State<FeymanScreen> createState() => _FeymanScreenState();
}

class _FeymanScreenState extends State<FeymanScreen> {
  // Controladores de texto
  final tituloController = TextEditingController();
  final temaController = TextEditingController();
  final explicacionController = TextEditingController();
  final dudasController = TextEditingController();
  final ejemplosController = TextEditingController();

  // Fecha y hora por defecto
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // Métodos para seleccionar fecha y hora
  Future<void> _selectDate() async {
  final DateTime? picked = await showDatePicker(
    //muestra un cuadro de dialogo
    context: context,
    //la fecha que aparece inicialmente seleccionada (la que el usuario eligió antes o la actual).
    initialDate: selectedDate,
    //la fecha mínima que puede seleccionar el usuario (año 2023).
    firstDate: DateTime(2023),
    //la fecha máxima que puede seleccionar (año 2101).
    lastDate: DateTime(2101),
  );
  //Usuario cancela la seleccion
  if (picked != null) {
    setState(() {
      //La fecha seleccionada se guarda en picked.
      selectedDate = picked;
    });
  }
}


  Future<void> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(
          context: context, 
          initialTime: selectedTime
        );
    if (picked != null) setState(() => selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva entrada')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Botón superior
            ButtonWidget(
              text: "Agregar nueva entrada",
              onPressed: () {
                // acción personalizada
              },
            ),
            const SizedBox(height: 20),

            // Campos de entrada usando InputField genérico
            TextfieldWidget(label: "Título", controller: tituloController),
            TextfieldWidget(label: "Selecciona el tema que deseas aprender", controller: temaController),
            TextfieldWidget(label: "Explícalo con tus propias palabras",controller: explicacionController,maxLines: 4,),
            TextfieldWidget(label: "Identifica tus dudas",controller: dudasController,maxLines: 3,),
            TextfieldWidget(label: "Ejemplos o analogías",controller: ejemplosController,maxLines: 3, ),

            // Fecha y hora (no son genéricos aún)
            const SizedBox(height: 10),
    // Fecha y hora (widgets genéricos)
    const SizedBox(height: 10),
    CalendarWidget(
      selectedDate: selectedDate,
      onTap: _selectDate,
    
    ),


    TimePickerWidget(
      selectedTime: selectedTime,
      onTap: _selectTime,
    ),

            const SizedBox(height: 30),

            // Botón final
            ButtonWidget(
              text: "Confirmar entrada",
              onPressed: () {
                // acción personalizada
              },
            ),
          ],
        ),
      ),
    );
  }
}
