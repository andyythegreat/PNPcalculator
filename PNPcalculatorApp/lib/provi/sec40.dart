import 'package:flutter/material.dart';
import 'lawsprovi.dart';

void main() {
  runApp(const Sec40Screen());
}

class Sec40Screen extends StatefulWidget {
  const Sec40Screen({super.key});

  @override
  _Sec40ScreenState createState() => _Sec40ScreenState();
}

class _Sec40ScreenState extends State<Sec40Screen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    // For Responsiveness
    double paddingFactor = screenWidth < 600 ? 16.0 : 24.0;
    double bodyFontSize = screenWidth * 0.035;
    bodyFontSize = bodyFontSize > 16 ? 16 : bodyFontSize;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
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
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_back, color: Colors.white,
                                size: 20),
                            const SizedBox(width: 4),
                            const Text('Back', style: TextStyle(
                                color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 1),

                // Main Content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingFactor),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 400,
                        maxHeight: screenHeight * 0.7,
                      ),
                      child: AspectRatio(
                        aspectRatio: 0.65,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0A3D91),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/pnp_logo.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'PHILIPPINE NATIONAL POLICE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Image.asset(
                                    'images/prbs_logo.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                ],
                              ),
                            ),

                            // Title and Text Content Area
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20, bottom: 10),                                child: Column(
                                        children: const [
                                          Text(
                                            'Section 40 RA 6975',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Optional Retirement',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        'Upon accumulation of at least twenty (20) years of satisfactory active service, an officer or non-officer, at his own request and with the approval of the Commission, shall be retired from the service and entitled to receive benefits provided by law.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: bodyFontSize,
                                        ),
                                      ),
                                    ),

                                    const Spacer(),

                                    // Blue Bar
                                    Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF0A3D91),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'images/bagong_ph_logo.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 1),

                // Footer
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: const Text(
                    'Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white70,
                      fontSize: 10,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
