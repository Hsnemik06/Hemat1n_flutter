import 'package:flutter/material.dart';
import '../style/homepage_style.dart';
import '../card/device.dart';
import '../SecPages/add_device.dart';
class DeviceCard extends StatelessWidget {

final String deviceName;

const DeviceCard({
super.key,
required this.deviceName,
});

@override
Widget build(BuildContext context) {

return GestureDetector(

  /// OPEN DEVICE PAGE
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DevicePage(deviceName: deviceName),
      ),
    );
  },

  child: Container(
    width: 165,
    height: 220,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: HomepageStyle.cardRadius,
      boxShadow: HomepageStyle.cardShadow,
    ),

    child: Stack(
      children: [

        /// DEVICE NAME
        Center(
          child: Text(
            deviceName,
            style: HomepageStyle.deviceText,
          ),
        ),

        /// THREE DOT MENU
        Positioned(
          top: 5,
          left: 5,
          child: PopupMenuButton(
            icon: const Icon(Icons.more_vert),

            itemBuilder: (context) => const [

              PopupMenuItem(
                value: "edit",
                child: Text("Edit"),
              ),

              PopupMenuItem(
                value: "delete",
                child: Text("Hapus"),
              ),

            ],

            onSelected: (value) {

              if (value == "delete") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Fitur hapus belum dibuat"),
                  ),
                );
              }

              if (value == "edit") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDevicePage(
                      initialName: deviceName,
                    ),
                  ),
                );
              }

            },

          ),
        ),

      ],
    ),
  ),
);

}
}
