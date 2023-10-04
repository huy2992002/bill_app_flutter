import 'package:flutter/material.dart';

import '../models/authen.dart';
import '../models/bill_model.dart';
import '../services/local/shared_preferences_helper.dart';
import 'login_page.dart';

class InfomationPage extends StatefulWidget {
  const InfomationPage({super.key});

  @override
  State<InfomationPage> createState() => _InfomationPageState();
}

class _InfomationPageState extends State<InfomationPage> {
  double sum = 0;
  double sumVip = 0;
  double sumPay = 0;
  List<BillModel> _bills = [];
  final SharedPreferencesHelper _prefs = SharedPreferencesHelper();

  @override
  void initState() {
    super.initState();
    _getBills();
  }

  _getBills() {
    _prefs.getBills().then((value) {
      _bills = value ?? bills;
      for (var bill in _bills) {

        sum += bill.totalPrice;
      }
      for (var bill in _bills) {
        if (bill.isVip == true) {
          sumVip = sumVip + 1;
        }
      }
      for (var bill in _bills) {
        if (bill.isPay == true) {
          sumPay = sumPay + 1;
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thống Kê Hóa Đơn',
          style: TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () async {
            bool? status = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Thông Báo',
                  style: TextStyle(color: Colors.red),
                ),
                content: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Bạn có muốn Đăng Xuất?',
                        style: TextStyle(fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Không'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Có'),
                  ),
                ],
              ),
            );
            if (status ?? false) {
              Authen.username = Authen.username;
              Authen.password = Authen.password;
              Authen.isLogin = false;
              await Authen.saveData();
              await Authen.loadData();
              Route route = MaterialPageRoute(
                builder: (context) => const LoginPage(),
              );
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context,
                route,
                (Route<dynamic> route) => false,
              );
            }
          },
          child: const Icon(Icons.logout),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 30),
            Row(
              children: [
                const Text('Tổng số hóa đơn'),
                const Spacer(),
                Text(_bills.length.toStringAsFixed(0)),
              ],
            ),
            Row(
              children: [
                const Text('Tổng số hóa đơn vip'),
                const Spacer(),
                Text(sumVip.toStringAsFixed(0)),
              ],
            ),
            Row(
              children: [
                const Text('Tổng số hóa đơn đã thanh toán'),
                const Spacer(),
                Text(sumPay.toStringAsFixed(0)),
              ],
            ),
            Row(
              children: [
                const Text('Tổng số hóa đơn chưa thanh toán'),
                const Spacer(),
                Text((_bills.length - sumPay).toStringAsFixed(0)),
              ],
            ),
            Row(
              children: [
                const Text('Tổng doanh thu khi tất cả thanh toán'),
                const Spacer(),
                Text('${sum.toStringAsFixed(0)} VND'),
              ],
            ),
          ]),
        ),
      ),

    );
  }
}
