import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/models/animated_pie_chart.dart';
import 'package:Aussie/size_config.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/animated/pie_chart.dart';
import 'package:Aussie/widgets/aussie_bar_chart.dart';

class ReligionScreen extends StatefulWidget {
  static final title = "Religon in Australlia";
  static final navPath = "/statistics/religon";
  static final svgName = "pray.svg";
  @override
  _ReligionScreenState createState() => _ReligionScreenState();
}

class _ReligionScreenState extends State<ReligionScreen> {
  PageController _scrollController = PageController();
  List<String> _titles;
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _titles = [
      "Islam",
      "Hinduism",
      "Judaism",
      "Sikhism",
      "Christian",
      "Atheist",
      "Aboriginal"
    ];
    _children = [
      _buildReligonPieChart(),
      ..._titles.map((e) => _buildPage(e)).toList(),
    ];
  }

  int currentPage = 0;
  double appBarHeight = kToolbarHeight;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, appBarHeight),
        child: AnimatedContainer(
          color: Colors.blue,
          duration: Duration(milliseconds: 300),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: appBarHeight == 0 ? 0 : 25,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          height: appBarHeight,
        ),
      ),
      body: PageView.builder(
        itemCount: _children.length,
        onPageChanged: (int page) => setState(
          () {
            if (page != 0)
              appBarHeight = 0;
            else
              appBarHeight = kToolbarHeight;
            currentPage = page;
          },
        ),
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) => _children[index],
      ),
    );
  }

  Widget _buildReligonPieChart() {
    return Center(
      child: Wrap(
        children: [
          Text(
            "The religons of Australia",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          AnimatedPieChart(
            title: "",
            aspectRatio: 1.1,
            onBarTapped: (int page) => _scrollController.animateToPage(
              page + 1,
              duration: Duration(seconds: 1),
              curve: Curves.easeOutExpo,
            ),
            chartData: [
              AnimatedPieChartModel(
                name: "islam",
                value: 400,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AnimatedPieChartModel(
                name: "hinduism",
                value: 100,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AnimatedPieChartModel(
                name: "judaism",
                value: 200,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AnimatedPieChartModel(
                name: "sikhism",
                value: 150,
                hasBadge: true,
              ),
              AnimatedPieChartModel(
                name: "christian",
                value: 200,
                hasBadge: true,
                color: getRandomColor(),
              ),
              AnimatedPieChartModel(
                name: "no religon",
                value: 50,
                color: getRandomColor(),
              ),
              AnimatedPieChartModel(
                name: "aboriginal",
                value: 50,
                color: getRandomColor(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool _) => [
          SliverAppBar(
            backgroundColor: Colors.amber,
            elevation: 0,
            collapsedHeight: 63,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _scrollController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
            ),
            title: Text(title),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            AussieBarChart(
              title: "Muslim population in Australlia",
              chartData: [
                AussieBarChartModel(76792.0, "1981"),
                AussieBarChartModel(147487.0, "1991"),
                AussieBarChartModel(281600.0, "2001"),
                AussieBarChartModel(476291.0, "2011"),
                AussieBarChartModel(604200.0, "2016"),
                AussieBarChartModel(704200.0, "2018"),
              ],
            ),
            AnimatedPieChart(
              title: "By gender",
              aspectRatio: 1.2,
              chartData: [
                AnimatedPieChartModel(
                  name: "Female",
                  value: 10,
                  color: Colors.red.shade900,
                ),
                AnimatedPieChartModel(
                  name: "Male",
                  value: 20,
                  color: Colors.blue.shade900,
                ),
              ],
            ),
            AussieBarChart(
              title: "By age",
              chartData: [
                AussieBarChartModel(129414, "0-9"),
                AussieBarChartModel(92388, "10-19"),
                AussieBarChartModel(114448, "20-29"),
                AussieBarChartModel(119010, "30-39"),
                AussieBarChartModel(70574, "40-49"),
                AussieBarChartModel(42579, "50-59"),
                AussieBarChartModel(22945, "60-69"),
                AussieBarChartModel(12885, "70+"),
              ],
            ),
            AnimatedExpandingTextTile(
              text: klorem,
              title: "gg",
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class ReligonSectionTitle extends StatelessWidget {
  final String title;

  const ReligonSectionTitle({
    @required this.title,
  }) : assert(title != null, "A religion's section title can't be null");

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      textAlign: TextAlign.center,
      maxLines: 2,
      minFontSize: 30,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
