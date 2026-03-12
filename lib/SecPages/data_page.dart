import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/data_controller.dart';
import '../components/usage_card.dart'; // ✅ import UsageCard
import '../components/control_panel.dart';
import '../components/usage_chart.dart';
import '../homepage/homepage_bottom_nav.dart';
import '../homepage/homepage_header.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DataController>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],

      // bottom navbar
      bottomNavigationBar: const HomepageBottomNav(currentIndex: 1),
      body: Column(
        children: [
          // NAVBAR ATAS FULL
          const HomepageHeader(),

          // SafeArea untuk body konten
          Expanded(
            child: SafeArea(
              top: false, // biarkan header hijau menempel ke atas
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // ✅ Usage Card ditambahkan di sini
                  const UsageCard(),

                  const SizedBox(height: 20),

                  // CONTROL PANEL
                  ControlPanel(),

                  const SizedBox(height: 20),

                  // OVERLOAD WARNING
                  if (controller.overload)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.warning, color: Colors.red),
                          SizedBox(width: 10),
                          Text("WARNING: Overload Detected!"),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // CHART
                  const UsageChart(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}