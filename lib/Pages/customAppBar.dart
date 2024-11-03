import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Adjust the button visibility based on available width
            if (constraints.maxWidth > 800) {
              return Row(
                children: _buildActionButtons(),
              );
            } else if (constraints.maxWidth > 600) {
              // Hide 'About'
              return Row(
                children: _buildActionButtons(visibleButtons: 4),
              );
            } else if (constraints.maxWidth > 400) {
              // Hide 'Contact' and WhatsApp button
              return Row(
                children: _buildActionButtons(visibleButtons: 3),
              );
            } else {
              // Show only 'Home' and 'News'
              return Row(
                children: _buildActionButtons(visibleButtons: 2),
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.person, color: Colors.black),
          onPressed: () {
            // Handle profile action
          },
        ),
      ],
    );
  }

  List<Widget> _buildActionButtons({int visibleButtons = 5}) {
    final buttons = <Widget>[
      _createTextButton('Home', () {
        // Handle Home action
      }),
      _createTextButton('E.num', () {
        // Handle News action
      }),
      _createTextButton('News', () {
        // Handle About action
      }),
      _createTextButton('CAbout', () {
        // Handle Contact action
      }),
      _createWhatsAppButton('+1234567891'), // Include WhatsApp button here
    ];

    // Return only the visible buttons based on the parameter
    return buttons.take(visibleButtons).toList();
  }

  Widget _createTextButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: setTextStyleColor(const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }

  Widget _createWhatsAppButton(String whatsAppNumber) {
    return OutlinedButton(
      onPressed: () async {
        String phoneNumber = whatsAppNumber; // Replace with the actual number
        final whatsappUrl = 'https://wa.me/$phoneNumber';
        try {
          if (await canLaunch(whatsappUrl)) {
            await launch(whatsappUrl);
          } else {
            print('Could not launch $whatsappUrl');
          }
        } catch (e) {
          print('Error launching WhatsApp: $e');
        }
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color.fromARGB(255, 10, 140, 64)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.call),
          const SizedBox(width: 4),
          Text(
            '+123456748941', // Display the WhatsApp number
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      ),
    );
  }

  TextStyle setTextStyleColor(Color color) {
    return TextStyle(color: color);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
