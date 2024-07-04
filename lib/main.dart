import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    FavoriteStocksScreen(),
    StockInfoScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기업분석 딸깍'),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '종목정보',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class FavoriteStocksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          StockAnalysis(
            logo: Icons.account_balance_wallet,
            name: '삼성전자',
            status: '주의',
            statusColor: Colors.orange,
          ),
          SizedBox(height: 10),
          StockAnalysis(
            logo: Icons.assessment,
            name: 'LG전자',
            status: '양호',
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class StockAnalysis extends StatelessWidget {
  final IconData logo;
  final String name;
  final String status;
  final Color statusColor;

  const StockAnalysis({
    Key? key,
    required this.logo,
    required this.name,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(logo, size: 40),
        title: Text('$name'),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$status',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StockInfoScreen extends StatefulWidget {
  @override
  _StockInfoScreenState createState() => _StockInfoScreenState();
}

class _StockInfoScreenState extends State<StockInfoScreen> {
  final TextEditingController _controller = TextEditingController();
  String _searchResult = '';

  void _onSearchPressed() {
    setState(() {
      _searchResult = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: '검색',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _onSearchPressed,
              ),
            ],
          ),
          SizedBox(height: 20),
          _searchResult.isNotEmpty ? Text('검색 결과: $_searchResult') : Container(),
          StockInfo(
            name: '삼성전자',
            status: '불량',
            details: '연 매출 76억 미만',
          ),
        ],
      ),
    );
  }
}

class StockInfo extends StatelessWidget {
  final String name;
  final String status;
  final String details;

  const StockInfo({
    Key? key,
    required this.name,
    required this.status,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(status),
            Text(details),
          ],
        ),
        trailing: Icon(Icons.warning, color: Colors.red),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('글씨 크기'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 글씨 크기 설정 화면으로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('상품 개선을 위한 건의'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 건의 사항 화면으로 이동
            },
          ),
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text('다크 모드 선택'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                // 다크 모드 설정 변경
              },
            ),
          ),
        ],
      ),
    );
  }
}