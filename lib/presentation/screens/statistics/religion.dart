import 'package:aussie/presentation/widgets/animated/expanded_text_tile.dart';
import 'package:aussie/presentation/widgets/animated/pie_chart.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/bar_chart.dart';
import 'package:flutter/material.dart';

import 'package:aussie/constants.dart';
import 'package:aussie/models/aussie_pie_chart.dart';

import 'package:aussie/util/functions.dart';

class ReligionScreen extends StatefulWidget {
  static final title = "religonTitle";
  static final navPath = "/statistics/religon";
  static final svgName = "pray.svg";
  @override
  _ReligionScreenState createState() => _ReligionScreenState();
}

class _ReligionScreenState extends State<ReligionScreen> {
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
    _children = _titles.map((e) => _buildPage(e)).toList();
  }

  int currentPage = 0;
  double appBarHeight = kToolbarHeight;
  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      drawer: getAppDrawer(context),
      backgroundColor: Colors.blue,
      appBar: AppBar(elevation: 0),
      body: _buildReligonPieChart(),
    );
  }

  Widget _buildReligonPieChart() {
    return Center(
      child: Wrap(
        children: [
          Text(
            getTranslation(context, "religonTitle"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          AussiePieChart(
            onBarTapped: (int page) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => _children[page])),
            chartData: [
              AussiePieChartModel(
                sectionTitle: "islam",
                value: 400,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AussiePieChartModel(
                sectionTitle: "hinduism",
                value: 100,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AussiePieChartModel(
                sectionTitle: "judaism",
                value: 200,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AussiePieChartModel(
                sectionTitle: "sikhism",
                value: 150,
                hasBadge: true,
              ),
              AussiePieChartModel(
                sectionTitle: "christian",
                value: 200,
                hasBadge: true,
                color: getRandomColor(),
              ),
              AussiePieChartModel(
                sectionTitle: "no religon",
                value: 50,
                color: getRandomColor(),
              ),
              AussiePieChartModel(
                sectionTitle: "aboriginal",
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            title: Text(title),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                AussiePieChart(
                  title: "By gender",
                  aspectRatio: 1.2,
                  sectionRadius: 120,
                  chartData: [
                    AussiePieChartModel(
                      sectionTitle: "Female",
                      value: 10,
                      color: Colors.red.shade900,
                    ),
                    AussiePieChartModel(
                      sectionTitle: "Male",
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
                ExpandingTextTile(
                  text: klorem,
                  title: "gg",
                  color: Colors.black,
                ),
              ],
              addAutomaticKeepAlives: true,
            ),
          ),
        ],
      ),
    );
  }
}
