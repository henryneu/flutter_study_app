import 'package:camera/camera.dart';
import 'package:first_flutter_app/models/cart_model.dart';
import 'package:first_flutter_app/page/AsyncUIPage.dart';
import 'package:first_flutter_app/page/CustomPainterPage.dart';
import 'package:first_flutter_app/page/CustomScrollViewPage.dart';
import 'package:first_flutter_app/page/FileOperationPage.dart';
import 'package:first_flutter_app/page/GestureDetectorPage.dart';
import 'package:first_flutter_app/page/GradientButtonPage.dart';
import 'package:first_flutter_app/page/GradientCircularProgressPage.dart';
import 'package:first_flutter_app/page/InfiniteGridViewPage.dart';
import 'package:first_flutter_app/page/InfiniteListViewPage.dart';
import 'package:first_flutter_app/page/ProviderRoutePage.dart';
import 'package:first_flutter_app/page/ProviderRoutePageOne.dart';
import 'package:first_flutter_app/page/ScrollControllerPage.dart';
import 'package:first_flutter_app/page/ThemeChangePage.dart';
import 'package:first_flutter_app/page/TurnBoxPage.dart';
import 'package:first_flutter_app/page/animation/AnimatedSwitcherCounterPage.dart';
import 'package:first_flutter_app/page/animation/AnimatedWidgetsPage.dart';
import 'package:first_flutter_app/page/animation/HeroAnimationRoutePage.dart';
import 'package:first_flutter_app/page/animation/HeroRadialAnimationPage.dart';
import 'package:first_flutter_app/page/animation/ScaleAnimationRoutePage.dart';
import 'package:first_flutter_app/page/animation/StaggerAnimationPage.dart';
import 'package:first_flutter_app/page/net/HttpFuturePage.dart';
import 'package:first_flutter_app/page/net/WebSocketPage.dart';
import 'package:first_flutter_app/page/notification/NotificationSendPage.dart';
import 'package:first_flutter_app/page/tabview/CustomTabViewPage.dart';
import 'package:first_flutter_app/page/tabview/TabViewPinnedPage.dart';
import 'package:first_flutter_app/provider/ChangeNotifierProvider.dart';
import 'package:first_flutter_app/widget/shopping/ShoppingList.dart';
import 'package:first_flutter_app/widget/shopping/ShoppingListItem.dart';
import 'package:first_flutter_app/widget/tapbox/ParentWidget.dart';
import 'package:first_flutter_app/widget/tapbox/ParentWidgetC.dart';
import 'package:first_flutter_app/widget/tapbox/TapboxA.dart';
import 'package:first_flutter_app/widget/CounterWidget.dart';
import 'package:first_flutter_app/widget/text/ClearTextField.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'page/texture/CameraExamplePage.dart';
import 'widget/FavoriteWidget.dart';
import 'dart:math' as math;
import 'package:fluttertoast/fluttertoast.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(new MyApp());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: ScaffoldRouteWidget(),
    );
  }
}

class ScaffoldRouteWidget extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() {
    return new _ScaffoldRouteState();
  }
}

class _ScaffoldRouteState extends State<ScaffoldRouteWidget>
    with SingleTickerProviderStateMixin {
  int _tabSelectedIndex = 1;

  TabController _tabController; //需要定义一个Controller
  List tabs = ["新闻", "游戏", "图片"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _tabSelectedIndex = index;
    });
  }

  void _onAdd() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.dashboard),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('完美头条'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      drawer: new RightDrawer(),
      endDrawer: new RightDrawer(),
      /*bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('school')),
        ],
        currentIndex: _tabSelectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),*/
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
            ),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.business)),
          ],
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return Container(
              alignment: Alignment.center,
              child: Text(e, textScaleFactor: 5),
            );
          }).toList()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class RightDrawer extends StatelessWidget {
  const RightDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.only(top: 38.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/lake.jpg',
                          width: 80.0,
                        ),
                      ),
                    ),
                    Text(
                      'Henry',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add account'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Manage accounts'),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: [
          new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      'Oeschinen Lake Campground',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Text(
                    'Kandersteg, Switzerland',
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  )
                ],
              )),
          /*new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text('41'),*/
          new FavoriteWidget(),
        ],
      ),
    );

    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          )
        ],
      );
    }

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = new Container(
      padding: EdgeInsets.all(32.0),
      child: new Text(
        '''
        Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );

    var boxSection = new Center(
      //child: TapboxA(),
      //child: ParentWidget(),
      //child: ParentWidgetC(),
      child: CounterWidget(),
    );

    var titleText = new Container(
      padding: new EdgeInsets.all(10.0),
      child: new Text(
        'Strawberry Pavlova',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    var subText = new Container(
      padding: new EdgeInsets.all(10.0),
      child: new Text(
        '''
        Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
      ),
    );

    var ratings = new Container(
      padding: new EdgeInsets.all(20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new Icon(Icons.star, color: Colors.black),
              new Icon(Icons.star, color: Colors.black),
              new Icon(Icons.star, color: Colors.black),
              new Icon(Icons.star, color: Colors.black),
              new Icon(Icons.star, color: Colors.black),
            ],
          ),
          new Text(
            '170 Reviews',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );

    var descTextStyle = new TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      fontSize: 14.0,
      height: 2.0,
    );

    var iconList = DefaultTextStyle.merge(
        style: descTextStyle,
        child: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Column(
                children: [
                  new Icon(Icons.kitchen, color: Colors.green[500]),
                  new Text('PREP:'),
                  new Text('25 min'),
                ],
              ),
              new Column(
                children: [
                  new Icon(Icons.timer, color: Colors.green[500]),
                  new Text('COOK:'),
                  new Text('1 hr'),
                ],
              ),
              new Column(
                children: [
                  new Icon(Icons.restaurant, color: Colors.green[500]),
                  new Text('FEEDS:'),
                  new Text('4-6'),
                ],
              ),
            ],
          ),
        ));

    var leftColumn = new Container(
      padding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      child: new Column(
        children: [
          titleText,
          subText,
          ratings,
          iconList,
        ],
      ),
    );

    var mainImage = new Image.asset(
      'assets/images/lake.jpg',
      width: 600.0,
      height: 240.0,
      fit: BoxFit.fitWidth,
    );

    Widget evaluationSection = new Container(
      margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: new Card(
        child: new Column(
          children: [
            new Container(
              width: 340.0,
              child: leftColumn,
            ),
            mainImage,
          ],
        ),
      ),
    );

    List<Container> _buildGridTileList(int count) {
      return new List<Container>.generate(
          count,
              (index) => new Container(
              child: new Image.asset(
                'assets/images/lake.jpg',
              )));
    }

    Widget buildGrid() {
      return new GridView.extent(
          maxCrossAxisExtent: 150.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: _buildGridTileList(20));
    }

    List<Widget> list = <Widget>[
      new ListTile(
        title: new Text(
          'CineArts at the Empire',
          style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
        ),
        subtitle: new Text('85 W Portal Ave'),
        leading: new Icon(
          Icons.theaters,
          color: Colors.blue[500],
        ),
      ),
      new ListTile(
        title: new Text(
          'The Castro Theater',
          style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
        ),
        subtitle: new Text('429 Castro St'),
        leading: new Icon(
          Icons.theaters,
          color: Colors.blue[500],
        ),
      ),
    ];

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        //primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      /*home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Flutter Demo'),
            elevation: 1,
          ),
          */ /*body: new ListView(
          children: [
            new Image.asset(
              'assets/images/lake.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            boxSection,
            textSection,
            evaluationSection,
          ],
        ),*/ /*
          */ /*body: new ShoppingList(
            productList: <Product>[
              new Product(name: 'Android'),
              new Product(name: 'Flutter'),
              new Product(name: 'ThemeData'),
              new Product(name: 'MaterialApp'),
            ],
          ),*/ /*
          */ /*body: new Center(
          child: buildGrid(),
        ),*/ /*
          */ /*body: new Center(
          child: new ListView(
            children: list,
          ),
        ),*/ /*
          */ /*body: new Stack(
          alignment: const Alignment(0.6, 0.6),
          children: [
            new CircleAvatar(
              backgroundImage: new AssetImage('assets/images/lake.jpg'),
              radius: 100.0,
            ),
            new Container(
              decoration: new BoxDecoration(
                color: Colors.black45,
              ),
              child: new Text(
                'Henry',
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),*/ /*
          */ /*body: new SizedBox(
            height: 210.0,
            child: new Card(
              child: new Column(
                children: [
                  new ListTile(
                    title: new Text('1625 Main Street',
                        style: new TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: new Text('My City, CA 99984'),
                    leading: new Icon(
                      Icons.restaurant_menu,
                      color: Colors.blue[500],
                    ),
                  ),
                  new Divider(),
                  new ListTile(
                    title: new Text('(408) 555-1212',
                        style: new TextStyle(fontWeight: FontWeight.w500)),
                    leading: new Icon(
                      Icons.contact_phone,
                      color: Colors.blue[500],
                    ),
                  ),
                  new ListTile(
                    title: new Text('costa@example.com'),
                    leading: new Icon(
                      Icons.contact_mail,
                      color: Colors.blue[500],
                    ),
                  ),
                ],
              ),
            ),
          ),*/ /*
      ),*/
      //home: new RandomWords(),
      //home: ClearTextFieldPage(title: 'Flutter Demo ClearTextField'),
      home: InfiniteListViewPage(),
      //home: InfiniteGridViewPage(),
      //home: CustomScrollViewPage(),
      //home: ScrollControllerPage(),
      //home: ScaleAnimationRoutePage(),
      //home: HeroAnimationRoutePage(),
      //home: StaggerAnimationRoutePage(),
      //home: CustomTabViewPage(),
      //home: HeroRadialAnimationPage(),
      //home: AnimatedWidgetsPage(),
      //home: TurnBoxPage(),
      //home: GradientButtonPage(),
      //home: CustomPainterPage(),
      //home: GradientCircularProgressPage(),
      //home: FileOperationPage(),
      //home: HttpFuturePage(),
      //home: WebSocketPage(),
      //home: CameraExampleHome(),
      //home: TestPage(),
    );
  }
}

class ClearTextFieldPage extends StatefulWidget {
  ClearTextFieldPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ClearTextFieldPageState createState() => _ClearTextFieldPageState();
}

class _ClearTextFieldPageState extends State<ClearTextFieldPage> {
  int _counter = 0;

  String _phoneNumber;
  String _authNumber;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toastInputCallback() {
    Fluttertoast.showToast(
        msg: _phoneNumber,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),*/
            Container(
              margin: new EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: ClearTextField(
                keyboardType: ITextInputType.text,
                prefixIcon: Icon(Icons.phone_android),
                labelText: '手机号码',
                hintText: '请输入手机号',
                hintStyle: TextStyle(color: Colors.grey),
                textStyle: TextStyle(color: Colors.black),
                fieldCallBack: (content) {
                  _phoneNumber = content;
                  print(_phoneNumber);
                },
              ),
            ),
            Container(
              margin: new EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: ClearTextField(
                keyboardType: ITextInputType.password,
                prefixIcon: Icon(Icons.https),
                labelText: '密码',
                hintText: '请输入密码',
                hintStyle: TextStyle(color: Colors.grey),
                textStyle: TextStyle(color: Colors.black),
                fieldCallBack: (content) {
                  _authNumber = content;
                },
              ),
            ),
            /*Container(
              margin: new EdgeInsets.symmetric(vertical: 32.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  */ /*child: Transform.translate(
                    offset: Offset(16.0, 10.0),
                    child: Transform.rotate(
                      angle: math.pi / 2,
                      child: Text("Hello world"),
                    ),
                  )),*/ /*
                  child: Transform.rotate(
                    angle: math.pi / 2,
                    child: Transform.translate(
                      offset: Offset(16.0, 10.0),
                      child: Text("Hello world"),
                    ),
                  )),
            ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toastInputCallback,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _bigTextStyle = const TextStyle(fontSize: 16.0);
  final _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        elevation: 1,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _bigTextStyle,
                ),
              );
            },
          );
          final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
              elevation: 1,
            ),
            body: new ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  Widget buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRaw(_suggestions[index]);
      },
    );
  }

  Widget _buildRaw(WordPair wordPair) {
    final alreadySaved = _saved.contains(wordPair);
    return new ListTile(
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
      title: new Text(
        wordPair.asPascalCase,
        style: _bigTextStyle,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
    );
  }
}
