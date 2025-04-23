import 'package:flutter/material.dart';

class FontSizeCalculator {
  static double getResponsiveSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) return baseSize * 0.85;
    if (screenWidth < 480) return baseSize;
    if (screenWidth < 600) return baseSize * 1.1;
    return baseSize * 1.2;
  }
}

void main() {
  runApp(const Sec35Screen());
}

class Sec35Screen extends StatefulWidget {
  const Sec35Screen({super.key});

  @override
  _Sec35ScreenState createState() => _Sec35ScreenState();
}

class _Sec35ScreenState extends State<Sec35Screen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text('Back', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Main Content
                LayoutBuilder(
                  builder: (context, constraints) {
                    double maxWidth = constraints.maxWidth;

                    return Stack(
                      children: [
                        // Top Blue Bar
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: paddingFactor),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: maxWidth > 600 ? 600 : maxWidth * 0.95,
                                maxHeight: screenHeight * 0.85,
                              ),
                              child: AspectRatio(
                                aspectRatio: screenWidth < 400 ? 0.6 : screenWidth < 600 ? 0.65 : 0.7,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8, bottom: 10),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Section 73, RA 6975',
                                                        style: TextStyle(
                                                          fontSize: FontSizeCalculator.getResponsiveSize(context, 18),
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        'TPPD Retirement',
                                                        style: TextStyle(
                                                          fontSize: FontSizeCalculator.getResponsiveSize(context, 15),
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                    'Permanent Physical Disability. – An officer or non-officer who, having accumulated at least twenty (20) years of active service, incurs total permanent physical disability in line of duty shall be compulsorily retired: Provided, That, if he has accumulated less than twenty (20) years of active service, he shall be separated from the service and be entitled to a separation pay equivalent to one and one-fourth (11/4) months base pay for every year of service, or a fraction thereof, and longevity pay of the permanent grade he holds.',                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontSize: screenWidth < 360 ? 13 : screenWidth < 480 ? 13 : 16,
                                                  height: 1.3,
                                                ),
                                              ),
                                              const SizedBox(height: 70),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Bottom Blue Bar
                        Positioned(
                          bottom: 0,
                          left: paddingFactor,
                          right: paddingFactor,
                          child: Container(
                            width: screenWidth < 600 ? screenWidth - (paddingFactor * 2) : 400,
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
                        ),
                      ],
                    );
                  },
                ),

                const Spacer(),

                // Footer
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: const Text(
                    "Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph",
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
