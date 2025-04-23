import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';
import 'calcu/calcu.dart';
import 'calcu/contact.dart';
import 'retire/retd.dart';
import 'package:pnp_pension/provi/lawsprovi.dart';
import 'docu/reqs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // ONLY AVAILABLE IN PORTRAIT MODE
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PNP Pension',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double logoSize = screenWidth * 0.38;
    double titleSize = screenWidth * 0.17;
    double subtitleSize = screenWidth * 0.10;
    double taglineSize = screenWidth * 0.050;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF07123C),
              Color(0xFF3B64D8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  children: [
                    // Contact Us
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ContactScreen()),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.question_mark,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Logo and Title Section
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 2),
                            child: Image.asset(
                              'images/pnp_logo.png',
                              width: logoSize,
                              height: logoSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PNP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  'PENSION',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: subtitleSize,
                                    fontWeight: FontWeight.normal,
                                    height: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Retirement Benefits',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: taglineSize,
                                    fontStyle: FontStyle.italic,
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MenuItemCard(
                      icon: Icons.calculate_outlined,
                      title: 'Calculate',
                      subtitle: 'Benefits',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalcuScreen()),
                        );
                      },
                    ),
                    MenuItemCard(
                      icon: Icons.description_outlined,
                      title: 'Documentary',
                      subtitle: 'Benefits',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DocuScreen()),
                        );
                      },
                    ),
                    MenuItemCard(
                      icon: Icons.settings_outlined,
                      title: 'Retirement',
                      subtitle: 'Processing',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RetdScreen()),
                        );
                      },
                    ),
                    MenuItemCard(
                      icon: Icons.balance_outlined,
                      title: 'Laws &\nProvisions',
                      subtitle: '',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LawsProviScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Footer Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Text(
                  'Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MenuItemCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Use only portrait mode size for all screen sizes
    double cardWidth = screenWidth * 0.85;

    // Icon size for portrait mode
    double iconSize = screenWidth * 0.15;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF0A2A5E),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: iconSize,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subtitle.isNotEmpty)
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white70,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
