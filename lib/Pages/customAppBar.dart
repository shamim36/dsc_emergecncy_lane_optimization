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
            child: GestureDetector(
              onTap: () {
                // Handle title button action
                print('Title button pressed');
              },
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      actions: _buildActionButtons(context),
    );
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    final buttons = <Widget>[
      _createTextButton('Home', () {
        print('Clicked Home');
      }),
      _createTextButton('E.num', () {
        print('Clicked E.num');
      }),
      _createTextButton('News', () {
        print('Clicked News');
      }),
      _createTextButton('About', () {
        print('Clicked About');
      }),
      const WhatsAppButton('+1234567891'),
      _profileButton(),
    ];

    // Get the available width
    final width = MediaQuery.of(context).size.width;

    // Determine how many buttons to show
    int visibleButtons = 6; // Default to all buttons
    if (width <= 400) {
      visibleButtons = 1; // Show only the WhatsApp button
    } else if (width <= 600) {
      visibleButtons = 3; // Show the first three buttons and WhatsApp
    } else if (width <= 800) {
      visibleButtons = 5; // Show all buttons except profile
    }

    return buttons.take(visibleButtons).toList();
  }

  IconButton _profileButton() {
    return IconButton(
      icon: const Icon(Icons.person, color: Colors.black),
      onPressed: () {
        print('Clicked Profile');
      },
    );
  }

  Widget _createTextButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class WhatsAppButton extends StatelessWidget {
  final String whatsAppNumber;

  const WhatsAppButton(this.whatsAppNumber);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        String phoneNumber = whatsAppNumber;
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
        children: const [
          Icon(Icons.call),
          SizedBox(width: 4),
          Text('+123456748941'),
        ],
      ),
    );
  }
}

// Main app widget for testing the CustomAppBar
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(title: 'My Custom App Bar'),
        body: Center(child: Text('Content goes here')),
      ),
    );
  }
}

