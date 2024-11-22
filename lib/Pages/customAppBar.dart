import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _selectedButton = 'Home'; // Tracks the selected button title
  bool _isProfileHovered = false; // Tracks hover state for profile button

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < 700; // Check for mobile screen size
    final screenHeight = MediaQuery.of(context).size.height;

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
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      actions: isMobile
          ? []
          : _buildActionButtons(
              context), // Show buttons in AppBar only if not mobile
    );
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    final buttons = <Widget>[
      _createTextButton('Home', () {
        setState(() {
          _selectedButton = 'Home';
          print('Home Button Clicked');
        });
      }),
      _createTextButton('''Emergency
  Number''', () {
        setState(() {
          _selectedButton = '''Emergency
  Number''';
          print('Emergency Numbers Button Clicked');
        });
      }),
      _createTextButton('News', () {
        setState(() {
          _selectedButton = 'News';
          print('News Button Clicked');
        });
      }),
      _createTextButton('About', () {
        setState(() {
          _selectedButton = 'About';
          print('About Button Clicked');
        });
      }),
      const WhatsAppButton('+1234567891'),
      _profileButton(),
    ];

    return buttons;
  }

  IconButton _profileButton() {
    return IconButton(
      icon: MouseRegion(
        onEnter: (_) => setState(() => _isProfileHovered = true),
        onExit: (_) => setState(() => _isProfileHovered = false),
        child: Container(
          decoration: BoxDecoration(
            color: _isProfileHovered || _selectedButton == 'Profile'
                ? const Color(0xFFCCFFCC) // Light green when hovered or clicked
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: const Icon(Icons.person_3_rounded, color: Colors.black),
        ),
      ),
      onPressed: () {
        setState(() {
          _selectedButton = 'Profile'; // Track profile button as selected
        });
        print('Clicked Profile');
      },
    );
  }

  Widget _createTextButton(String title, VoidCallback onPressed) {
    final isSelected =
        _selectedButton == title; // Check if the button is selected

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 4), // Add padding around the text
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(
                    0xFFCCFFCC) // Light green background when selected
                : Colors.transparent, // Transparent when not selected
            borderRadius: BorderRadius.circular(12), // Rounded edges
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
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
              ? const Color.fromARGB(255, 12, 196, 110)
              : Colors.transparent,
        ),
        child: Row(
          children: const [
            Icon(Icons.call),
            SizedBox(width: 4),
            Text(
              '+123456748941', // Display the WhatsApp number
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: CustomAppBar(title: 'My App'),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(child: Text('Menu')),
                  _createDrawerItem('Home', () {}),
                  _createDrawerItem('''Emergency
  Number''', () {}),
                  _createDrawerItem('News', () {}),
                  _createDrawerItem('About', () {}),
                  const WhatsAppButton('+1234567891'),
                  _profileButton(),
                ],
              ),
            )
          : null, // Only show the drawer on mobile
      body: body,
    );
  }

  ListTile _createDrawerItem(String title, VoidCallback onPressed) {
    return ListTile(
      title: Text(title),
      onTap: onPressed,
    );
  }

  IconButton _profileButton() {
    return IconButton(
      icon: const Icon(Icons.person, color: Colors.black),
      onPressed: () {
        print('Clicked Profile');
      },
    );
  }
}
