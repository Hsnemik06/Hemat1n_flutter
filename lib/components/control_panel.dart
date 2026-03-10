//control_panel.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/data_controller.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Provider.of<DataController>(context);

    return Container(

      margin: const EdgeInsets.symmetric(horizontal:20),
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text("Power Limit & Control",
              style: TextStyle(fontWeight: FontWeight.bold)),

          const SizedBox(height:20),

          Text("Power Limit : ${controller.powerLimit.toInt()} W"),

          Slider(

            min: 300,
            max: 2000,

            value: controller.powerLimit,

            onChanged: (value){
              controller.changePowerLimit(value);
            },

          ),

          const SizedBox(height:10),

          ElevatedButton(

            style: ElevatedButton.styleFrom(
              backgroundColor:
                  controller.deviceOn ? Colors.green : Colors.red,
            ),

            onPressed: (){
              controller.toggleDevice();
            },

            child: Text(controller.deviceOn ? "ON" : "OFF"),
          )

        ],
      ),
    );
  }
}