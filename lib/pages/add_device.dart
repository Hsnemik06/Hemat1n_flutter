//add_device.dart
import 'package:flutter/material.dart';
import '../style/add_device_style.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {

  final TextEditingController deviceNameController = TextEditingController();
  String deviceStatus = "Not connected";

  void scanDevice() {
    setState(() {
      deviceStatus = "Device found (ESP8266)";
    });
  }

  void pairDevice() {
    setState(() {
      deviceStatus = "Pairing success";
    });
  }

  void saveToFirebase() {
    String deviceName = deviceNameController.text;

    if (deviceName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter device name")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Device saved")),
    );

    Navigator.pop(context, deviceName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AddDeviceStyle.backgroundGrey,

      appBar: AppBar(
        title: const Text("Add Device"),
        backgroundColor: AddDeviceStyle.primaryGreen,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// DEVICE NAME
            const Text(
              "Device Name",
              style: AddDeviceStyle.sectionTitle,
            ),

            const SizedBox(height: 10),

            TextField(
              controller: deviceNameController,
              decoration: AddDeviceStyle.inputDecoration(
                "Example: Smart Lamp",
              ),
            ),

            const SizedBox(height: 30),

            /// SCAN DEVICE
            GestureDetector(
              onTap: scanDevice,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AddDeviceStyle.cardRadius,
                  boxShadow: AddDeviceStyle.cardShadow,
                ),
                child: Row(
                  children: [

                    Icon(
                      Icons.wifi_tethering,
                      size: 30,
                      color: AddDeviceStyle.primaryGreen,
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Scan Device",
                            style: AddDeviceStyle.sectionTitle,
                          ),

                          const SizedBox(height: 5),

                          Text(
                            deviceStatus,
                            style: AddDeviceStyle.statusText,
                          ),

                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    )

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// PAIR DEVICE
            GestureDetector(
              onTap: pairDevice,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AddDeviceStyle.cardRadius,
                  boxShadow: AddDeviceStyle.cardShadow,
                ),
                child: Row(
                  children: [

                    Icon(
                      Icons.link,
                      size: 30,
                      color: AddDeviceStyle.primaryGreen,
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Pair Device",
                            style: AddDeviceStyle.sectionTitle,
                          ),

                          const SizedBox(height: 5),

                          Text(
                            deviceStatus == "Pairing success"
                                ? "Device paired successfully"
                                : "Tap to start pairing",
                            style: AddDeviceStyle.statusText,
                          ),

                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    )

                  ],
                ),
              ),
            ),

            const Spacer(),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AddDeviceStyle.primaryGreen,
                ),
                onPressed: saveToFirebase,
                child: const Text(
                  "Save Device",
                  style: AddDeviceStyle.buttonText,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}