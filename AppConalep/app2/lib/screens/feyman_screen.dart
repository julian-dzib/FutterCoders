import 'package:app2/models/feyman_model.dart';
import 'package:app2/services/feyma_service.dart';
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

  //Utilizar mi servicio
  final service = FirestoreService(
    collection: 'feyman', 
    fromMap: FeymanModel.fromMap
  );


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
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null) setState(() => selectedTime = picked);
  }

  Future<void> _post() async{
    try{
      final feyman = FeymanModel(
      id: '', 
      titulo: tituloController.text, 
      tema: temaController.text, 
      explicacion: explicacionController.text, 
      dudas: dudasController.text, 
      ejemplos: ejemplosController.text);
      
      if(validarCampos()){
        await service.post(feyman, feyman.toMap);
        limpiarCampos();
        print("OKEY");

      }else{
        print("NO PUEDES DEJAR LOS CAMPOS VACIOS ");
      }
    }catch(e){
      print('${e.hashCode} ALGO SALIO MAL' );
    }
    }
  
  //Vaciar los campos
  void limpiarCampos() {
    tituloController.clear();
    temaController.clear();
    explicacionController.clear();
    dudasController.clear();
    ejemplosController.clear();
  }
  //Validar Campos
  bool validarCampos(){
    //Trim - eliminamos lo espacios en blanco
    if(
      tituloController.text.trim().isEmpty||
      temaController.text.trim().isEmpty||
      explicacionController.text.trim().isEmpty||
      dudasController.text.trim().isEmpty||
      ejemplosController.text.trim().isEmpty
    ){
      return false;
    }
    return true;
    
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
                Navigator.of(context).pushNamed('/ejem2');
                // acción personalizada
              },
            ),
            const SizedBox(height: 20),

            // Campos de entrada usando InputField genérico
            TextfieldWidget(label: "Título", controller: tituloController),
            TextfieldWidget(
                label: "Selecciona el tema que deseas aprender",
                controller: temaController),
            TextfieldWidget(
              label: "Explícalo con tus propias palabras",
              controller: explicacionController,
              maxLines: 4,
            ),
            TextfieldWidget(
              label: "Identifica tus dudas",
              controller: dudasController,
              maxLines: 3,
            ),
            TextfieldWidget(
              label: "Ejemplos o analogías",
              controller: ejemplosController,
              maxLines: 3,
            ),

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
              onPressed: _post, 
              
            ),







      
            
          ],
        ),
      ),
    );
  }
}
