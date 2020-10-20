import 'package:Aussie/constants.dart';
import 'package:Aussie/models/animated_pie_chart.dart';
import 'package:Aussie/size_config.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/animated/pie_chart.dart';
import 'package:flutter/material.dart';

class ReligionScreen extends StatefulWidget {
  @override
  _ReligionScreenState createState() => _ReligionScreenState();
}

class _ReligionScreenState extends State<ReligionScreen> {
  static PageController _scrollController = PageController();
  List<Widget> _children = [
    _buildReligonPages(),
    _buildPage("Islam"),
    _buildPage("Hinduism"),
    _buildPage("Judaism"),
    _buildPage("Sikhism"),
    _buildPage("Christian"),
    _buildPage("Atheist"),
  ];

  static Widget _buildPage(String title) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          AnimatedExpandingTextTile(
            title: "In Australlia",
            text: klorem,
          ),
          AnimatedExpandingTextTile(
            title: "In Australlia",
            text: klorem,
          ),
        ],
      ),
    );
  }

  int currentPage = 0;
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
      ),
      body: PageView.builder(
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
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
