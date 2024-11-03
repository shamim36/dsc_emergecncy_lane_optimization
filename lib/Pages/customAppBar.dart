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
                // Add your navigation or action logic here
              },
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Set text color here
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      actions: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return Row(
                children: _buildActionButtons(),
              );
            } else if (constraints.maxWidth > 600) {
              return Row(
                children: _buildActionButtons(visibleButtons: 5),
              );
            } else if (constraints.maxWidth > 400) {
              return Row(
                children: _buildActionButtons(visibleButtons: 4),
              );
            } else if (constraints.maxWidth > 300) {
              return Row(
                children: _buildActionButtons(visibleButtons: 3),
              );
            } else {
              return Row(
                children: _buildActionButtons(visibleButtons: 2),
              );
            }
          },
        ),
        _profileButton(), // Profile button is always visible
      ],
    );
  }

  List<Widget> _buildActionButtons({int visibleButtons = 5}) {
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
      const WhatsAppButton('+1234567891'), // WhatsApp button implementation
    ];

    return buttons.take(visibleButtons).toList();
  }

  IconButton _profileButton() {
    return IconButton(
      icon: const Icon(Icons.person, color: Colors.black),
      onPressed: () {
        // Handle profile action
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
          style: setTextStyleColor(const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }

  TextStyle setTextStyleColor(Color color) {
    return TextStyle(color: color);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class WhatsAppButton extends StatefulWidget {
  final String whatsAppNumber;

  const WhatsAppButton(this.whatsAppNumber);

  @override
  _WhatsAppButtonState createState() => _WhatsAppButtonState();
}

class _WhatsAppButtonState extends State<WhatsAppButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: OutlinedButton(
        onPressed: () async {
          String phoneNumber = widget.whatsAppNumber;
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
          backgroundColor: _isHovered
              ? Color.fromARGB(255, 12, 196, 110)
              : Colors.transparent,
        ),
        child: const Row(
          children: [
            Icon(Icons.call),
            SizedBox(width: 4),
            Text(
              '+123456748941', // Display the WhatsApp number
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
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


