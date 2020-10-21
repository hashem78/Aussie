import 'package:Aussie/models/animated_pie_chart.dart';
import 'package:Aussie/size_config.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/animated/pie_chart.dart';
import 'package:Aussie/widgets/aussie_bar_chart.dart';
import 'package:flutter/material.dart';

class ReligionScreen extends StatefulWidget {
  @override
  _ReligionScreenState createState() => _ReligionScreenState();
}

class _ReligionScreenState extends State<ReligionScreen> {
  static PageController _scrollController = PageController();
  static List<String> _titles = [
    "Islam",
    "Hinduism",
    "Judaism",
    "Sikhism",
    "Christian",
    "Atheist"
  ];
  List<Widget> _children = [
    _buildReligonPages(),
    ..._titles.map((e) => _buildPage(e)).toList(),
  ];

  static Widget _buildPage(String title) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AussieBarChart(),
        AussieBarChart(),
      ],
    );
  }

  int currentPage = 0;
  String currentAppBarTitle;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: currentPage == 0,
        leading: currentPage != 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _scrollController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                },
              )
            : null,
        title: currentPage != 0 ? Text(currentAppBarTitle) : null,
      ),
      body: PageView.builder(
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
            if (currentPage != 0) currentAppBarTitle = _titles[currentPage - 1];
          });
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) => _children[index],
      ),
    );
  }

  static Widget _buildReligonPages() {
    return Column(
      children: [
        Text(
          "The religons of Australia",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: AnimatedPieChart(
            controller: _scrollController,
            chartData: [
              AnimatedPieChartModel(
                name: "islam",
                value: 40,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AnimatedPieChartModel(
                name: "hinduism",
                value: 10,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AnimatedPieChartModel(
                name: "judaism",
                value: 20,
                color: getRandomColor(),
                hasBadge: true,
              ),
              AnimatedPieChartModel(
                name: "sikhism",
                value: 15,
                hasBadge: true,
              ),
              AnimatedPieChartModel(
                name: "christian",
                value: 20,
                hasBadge: true,
                color: getRandomColor(),
              ),
              AnimatedPieChartModel(
                name: "no religon",
                value: 5,
                color: getRandomColor(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
