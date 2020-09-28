import 'package:flutter/material.dart';

/*const url =
    'http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var tabTitle = [
    '页面1',
    '页面2',
    '页面3',
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: tabTitle.length,
        child: Scaffold(
          body: new NestedScrollView(
            headerSliverBuilder: (context, bool) {
              return [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        "我是可以跟着滑动的title",
                      ),
                      background: Image.network(
                        url,
                        fit: BoxFit.cover,
                      )),
                ),
                new SliverPersistentHeader(
                  delegate: new SliverTabBarDelegate(
                    new TabBar(
                      tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                      indicatorColor: Colors.red,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.red,
                    ),
                    color: Colors.white,
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: tabTitle
                  .map((s) => ListView.builder(
                        itemBuilder: (context, int) => Text("123"),
                        itemCount: 50,
                      ))
                  .toList(),
            ),
          ),
        ));
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}*/
class TestPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TestPage> with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text("首页"),
          ),
          body: NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 280,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Container(//头部整个背景颜色
                        height: double.infinity,
                        color: Color(0xffcccccc),
                        child: Column(
                          children: <Widget>[
//                            _buildBanner(),
                            _buildButtons(),
                            _buildTabBarBg()
                          ],
                        ),
                      ),
                    ),
                    bottom: TabBar(controller: _tabController, tabs: [
                      Tab(text: "aaa"),
                      Tab(text: "bbb"),
                      Tab(text: "ccc"),
                    ]),
                  )
                ];
              },
              body: TabBarView(controller: _tabController, children: [
                _buildListView("aaa:"),
                _buildListView("bbb:"),
                _buildListView("ccc:"),
              ]))),
    );
  }

  /*Widget _buildBanner() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      height: 144,
      child: Swiper(//第三方的banner库：flutter_swiper
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 144,
              child: Image.network(
                "https://github.com/best-flutter/flutter_swiper/raw/master/banner.jpg",
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: 3,
          scale: 0.9,
          pagination: new SwiperPagination()),
    );
  }*/

  //banner下面的按钮
  Widget _buildButtons() {
    return Expanded(
      child: Row(
        children: <Widget>[
          _buildButtonItem(Icons.chat, "xxxx"),
          Image.asset("assets/images/phone_flow_chart_arrow.png", height: 8),
          _buildButtonItem(Icons.pages, "xxxx"),
          Image.asset("assets/images/phone_flow_chart_arrow.png", height: 8),
          _buildButtonItem(Icons.phone_android, "xxxx"),
          Image.asset("assets/images/phone_flow_chart_arrow.png", height: 8),
          _buildButtonItem(Icons.print, "xxxx"),
        ],
      ),
    );
  }

  Widget _buildButtonItem(IconData icon, String text) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 28.0),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(text, style: TextStyle(color: Color(0xff999999), fontSize: 12)),
            )
          ],
        ));
  }

  Widget _buildTabBarBg() {
    return Container(  //TabBar圆角背景颜色
      height: 50,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(color: Colors.white)),
    );
  }

  Widget _buildListView(String s){
    return ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) =>Divider(color: Colors.grey,height: 1,),
        itemBuilder: (BuildContext context, int index) {
          return Container(color: Colors.white, child: ListTile(title: Text("$s第$index 个条目")));
        });
  }
}
