import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcule() {
    setState(() { //setState para reconstrução do app no momento
      double weight = double.parse(weightController.text); // declaração da variavel peso
      double height = double.parse(heightController.text); // declaração da variavel altura

      double imc = weight / (height * height); // Calculo do Imc
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc < 24.9 && imc > 18.6) {
        _infoText = "Peso Normal (${imc.toStringAsPrecision(4)})";
      } else if (imc < 25 && imc > 29.9) {
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
      } else if (imc < 34.9 && imc > 30) {
        _infoText = "Obesidade Grau 1 (${imc.toStringAsPrecision(4)})";
      } else if (imc < 35 && imc > 39.9) {
        _infoText = "Obesidade Grau 2 (${imc.toStringAsPrecision(4)})";
      } else if (imc > 40) {
        _infoText = "Obesidade Grau 3 (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView( //para desenhar a tela
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0), // Para dar a distancia
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  }
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0), //neste formato de padding só é nescessario especificar o que quer mudar
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate())
                          _calcule();
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(_infoText,
                    textAlign: TextAlign.center, // Centralizar o texto
                    style: TextStyle(color: Colors.green, fontSize: 25.0)) // Estilo do texto
              ],
            ),
          ),
        ));
  }
}
