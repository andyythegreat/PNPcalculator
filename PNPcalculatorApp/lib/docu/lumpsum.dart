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
  runApp(const RequirementsScreen());
}

class RequirementsScreen extends StatefulWidget {
  const RequirementsScreen({super.key});

  @override
  _RequirementsScreenState createState() => _RequirementsScreenState();
}

class _RequirementsScreenState extends State<RequirementsScreen> {
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
                                        'Requirements for 36 Months Lump Sum/ Outright Pension/ Gratuity',
                                        style: TextStyle(
                                          fontSize: FontSizeCalculator.getResponsiveSize(context, 18),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '(2 Folders)(1 Original, 1 Photocopy)',
                                        style: TextStyle(
                                          fontSize: FontSizeCalculator.getResponsiveSize(context, 16),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // REQUIREMENTS LIST
                                      _buildRequirementItem(context, 'TAB A', 'Retirement Order'),
                                      _buildRequirementItem(
                                        context,
                                        'TAB B',
                                        'Service Record – RMD',
                                        note: '(DATE OF ISSUANCE MUST BE AT LEAST ONE (1) YEAR UPON SUBMISSION OF FOLDER) – MUST BE AUTHENTICATED',
                                        hasBackground: false,
                                      ),
                                      _buildRequirementItem(context, 'TAB C', 'Latest Promotion Order'),
                                      _buildRequirementItem(context, 'TAB D', 'Directorate for Comptrollership (DC) Clearance'),
                                      _buildRequirementItem(
                                        context,
                                        'TAB E',
                                        'Directorate for Logistics (DL) Clearance',
                                        note: '(IF WITH PENDING CASE, AND IF WITH FIREARMS ACCOUNTABILITY, ATTACH BOARD OF SURVEY)',
                                        hasBackground: false,
                                      ),
                                      _buildRequirementItem(
                                        context,
                                        'TAB F',
                                        'DLOD Clearance',
                                        note: '(DATE OF ISSUANCE MUST BE VALID W/IN 6 MONTHS UPON SUBMISSION OF FOLDER)',
                                        hasBackground: false,
                                      ),
                                      _buildRequirementItem(
                                        context,
                                        'TAB G',
                                        'Ombudsman Clearance',
                                        note: '(DATE OF ISSUANCE MUST BE VALID W/IN 6 MONTHS UPON SUBMISSION OF FOLDER)',
                                        hasBackground: false,
                                      ),
                                      _buildRequirementItem(
                                        context,
                                        'TAB H',
                                        'NAPOLCOM Clearance (RAB and NAB)',
                                        note: '(DATE OF ISSUANCE MUST BE VALID W/IN 6 MONTHS UPON SUBMISSION OF FOLDER)',
                                        hasBackground: false,
                                      ),
                                      _buildRequirementItem(context, 'TAB I', 'Certificate of Last Payment (CLP)'),
                                      _buildRequirementItem(context, 'TAB J', 'Statement of Assets, Liabilities & Net Worth (SALN) – Original'),
                                      _buildRequirementItem(context, 'TAB K', 'STI-1 Pensioner Account Information with Bank Confirmation Slip'),
                                      _buildRequirementItem(
                                        context,
                                        'TAB L',
                                        'Additional Form Retirees Beneficiaries',
                                        note: '(NOTARIZED)',
                                      ),
                                      _buildRequirementItem(
                                        context,
                                        'TAB M',
                                        'Declaration of Pendency/ Non-Pendency of Case',
                                        note: '(NOTARIZED)',
                                      ),
                                      _buildRequirementItem(
                                        context,
                                        ' ',
                                        'Authorization to Deduct',
                                        note: '(NOTARIZED)',
                                      ),
                                      _buildRequirementItem(context, ' ', 'Update Form'),
                                      _buildRequirementItem(
                                        context,
                                        ' ',
                                        'Pre- Retirement Seminar (Online)',
                                        note: '(IF RETIREMENT DATE IS FROM MARCH 2021 ONWARDS)',
                                      ),
                                      _buildRequirementItem(context, ' ', 'Cellphone Number & Email Address'),
                                      _buildRequirementItem(context, ' ', '2X2 Picture w/ Nametag'),

                                      const SizedBox(height: 24),

                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Additional Requirement for Outright Pension with No Pending Case (NOTARIZED):',
                                              style: TextStyle(
                                                fontSize: FontSizeCalculator.getResponsiveSize(context, 15),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            _buildAdditionalRequirementItem(
                                              context,
                                              'Affidavit stating that he/she is waiving his/her right for payment of the three (3) Years Lump Sum and opting to be paid through Outright Pension.',
                                            ),
                                            const SizedBox(height: 4),
                                            _buildAdditionalRequirementItem(
                                              context,
                                              'Authorization to Deduct',
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 16),

                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Additional Requirement for Outright Pension with Pending Case (NOTARIZED):',
                                              style: TextStyle(
                                                fontSize: FontSizeCalculator.getResponsiveSize(context, 15),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            _buildAdditionalRequirementItem(
                                              context,
                                              'Affidavit of Undertaking',
                                            ),
                                            const SizedBox(height: 4),
                                            _buildAdditionalRequirementItem(
                                              context,
                                              'Declaration of Pendency/ Non-Pendency of Case',
                                            ),
                                            const SizedBox(height: 4),
                                            _buildAdditionalRequirementItem(
                                              context,
                                              'Affidavit of Authorization to Deduct',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Footer
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

                // Copyright Footer
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

  Widget _buildRequirementItem(
      BuildContext context,
      String tab,
      String description,
      {String? note, bool hasBackground = false}
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: hasBackground ? Colors.grey.shade200 : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: FontSizeCalculator.getResponsiveSize(context, 14),
            color: Colors.black,
          ),
          children: [
            if (tab.isNotEmpty)
              TextSpan(
                text: '$tab – ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            if (tab.isEmpty)
              const TextSpan(
                text: '* ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            TextSpan(text: description),
            if (note != null) ...[
              const TextSpan(text: ' '),
              TextSpan(
                text: note,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalRequirementItem(BuildContext context, String description) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('– ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: FontSizeCalculator.getResponsiveSize(context, 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

