//homepage_body.dart
import 'package:flutter/material.dart';
import '../style/homepage_style.dart';
import '../pages/add_device.dart';

class HomepageBody extends StatelessWidget {
  final List<String> devices;
  final Function(String) onAddDevice;

  const HomepageBody({
    super.key,
    required this.devices,
    required this.onAddDevice,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HomepageStyle.horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 5),

            /// ROOM TITLE
            const Text(
              "Room",
              style: HomepageStyle.sectionTitle,
            ),

            const SizedBox(height: 5),

            /// ROOM BUTTON
            Container(
              width: 60,
              height: 35,
              decoration: BoxDecoration(
                color: HomepageStyle.primaryGreen,
                borderRadius: BorderRadius.circular(15),
                boxShadow: HomepageStyle.cardShadow,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),

            const SizedBox(height: 40),

            /// DEVICE TITLE
            const Text(
              "Device",
              style: HomepageStyle.sectionTitle,
            ),

            const SizedBox(height: 10),

            /// DEVICE LIST
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [

                /// ADD DEVICE CARD
                GestureDetector(
                  onTap: () async {

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDevicePage(),
                      ),
                    );

                    if (result != null) {
                      onAddDevice(result);
                    }
                  },
                  child: Container(
                    width: 180,
                    height: 240,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: HomepageStyle.cardRadius,
                      boxShadow: HomepageStyle.cardShadow,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: HomepageStyle.primaryGreen,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Add device",
                          style: HomepageStyle.deviceText,
                        ),
                      ],
                    ),
                  ),
                ),

                /// DEVICE CARDS
                ...devices.map((device) {
                  return Container(
                    width: 180,
                    height: 240,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: HomepageStyle.cardRadius,
                      boxShadow: HomepageStyle.cardShadow,
                    ),
                    child: Center(
                      child: Text(
                        device,
                        style: HomepageStyle.deviceText,
                      ),
                    ),
                  );
                }).toList(),

              ],
            ),

            const SizedBox(height: 100),

          ],
        ),
      ),
    );
  }
}