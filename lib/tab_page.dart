import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_project/app_colors.dart' as AppColors;

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [MyHomePage(), SecondPage(), ThirdPage()];

  void onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTabChanged,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'First',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Second',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Third',
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List books;
  late ScrollController _scrollController;
  late TabController _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              //Top NavBar
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(AssetImage("img/menu.png"),
                        size: 24, color: Colors.black),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.notifications),
                      ],
                    ),
                  ],
                ),
              ),
              //MenuTabBar
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(),
                  ];
                },
                //Content
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                        itemCount: books == null ? 0 : books.length,
                        itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVarViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(books[i]["img"]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 24,
                                                color: AppColors.starColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                books[i]["rating"],
                                                style: TextStyle(
                                                    color:
                                                        AppColors.menu2Color),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            books[i]["title"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            books[i]["text"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                color: AppColors.subTitleText),
                                          ),
                                          Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: AppColors.loveColor,
                                            ),
                                            child: Text(
                                              "View",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: "Avenir",
                                                color: Colors.white,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage("img/pic-6.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage("img/pic-7.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage("img/pic-8.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage("img/pic-9.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}

class ThirdPage extends StatelessWidget {
  ThirdPage({super.key});
  double itemWidth = 300;
  double itemHeight = 150;

  @override
  Widget build(BuildContext context) {
    var ort = MediaQuery.of(context).orientation;
    Widget layout = const Text('');
    Axis direction = Axis.vertical;

    if (ort == Orientation.portrait) {
      itemWidth = 300;
      itemHeight = 150;
      layout = layoutPortrait();
      direction = Axis.vertical;
    } else if (ort == Orientation.landscape) {
      itemWidth = 200;
      itemHeight = 200;
      layout = layoutLandScape();
      direction = Axis.horizontal;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Reponsive Layout"),
        ),
        body: SingleChildScrollView(
          scrollDirection: direction,
          padding: EdgeInsets.all(20),
          child: Center(
            child: layout,
          ),
        ),
      ),
    );
  }

  Widget layoutPortrait() {
    return Column(
      children: [
        boxContainer("Honkai: Star rail"),
        boxContainer("Honkai Impact 3rd"),
        boxContainer("Genshin Impact"),
        boxContainer("Zenless Zone Zero"),
        boxContainer("Punishing Grey Raven"),
        boxContainer("Wuthering Wave"),
        boxContainer("Pokemon Infinite Fusion"),
        boxContainer("Overwatch 2"),
        boxContainer("Roblox"),
        boxContainer("Tomb Raider"),
        boxContainer("A Plague Tale"),
        boxContainer("Control"),
      ],
    );
  }

  Widget layoutLandScape() {
    return Row(
      children: [
        boxContainer("Honkai: Star rail"),
        boxContainer("Honkai Impact 3rd"),
        boxContainer("Genshin Impact"),
        boxContainer("Zenless Zone Zero"),
        boxContainer("Honkai: Star rail"),
        boxContainer("Punishing Grey Raven"),
        boxContainer("Wuthering Wave"),
        boxContainer("Pokemon Infinite Fusion"),
        boxContainer("Overwatch 2"),
        boxContainer("Roblox"),
        boxContainer("Tomb Raider"),
        boxContainer("A Plague Tale"),
        boxContainer("Control"),
      ],
    );
  }

  Widget boxContainer(String text) {
    return Container(
      child: Text(
        text,
        textScaleFactor: 1.5,
      ),
      width: itemWidth,
      height: itemHeight,
      color: Color.fromARGB(255, 0, 128, 255),
      margin: const EdgeInsets.all(20),
      alignment: Alignment.center,
    );
  }
}
