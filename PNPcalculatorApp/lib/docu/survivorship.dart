import 'package:flutter/material.dart';
import 'reqs.dart';

void main() {
  runApp(const SurvivorshipScreen());
}

class SurvivorshipScreen extends StatefulWidget {
  const SurvivorshipScreen({super.key});

  @override
  _SurvivorshipScreenState createState() => _SurvivorshipScreenState();
}

class _SurvivorshipScreenState extends State<SurvivorshipScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingFactor = screenWidth < 600 ? 12.0 : 24.0;

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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text('Back', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // TITLES FOR EACH REQUIREMENTS
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(paddingFactor),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildHeader(),

                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildTextTitle('Requirements for Commutation of Accumulated Leave (2 copies each, 1 original, 1 photocopy, Folder with Tabbings):'),
                                  _buildRequirements(),
                                  const SizedBox(height: 20),

                                  _buildTextTitle('Additional Requirements for Deceased PNP Personnel'),
                                  _buildDeceasedRequirements(),

                                  const SizedBox(height: 20),

                                  _buildTextTitle('REQUIREMENTS FOR COMMUTATION OF ACCUMULATED LEAVE (CAL) CLAIM (Posthumously Retired/Separated)'),
                                  _buildCALClaimRequirements(),

                                  const SizedBox(height: 20),

                                  _buildTextTitle('ADDITIONAL REQUIREMENTS FOR ISSUANCE OF CERTIFICATE OF LEGAL BENEFICIARY AND DECREE OF ENTITLEMENT'),
                                  _buildLegalBeneficiaryRequirements(),

                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildFooter(screenHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Container(
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
          Image.asset('images/pnp_logo.png', height: 40, width: 40),
          const SizedBox(width: 10),
          const Text(
            'PHILIPPINE NATIONAL POLICE',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 10),
          Image.asset('images/prbs_logo.png', height: 40, width: 40),
        ],
      ),
    );
  }

  // SECTION TITLE
  Widget _buildTextTitle(String title, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        textAlign: TextAlign.center,
      ),
    );
  }

  // FOOTER
  Widget _buildFooter(double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: const Text(
        "Copyright 2016-2022\nPhilippine National Police\nInformation Technology Management Service\nwww.itms.pnp.gov.ph",
        style: TextStyle(fontFamily: 'Roboto', color: Colors.white70, fontSize: 10, height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }

  // REQUIREMENTS LIST
  Widget _buildRequirements() {
    return Column(
      children: [
        _buildNumberedItem(1, 'Retirement Order'),
        _buildNumberedItem(2, 'Updated Service Record', hasBackground: true),
        _buildNumberedItem(3, 'Commutation Order'),
        _buildNumberedItem(4, 'Breakdown of Leave Credits', hasBackground: true),
        _buildNumberedItem(5, 'Latest Promotion Order (For NUP: Salary Adjustment)'),
        _buildNumberedItem(6, 'Non-Money and Property Clearances from Last Unit', hasBackground: true),
        _buildNumberedItem(7, 'Certificate of Last Payment (CLP)'),
        _buildNumberedItem(8, 'SALN (Latest)', hasBackground: true),
        _buildNumberedItem(9, 'DC Clearance'),
        _buildNumberedItem(10, 'DL Clearance', hasBackground: true),
        _buildNumberedItem(11, 'Authorization (Affidavit) to Deduct all Financial Obligation (SIGNED and DULY NOTARIZED)'),
        _buildNumberedItem(12, 'UPDATE FORM/STI-1/ATM Account with Bank Confirmation', note: '(submit Bank Certificate for non LBP Account)', hasBackground: true),
        _buildNumberedItem(13, 'Contact number (Cellphone number)'),
        _buildNumberedItem(14, '2×2 Picture with Nametag', hasBackground: true),
        _buildNumberedItem(15, 'Certificate of Attendance (Pre-Retirement Seminar)'),
        _buildNumberedItem(16, 'Pensioner\'s Information Form', hasBackground: true),
        _buildNumberedItem(17, 'Family Information Sheet (Retiree\'s Declared Beneficiaries) (SIGNED and Duly Notarized)'),
      ],
    );
  }

  Widget _buildDeceasedRequirements() {
    return Column(
      children: [
        _buildNumberedItem(1, 'Decree of Entitlement and Certificate of Legal beneficiaries'),
        _buildNumberedItem(2, 'Death Certificate (From PSA with OR from LCR if not yet more than 6 months)', hasBackground: true),
        _buildNumberedItem(3, 'Marriage Contract (From PSA with OR)'),
        _buildNumberedItem(4, 'Marriage Contract of Parents (From PSA with OR, if Single)', hasBackground: true),
        _buildNumberedItem(5, 'Advisory on Marriage (Husband/ Wife, from PSA with OR)'),
        _buildNumberedItem(6, 'Birth Certificate of all children (from PSA with OR)', hasBackground: true),
        _buildNumberedItem(7, 'Birth Certificate (Husband/ Wife, from PSA with OR)'),
        _buildNumberedItem(8, 'Certificate of no Marriage (CENOMAR, if SINGLE)', hasBackground: true),
        _buildNumberedItem(9, '2×2 Latest ID Picture of PNP Personnel'),
      ],
    );
  }

  Widget _buildCALClaimRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNumberedItem(1, 'Posthumous Order from concerned Unit'),
        _buildNumberedItem(2, 'Confirmation of Posthumous Order from RMD, DPRM', hasBackground: true),
        _buildNumberedItem(3, 'Updated Service Record from RMD, DPRM'),
        _buildNumberedItem(4, 'Updated Breakdown of Leave Credits from RMD, DPRM', hasBackground: true),
        _buildNumberedItem(5, 'Commutation Order from RMD, DPRM'),
        _buildNumberedItem(6, 'Latest Promotion Order from Unit from Unit/RMD', hasBackground: true),
        _buildNumberedItem(7, 'Non-Money/Property accountability clearance from Unit'),
        _buildNumberedItem(8, 'Directorate for Logistics (DL) Clearance'),
        _buildNumberedItem(9, 'Directorate for Comptrollership (DC) Clearance', hasBackground: true),
        _buildNumberedItem(10, 'Statement of Assets, Liabilities and Net worth (SALN) from Unit'),
        _buildNumberedItem(11, 'Certificate of Last Payment from Finance Service', hasBackground: true),
        _buildNumberedItem(12, '2x2 picture with nametag'),
        _buildNumberedItem(13, 'Death Certificate from LCR/NSO', hasBackground: true),
        _buildNumberedItem(14, 'Affidavit of Authorization to Deduct if deemed needed (Money/Property Accountabilities)'),
      ],
    );
  }

  Widget _buildLegalBeneficiaryRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        _buildTextTitle('IF PNP personnel is MARRIED:', color: Colors.red),
        const SizedBox(height: 1),
        _buildNumberedItem(1, 'Advisory on Marriages of both husband and wife from NSO'),
        _buildNumberedItem(2, 'Marriage Contract from NSO', hasBackground: true),
        _buildNumberedItem(3, 'Birth Certificate of Minor Children from NSO'),

        const SizedBox(height: 20),

        _buildTextTitle('If PNP personnel is SINGLE:', color: Colors.red),
        const SizedBox(height: 1),
        _buildNumberedItem(1, 'Certificate of Singleness from NSO'),
        _buildNumberedItem(2, 'Marriage Contract of Parents', hasBackground: true),
        _buildNumberedItem(3, 'Birth Certificate of PNP personnel'),
      ],
    );
  }

  Widget _buildNumberedItem(int number, String text, {String? note, bool hasBackground = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: hasBackground ? Colors.grey.shade200 : Colors.transparent,
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 14),
                ),
                if (note != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    note,
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}