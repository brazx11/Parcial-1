import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), //Establece el tema de la aplicación
      home: ChatScreen(), //Pantalla de inicio de la aplicación
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() =>
      _ChatScreenState(); //Contiene la lógica y los datos necesarios para mostrar y enviar mensajes.
}

//Lista que contiene los mensajes del chat
class _ChatScreenState extends State<ChatScreen> {
  final List<String> messages = List.generate(110, (index) {
    if (index == 10) {
      return 'gif:https://i.gifer.com/YHjl.gif';
    } else if (index == 31) {
      return 'gif:https://i.gifer.com/JXJd.gif';
    } else {
      return 'text:Holaa, profe este es el ms # $index';
    }
  });
//Lista que determina si un mensaje fue enviado por el usuario
  final List<bool> isSentByMe = List.generate(110, (index) => index % 2 == 0);

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    //Método que envía un mensaje
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add('text:${_controller.text}');
        isSentByMe.add(true);
        _controller.clear();
      });
    }
  }

//Método que construye el widget para mostrar cada mensaje en la lista
  Widget _buildMessage(String message, bool isSentByMe) {
    Widget content;

    if (message.startsWith('gif:')) {
      content = Image.network(
        message.substring(6),
        width: 200,
        height: 150,
      );
    } else {
      content = Text(
        message.substring(5),
        style: TextStyle(color: Colors.white),
      );
    }

    return Align(
      //indica si el mensaje fue enviado por el usuario.
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: content,
      ),
    );
  }

  @override //estructura de la pantalla
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //título y un avatar
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://acortar.link/e4z4pW'),
            ),
            SizedBox(width: 10),
            Text('Brayan'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(messages[index], isSentByMe[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), //Cantidad de espacio a añadir
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
