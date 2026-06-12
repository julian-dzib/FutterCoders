import 'package:flutter/material.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            /// Contenido del chat
            Expanded(
              child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text("Aquí irá el contenido del chat"),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Input para enviar mensajes
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

                    /// TextField para escribir mensajes
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Escribe un mensaje...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    

                    /// Botón para enviar mensajes
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.deepPurple),
                      onPressed: () {
                        // Acción de enviar
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}