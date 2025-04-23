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
  runApp(const RequiredScreen());
}

class RequiredScreen extends StatefulWidget {
  const RequiredScreen({super.key});

  @override
  _RequiredScreenState createState() => _RequiredScreenState();
}

class _RequiredScreenState extends State<RequiredScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingFactor = screenWidth < 600 ? 16.0 : 24.0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF07123C), Color(0xFF3B64D8)],
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
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text('Back',
                                style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Main Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: paddingFactor,
                      vertical: 16,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth > 600 ? 600 : screenWidth * 0.95,
                        ),
                        child: Column(
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

                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      // TITLE
                                      Text(
                                        'REQUIREMENTS FOR ATM ENROLLMENT',
                                        style: TextStyle(
                                          fontSize: FontSizeCalculator.getResponsiveSize(context, 14),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // REQUIREMENTS LIST
                                      Padding(
                                        padding: const EdgeInsets.only(left: 1.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '1. Updating and ID Application Form',
                                              style: TextStyle(
                                                fontSize: FontSizeCalculator.getResponsiveSize(context, 14),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 24.0, top: 8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'A. Retiree (PNP member)',
                                                    style: TextStyle(
                                                      fontSize: FontSizeCalculator.getResponsiveSize(context, 12),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 24.0, top: 8.0),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text('● ', style: TextStyle(fontWeight: FontWeight.normal)),
                                                        Expanded(
                                                          child: Text(
                                                            'Complete mandatory requirements for CAL, Lump sum or Gratuity',
                                                            style: TextStyle(
                                                              fontSize: FontSizeCalculator.getResponsiveSize(context, 12),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'B. Transferee',
                                                    style: TextStyle(
                                                      fontSize: FontSizeCalculator.getResponsiveSize(context, 12),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 24.0, top: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('● ', style: TextStyle(fontWeight: FontWeight.normal)),
                                                            Expanded(
                                                              child: Text(
                                                                'Decree of Entitlement and Distribution',
                                                                style: TextStyle(
                                                                  fontSize: FontSizeCalculator.getResponsiveSize(context, 12),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text('● ', style: TextStyle(fontWeight: FontWeight.normal)),
                                                            Expanded(
                                                              child: Text(
                                                                'Certificate of Legal Beneficiaries (CLB)',
                                                                style: TextStyle(
                                                                  fontSize: FontSizeCalculator.getResponsiveSize(context, 12),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),

                                            Text(
                                              '2. Letter of Introduction (LOI)',
                                              style: TextStyle(
                                                fontSize: FontSizeCalculator.getResponsiveSize(context, 14),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 16),

                                            Text(
                                              '3. Waiver of Rights',
                                              style: TextStyle(
                                                fontSize: FontSizeCalculator.getResponsiveSize(context, 14),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),

                                            RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                  fontSize: FontSizeCalculator.getResponsiveSize(context, 16),
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'NOTE: ',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: FontSizeCalculator.getResponsiveSize(context, 11),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: 'Forms no. 1-3 can be obtain from PRBS website (',
                                                      style: TextStyle(
                                                      fontSize: FontSizeCalculator.getResponsiveSize(context, 11),
                                                    )
                                                  ),
                                                  TextSpan(
                                                    text: 'www.prbs.pnp.gov.ph',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      decoration: TextDecoration.underline,
                                                      fontSize: FontSizeCalculator.getResponsiveSize(context, 11),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ') and all PRBUs ',
                                                      style: TextStyle(
                                                        fontSize: FontSizeCalculator.getResponsiveSize(context, 11),
                                                      )
                                                  ),
                                                  TextSpan(
                                                    text: '(FREE)',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: FontSizeCalculator.getResponsiveSize(context, 11),
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
                              ),
                            ),

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
                  ),
                ),

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