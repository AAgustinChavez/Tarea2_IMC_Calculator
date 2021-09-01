import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  var heightController = TextEditingController();
  var weightController = TextEditingController();
  bool isPressedM = false;
  bool isPressedF = false;
  double imcValue = 0.0;
  void imcCalculation(){
    var heightValue = double.parse(heightController.text);
    var weightValue = double.parse(weightController.text);
    imcValue = weightValue/(heightValue*heightValue);
  }

  void showAlertDialog(BuildContext context){
    AlertDialog alert = AlertDialog(
      title: Text("Tu IMC: ${imcValue.toStringAsFixed(2)}"),
      content: Text(isPressedM? "Tabla de IMC para hombres\n\nEdad    IMC ideal\n16-16     19-24\n17-17     20-25\n18-24     20-25\n25-34     21-26\n35-44     22-27\n45-54     23-28\n55-64     24-29\n65-90     25-30": 
      "Tabla de IMC para mujeres\n\nEdad    IMC ideal\n16-17     19-24\n18-18     19-24\n19-24     19-24\n25-34     20-25\n35-44     21-26\n45-54     22-27\n55-64     23-28\n65-90     25-30"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("Aceptar"))
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return alert;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcular IMC'),
        actions: [
          IconButton(
            onPressed: (){
              heightController.clear();
              weightController.clear();
              isPressedF = false;
              isPressedM = false;
              setState(() {});
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Text("Ingrese sus datos para calcular el IMC",
                textAlign:  TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              
              IconButton(
                onPressed: (){
                  setState(() {
                    if(!isPressedF)isPressedF=true;
                    if(isPressedM)isPressedM=false;
                  });
                }, 
                icon: Icon(Icons.female, color: isPressedF ? Colors.indigo : Colors.black,)
              ),

              SizedBox(width: 15,),
              
              IconButton(
                onPressed: (){
                  setState(() {
                    if(!isPressedM)isPressedM=true;
                    if(isPressedF)isPressedF=false;
                  });
                }, 
                icon: Icon(Icons.male, color: isPressedM ? Colors.indigo : Colors.black,)
              ),
              
            ]
          ),

          ListTile(
            leading: Icon(Icons.square_foot,),
            title: 
              Padding(
                
                padding: EdgeInsets.only(right: 10),
                child: TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Ingresar altura (Metros)",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                      
                    ),
                    
                  ),
                ),
              ), 
          ),

          SizedBox(height: 15),

          ListTile(
            leading: Icon(Icons.monitor_weight,),
            title: 
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Ingresar peso (KG)",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                        
                    ),
                  ),
                ),
              ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: (){
                  if(heightController.text.isEmpty || weightController.text.isEmpty){
                    showDialog(
                      context: context,
                      builder: (context)=>AlertDialog(
                        title: Text("Advertencia"),
                        content: Text("Uno o más campos se encuetran vacíos.\nFavor de ingresar toda la información solicitada."),
                        actions: [
                          TextButton(
                            onPressed: (){Navigator.of(context).pop();},
                            child: Text("Entendido")
                          ),
                        ],
                      )
                    );
                  }else{
                    imcCalculation();
                    setState(() {});
                    print("Valor del text field height: ${heightController.text}");
                    print("Valor del text field weight: ${weightController.text}");
                    showAlertDialog(context);
                  }
                }, 
                child: Text("Calcular", style: TextStyle(color: Colors.black),),
              ),
            ]
          ),
        ],
      )
    );
  }
}