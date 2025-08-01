import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_ai_app/pages/Transaction%20data/transaction.dart';
import 'package:voice_ai_app/pages/transOp.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void addTransfer(String title, String date, double amount, bool isIncome) {
    setState(() {
      transactions.add(
        TransactionModel(
          title: title,
          date: date,
          amount: amount,
          isIncome: isIncome,
        ),
      );
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Widget _buildTransferButton({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
    String? subtitle,
    int delay = 0,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value * (delay + 1)),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onPressed();
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(icon, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              if (subtitle != null) ...[
                                const SizedBox(height: 6),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1B263B), Color(0xFF0D1B2A)],
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Banking Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00D4FF), Color(0xFF1280FF)],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00D4FF).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'خدمات التحويل المصرفي',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اختر الخدمة المناسبة لاحتياجاتك',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeaderSection(),

            // Transfer Options Section
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _slideAnimation.value),
                          child: Opacity(
                            opacity: _fadeAnimation.value,
                            child: const Text(
                              'الخدمات المتاحة',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Local Transfer Button
                            _buildTransferButton(
                              title: 'حوالة محلية',
                              subtitle: 'تحويل داخل المملكة - مجاني',
                              color: const Color(0xFF415A77),
                              icon: Icons.account_balance,
                              delay: 0,

                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTransactionPage(),
                                  ),
                                ).then((value) {
                                  if (value != null &&
                                      value is TransactionModel) {
                                    addTransfer(
                                      value.title,
                                      value.date,
                                      value.amount,
                                      value.isIncome,
                                    );
                                  }
                                });
                              },
                            ),

                            // Global Transfer Button
                            _buildTransferButton(
                              title: 'حوالة دولية',
                              subtitle: 'تحويل خارج المملكة - رسوم 2.5%',
                              color: const Color(0xFF2A4D3A),
                              icon: Icons.public,
                              delay: 1,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTransactionPage(),
                                  ),
                                ).then((value) {
                                  if (value != null &&
                                      value is TransactionModel) {
                                    double globalFee = value.amount * 0.025;
                                    addTransfer(
                                      "${value.title} (دولية)",
                                      value.date,
                                      value.amount + globalFee,
                                      value.isIncome,
                                    );
                                  }
                                });
                              },
                            ),

                            // Tax Transfer Button
                            _buildTransferButton(
                              title: 'دفع الضرائب',
                              subtitle: 'دفع ضريبة القيمة المضافة - 15%',
                              color: const Color(0xFF8B4513),
                              icon: Icons.receipt_long,
                              delay: 2,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTransactionPage(),
                                  ),
                                ).then((value) {
                                  if (value != null &&
                                      value is TransactionModel) {
                                    double taxAmount = value.amount * 0.15;
                                    addTransfer(
                                      "${value.title} (ضريبة)",
                                      value.date,
                                      value.amount + taxAmount,
                                      value.isIncome,
                                    );
                                  }
                                });
                              },
                            ),

                            // Quick Stats Card
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _slideAnimation.value * 4),
                                  child: Opacity(
                                    opacity: _fadeAnimation.value,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF1B263B,
                                        ).withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: const Color(
                                            0xFF00D4FF,
                                          ).withOpacity(0.2),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.info_outline,
                                                color: const Color(0xFF00D4FF),
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                'معلومات مهمة',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'آمان تام',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    const Icon(
                                                      Icons.security,
                                                      color: Colors.greenAccent,
                                                      size: 24,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'سرعة فائقة',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    const Icon(
                                                      Icons.flash_on,
                                                      color:
                                                          Colors.orangeAccent,
                                                      size: 24,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '24/7 متاح',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    const Icon(
                                                      Icons.access_time,
                                                      color: Colors.blueAccent,
                                                      size: 24,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
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
    );
  }
}
