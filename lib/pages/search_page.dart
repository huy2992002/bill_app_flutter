import 'package:flutter/material.dart';

import '../components/bill_item_search.dart';
import '../components/search_box.dart';
import '../models/authen.dart';
import '../models/bill_model.dart';
import '../services/local/shared_preferences_helper.dart';
import 'login_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String status = '';
  List<BillModel> _searches = [];
  List<BillModel> _bills = [];
  List<BillModel> _result = [];
  final SharedPreferencesHelper _prefs = SharedPreferencesHelper();


  _searchBill(String searchText) {
    searchText = searchText.toLowerCase();
    setState(() {
      if (searchText.isEmpty) {
        _result = _result;
      } else {
        _result = _bills
            .where((element) =>
                (element.name ?? '').toLowerCase().contains(searchText))
            .toList();
      }
      _searches = _result;
      if (searchText.isEmpty) {
        _searches = [];
      } 
    });
  }

  @override
  void initState() {
    //_bills = [...bills];
    _getBills();
    super.initState();
  }

  _getBills() {
    _prefs.getBills().then((value) {
      _bills = value ?? bills;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
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
                // ignore: prefer_const_constructors
                content: Row(
                  children: const [
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
              const SizedBox(
                height: 15,
              ),
              SearchBox(
                onChanged: (value) {
                  setState(() {
                    _searchBill(value);
                  });
                },
                hintText: 'Tìm kiếm hóa đơn',
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    BillModel bill = _searches.toList()[index];
      
                    if (bill.isPay == true) {
                      status = 'Đã Thanh Toán';
                    } else {
                      status = 'Chưa Thanh Toán';
                    }
      
                    return BillItemSearch(
                      bill: bill,
                      status: status,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: _searches.length)
            ],
          ),
        ),
      ),
      
    );
  }
}
