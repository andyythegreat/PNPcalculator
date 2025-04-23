import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pnp_pension/main.dart';
import 'sec75.dart';
import 'sec39.dart';
import 'sec40.dart';
import 'sec71.dart';
import 'sec73.dart';
import 'sec74.dart';
import 'sec76.dart';


class LawsProviScreen extends StatelessWidget {
  const LawsProviScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isSmallScreen = screenWidth < 320;
    final isLandscape = screenWidth > screenHeight;

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
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Column(
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        left: screenWidth * 0.04,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.006,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: screenWidth * 0.04,
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.035,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Header Section
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isLandscape ? screenHeight * 0.02 : screenHeight * 0.03,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.balance,
                              color: Colors.white,
                              size: isSmallScreen ? screenWidth * 0.12 : screenWidth * 0.15,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Container(
                              height: isLandscape ? screenHeight * 0.12 : screenHeight * 0.08,
                              width: 2,
                              color: Colors.white,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Laws and',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? screenWidth * 0.05 : screenWidth * 0.06,
                                    height: 1.1,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  'Provisions',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? screenWidth * 0.05 : screenWidth * 0.06,
                                    height: 1.1,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'PERTINENT RETIREMENT PROVISIONS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? screenWidth * 0.03 : screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // List of Provisions
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.01,
                        ),
                        child: Column(
                          children: [
                            ProvisionCard(
                              title: 'Section 39, RA 6975',
                              subtitle: 'Compulsory Retirement',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Sec39Screen()),
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            ProvisionCard(
                              title: 'Section 40, RA 6975',
                              subtitle: 'Optional Retirement',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Sec40Screen()),
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            ProvisionCard(
                              title: 'Section 73, RA 6975',
                              subtitle:
                              'TPPD Retirement',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Sec35Screen()),
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            ProvisionCard(
                              title: 'Section 74, RA 6975',
                              subtitle: 'One (1) Rank Higher Benefits',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Sec74Screen()),
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            ProvisionCard(
                              title: 'Section 75, RA 6975',
                              subtitle:
                              'Retirement Benefits',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Sec34Screen()),
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            ProvisionCard(
                              title: 'Section 76, RA 6975',
                              subtitle: 'Death and Disability Benefits',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Sec76Screen()),
                                );
                              },
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            ProvisionCard(
                              title: 'Section 71 RA 6975',
                              subtitle: 'Longevity Pay Benefits',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Sec71Screen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Footer
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.02,
                      top: screenHeight * 0.01,
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: screenWidth * 0.025,
                          height: 1.5,
                          fontFamily: 'Roboto',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProvisionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProvisionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 320;

    return Material(
      color: const Color(0xFF0A2A5E),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.24),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.03,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? screenWidth * 0.03 : screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.005),
                      Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: isSmallScreen ? screenWidth * 0.025 : screenWidth * 0.03,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: screenWidth * 0.06,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
