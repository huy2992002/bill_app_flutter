import 'package:flutter/material.dart';
import '../components/bill_item.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../models/authen.dart';
import '../models/bill_model.dart';
import '../services/local/shared_preferences_helper.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textName = TextEditingController();
  TextEditingController textQuantity = TextEditingController();
  TextEditingController textPrice = TextEditingController();
  double totalPrice = 0;
  BillModel bill = BillModel();
  double sum = 0;
  bool isvip = false;
  final SharedPreferencesHelper _prefs = SharedPreferencesHelper();
  List<BillModel> _bills = [];
  List<BillModel> _showbills = [];

  @override
  void initState() {
    super.initState();
    _getBills();
    for (var bill in bills) {
      sum += bill.totalPrice;
    }
  }

  _getBills() {
    _prefs.getBills().then((value) {
      _bills = value ?? bills;
      _showbills = [..._bills];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'THÔNG TIN HÓA ĐƠN',
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
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomTextField(
                controller: textName,
                hintText: 'Nhập Tên',
                labelText: 'Nhập tên',
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: textQuantity,
                      hintText: 'Nhập Số Lượng',
                      labelText: 'Nhập Số Lượng',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomTextField(
                      controller: textPrice,
                      hintText: 'Nhập Giá Sách',
                      labelText: 'Nhập Giá Sách',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      Checkbox(
                        value: isvip,
                        onChanged: (value) {
                          setState(() {
                            isvip = !isvip;
                          });
                        },
                        fillColor: const MaterialStatePropertyAll(Colors.red),
                        activeColor: Colors.red,
                      ),
                      const Text(
                        'Khách Hàng Vip (discount 10%)',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        if (textName.text == '' ||
                            textQuantity.text == '' ||
                            textPrice.text == '') {
                          const snackBar = SnackBar(
                            content: Text('Vui lòng không để trống'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          double quantity =
                              double.parse(textQuantity.text.trim());
                          double price = double.parse(textPrice.text.trim());

                          setState(() {
                            if (isvip == false) {
                              totalPrice = quantity * price;
                            } else {
                              totalPrice = (quantity * price) * (0.9);
                            }
                          });
                        }
                      },
                      text: 'Thành Tiền',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${totalPrice.toStringAsFixed(0)} VND',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  // bills.insert(
                  //   0,
                  //   BillModel(
                  //     name: textName.text.toString(),
                  //     quantity: int.parse(textQuantity.text.trim()),
                  //     price: double.parse(textPrice.text.trim()),
                  //     isVip: isvip,
                  //   ),
                  // );

                  if (textName.text == '' ||
                      textQuantity.text == '' ||
                      textPrice.text == '') {
                    const snackBar = SnackBar(
                      content: Text('Vui lòng không để trống'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    BillModel bill = BillModel()
                      ..name = textName.text.toString()
                      ..quantity = int.parse(textQuantity.text.trim())
                      ..price = double.parse(textPrice.text.trim())
                      ..isVip = isvip;

                    //_bills.add(bill);
                    _bills.insert(0, bill);
                    _prefs.addBills(_bills);
                    _getBills();
                    setState(() {});

                    sum = sum + totalPrice;

                    setState(() {
                      textName.text = '';
                      textQuantity.text = '';
                      textPrice.text = '';
                      totalPrice = 0;
                      isvip = false;
                      FocusScope.of(context).unfocus();
                    });
                  }
                },
                text: 'Lưu Thông Tin',
              ),
              const SizedBox(height: 20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _showbills.length,
                itemBuilder: (context, index) {
                  BillModel bill = _showbills.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: BillItem(
                      bill: bill,
                      onChange: (p0) async {
                        bool? status = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Thông Báo'),
                            content: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Hóa đơn đã được thanh toán',
                                    style: TextStyle(fontSize: 22.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Sai'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Đúng'),
                              ),
                            ],
                          ),
                        );
                        if (status ?? false) {
                          setState(() {
                            bill.isPay = true;
                            _prefs.addBills(_bills);
                          });
                        }
                      },
                      onDelete: () async {
                        bool? status = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Thông Báo'),
                            content: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Bạn có muốn xóa hóa đơn',
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
                          setState(() {
                            _bills.remove(bill);
                            _prefs.addBills(_bills);
                            _getBills();
                          });
                        }
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      
    );
  }
}
