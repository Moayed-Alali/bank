import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_ai_app/pages/Transaction%20data/transaction.dart';
import 'package:voice_ai_app/pages/action.dart';
import 'package:voice_ai_app/pages/ai_assistant.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen>
    with TickerProviderStateMixin {
  String response = "";
  bool isHidden = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
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

  void _showUserProfile() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1B263B),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF415A77),
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              "أحمد محمد",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "ahmed.mohamed@email.com",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _profileAction(Icons.settings, "الإعدادات"),
                _profileAction(Icons.help_outline, "المساعدة"),
                _profileAction(Icons.security, "الأمان"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF415A77),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B263B),
        title: const Text(
          "تسجيل الخروج",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "هل أنت متأكد من رغبتك في تسجيل الخروج؟",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "إلغاء",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add logout logic here
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              "خروج",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double balance = 9580;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B263B),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outlined, color: Colors.white),
            onPressed: _showUserProfile,
          ),
        ],
        leadingWidth: 120,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.logout_outlined, color: Colors.red),
              onPressed: _logout,
            ),
            IconButton(
              icon: Icon(
                isHidden
                    ? Icons.visibility_off_outlined
                    : Icons.remove_red_eye_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isHidden = !isHidden;
                });
                HapticFeedback.lightImpact();
              },
            ),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() {});
          },
          backgroundColor: const Color(0xFF1B263B),
          color: const Color(0xFF00D4FF),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Balance Card with improved design
              Center(
                child: Container(
                  width: screenWidth * 0.9,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00D4FF),
                        Color(0xFF1280FF),
                        Color(0xFF0066CC),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D4FF).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "الحساب الرئيسي",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Text(
                            "الرصيد الحالي",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "**** **** **** 2033",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              isHidden
                                  ? "****"
                                  : balance.toStringAsFixed(2),
                              key: ValueKey(isHidden),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/riyalsymbol.png',
                            width: 24,
                            height: 24,
                            color: Colors.white,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.currency_exchange,
                                color: Colors.white,
                                size: 24,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "12/26",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                'assets/Mada_Logo.png',
                                width: 30,
                                height: 20,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      "mada",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.green.withOpacity(0.3),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.greenAccent,
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "نشط",
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
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
              const SizedBox(height: 30),

              // Quick Stats
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B263B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.trending_up,
                            color: Colors.greenAccent,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "الدخل الشهري",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${(balance * 0.15).toStringAsFixed(0)} ر.س",
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B263B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.trending_down,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "المصروفات",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${(balance * 0.08).toStringAsFixed(0)} ر.س",
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Action buttons with improved design
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                childAspectRatio: 1.8,
                children: [
                  const ActionButton(
                    icon: Icons.sim_card_outlined,
                    label: "شحن",
                  ),
                  ActionButton(
                    icon: Icons.mic,
                    label: "المساعد افق",
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AiAssistent()),
                      );
                    },
                  ),
                  const ActionButton(
                      icon: Icons.payment_outlined, label: "دفع"),
                  const ActionButton(
                    icon: Icons.transform_outlined,
                    label: "التحويل",
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Recent transactions header with filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_list,
                      color: Color(0xFF00D4FF),
                      size: 20,
                    ),
                    label: const Text(
                      "تصفية",
                      style: TextStyle(color: Color(0xFF00D4FF), fontSize: 14),
                    ),
                  ),
                  const Text(
                    "آخر الحوالات",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Transactions list with improved design
              transactions.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B263B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 48,
                            color: Colors.white38,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "لا توجد معاملات حديثة",
                            style:
                                TextStyle(color: Colors.white38, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B263B),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: transactions.map((tx) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF415A77),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: tx.isIncome
                                    ? Colors.greenAccent.withOpacity(0.3)
                                    : Colors.redAccent.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: tx.isIncome
                                        ? Colors.greenAccent.withOpacity(
                                            0.2,
                                          )
                                        : Colors.redAccent.withOpacity(
                                            0.2,
                                          ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    tx.isIncome
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                    color: tx.isIncome
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tx.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        tx.date,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "${tx.isIncome ? "+" : "-"} ${tx.amount.toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: tx.isIncome
                                                ? Colors.greenAccent
                                                : Colors.redAccent,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Image.asset(
                                          'assets/riyalsymbol.png',
                                          width: 16,
                                          height: 16,
                                          color: Colors.white70,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return const Text(
                                              "ر.س",
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: Text(
                                        tx.isIncome ? "وارد" : "صادر",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: tx.isIncome
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
