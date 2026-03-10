//usage_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/data_controller.dart';

class UsageCard extends StatelessWidget {
  const UsageCard({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Provider.of<DataController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),

      child: Row(
        children: [

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text("Current Usage",
                      style: TextStyle(color: Colors.white)),

                  const SizedBox(height:10),

                  Text(
                    "${controller.currentWatt} W",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),

                  Text("${controller.currentKwh} kWh",
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),

          const SizedBox(width:15),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text("Cost This Month",
                      style: TextStyle(color: Colors.white)),

                  const SizedBox(height:10),

                  Text(
                    "Rp ${controller.monthlyCost}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}