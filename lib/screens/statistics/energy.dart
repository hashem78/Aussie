import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/models/aussie_pie_chart.dart';
import 'package:Aussie/util/pair.dart';
import 'package:Aussie/widgets/animated/pie_chart.dart';
import 'package:Aussie/widgets/aussie_bar_chart.dart';

class EnergyScreen extends StatelessWidget {
  static final title = "Energy & Australlia";
  static final navPath = "/statistics/energy";
  static final svgName = "energy.svg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool _) => [
          SliverAppBar(
            backgroundColor: Colors.amber,
            title: Text("Energy"),
            centerTitle: true,
          ),
        ],
        body: ListView(
          addAutomaticKeepAlives: true,
          children: [
            AussiePieChart(
              title: "Energy production by renewability",
              chartData: [
                AussiePieChartModel(
                  color: Colors.red,
                  sectionTitle: "Renewables(15%)",
                  value: 32694.7,
                ),
                AussiePieChartModel(
                  color: Colors.purple,
                  sectionTitle: "Non-Renewables(85%)",
                  value: 185945,
                ),
              ],
              aspectRatio: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: AussieBarChart(
                title: "Energy generation/Non-renewables (GWh)",
                chartData: [
                  AussieBarChartModel(151742.7, "Coal & by-products"),
                  AussieBarChartModel(33799.7, "Natural Gas"),
                  AussieBarChartModel(402.6, "Other"),
                ],
              ),
            ),
            AussieBarChart(
              title: "Energy generation/Renewables (GWh)",
              chartData: [
                AussieBarChartModel(729.2, "Solar"),
                AussieBarChartModel(15811.8, "Hydro"),
                AussieBarChartModel(14744.3, "Wind"),
                AussieBarChartModel(14744.3, "Other"),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            EnergyDataTable(
              title: "Domestic Energy use \$AUS",
              data: [
                Pair("Petroleum", "\$66 billion"),
                Pair("Petroleum", "\$66 billion"),
                Pair("Petroleum", "\$66 billion"),
                Pair("Petroleum", "\$66 billion"),
                Pair("Petroleum", "\$66 billion"),
              ],
            ),
            EnergyDataTable(
              title: "Domestic Energy use \$AUS",
              data: [
                Pair("Petroleum", "\$66 billion"),
                Pair("Petroleum", "\$66 billion"),
                Pair("Petroleum", "\$66 billion"),
                Pair("Petroleum", "\$66 billion"),
                Pair("Petroleum", "\$66 billion"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EnergyDataTable extends StatelessWidget {
  final List<Pair<String, String>> data;
  final String title;
  const EnergyDataTable({
    @required this.data,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeText(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          minFontSize: 30,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        DataTable(
          headingRowHeight: 0,
          dataTextStyle: TextStyle(fontWeight: FontWeight.bold),
          columns: [
            DataColumn(label: Container()),
            DataColumn(label: Container()),
          ],
          rows: data
              .map(
                (e) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        e.first,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(Text(e.second))
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
