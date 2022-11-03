import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loyaltyapp/dashboard/bloc/dashboard_bloc.dart';
import 'package:loyaltyapp/dashboard/dashboard_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/utils/ui/clip_paths/dashboard_clip.dart';
import 'package:loyaltyapp/utils/ui/pgbison_app_theme.dart';
import 'package:loyaltyapp/widgets/bottom_navigator.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';
import 'package:loyaltyapp/widgets/destination.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as syc;
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "/dashboard";
  const DashboardScreen({Key key, this.destination}) : super(key: key);
  /*static Route route() {
    return MaterialPageRoute<void>(builder: (_) => DashboardScreen());
  }*/
  final Destination destination;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //int _currentIndex = 0;
  DashboardBloc _bloc;
  Map<String, double> dataMap = {
    "Claimed": 5,
    "Approved": 3,
    "Reversed": 2,
    "Rejected": 2,
  };

  @override
  void initState() {
    _bloc = DashboardBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 16,
            fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
            fontWeight: FontWeight.w600,
            color: PGBisonAppTheme.pg_White,
          ),
        ),
        backgroundColor: PGBisonAppTheme.pg_green_3,
      ),
      drawer: AppDrawer(),
      //bottomNavigationBar: BottomNavigator(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: RefreshIndicator(
          onRefresh: () => _bloc.fetchDashboardList(),
          child: StreamBuilder<ApiResponse<dynamic>>(
            stream: _bloc.dashboardListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.data);
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return DashboardItems(dashboard: snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () => _bloc.fetchDashboardList());
                    break;
                }
              }
              return Container();
            },
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class DashboardList extends StatelessWidget {
  final List<DashboardModel> dashboardList;

  const DashboardList({Key key, this.dashboardList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dashboardList?.length ?? 0,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Item'),
                  ),
                  Expanded(
                    child: Text('Date'),
                  )
                ],
              )
            ],
          );
        }
        index -= 1;
        return GestureDetector(
          onTap: () {},
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: Text(dashboardList[index].item),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(dashboardList[index].date),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DashboardItems extends StatefulWidget {
  final DashboardModel dashboard;
  //final Map<String, double> dataMap;

  DashboardItems({
    Key key,
    this.dashboard,
  }) : super(key: key);
  @override
  _DashboardItemsState createState() => _DashboardItemsState();
}

class _DashboardItemsState extends State<DashboardItems> {
  List<_ChartData> data = [
    _ChartData('CHN', 12),
    _ChartData('GER', 15),
    _ChartData('RUS', 30),
    _ChartData('BRZ', 6.4),
    _ChartData('IND', 14)
  ];
  syc.TooltipBehavior _tooltip = syc.TooltipBehavior(enable: false);

  /// Returns the list of chart series which need to render on the barchart.
  List<syc.BarSeries<ChartSampleData, String>> _getDefaultBarSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Jun',
          y: 64452000,
          secondSeriesYValue: 62682000,
          thirdSeriesYValue: 66861000),
      ChartSampleData(
          x: 'Jul',
          y: 68175000,
          secondSeriesYValue: 55315000,
          thirdSeriesYValue: 61786000),
      ChartSampleData(
          x: 'Aug',
          y: 57774000,
          secondSeriesYValue: 56407000,
          thirdSeriesYValue: 56941000),
      ChartSampleData(
          x: 'Sep',
          y: 50732000,
          secondSeriesYValue: 52372000,
          thirdSeriesYValue: 58253000),
      ChartSampleData(
          x: 'Oct',
          y: 32093000,
          secondSeriesYValue: 35079000,
          thirdSeriesYValue: 39291000),
      ChartSampleData(
          x: 'Nov',
          y: 34436000,
          secondSeriesYValue: 35814000,
          thirdSeriesYValue: 37651000),
    ];
    return <syc.BarSeries<ChartSampleData, String>>[
      syc.BarSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          color: PGBisonAppTheme.pg_Green,
          name: 'Silver'),
      syc.BarSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          color: PGBisonAppTheme.pg_orange_1,
          name: 'Gold'),
      syc.BarSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x as String,
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
          color: PGBisonAppTheme.pg_Red,
          name: 'Platinum')
    ];
  }

  @override
  Widget build(BuildContext context) {
    /*Map<String, double> dataMap = {
      "Claimed": dashboard.claims.claimedCount.toDouble(),
      "Approved": dashboard.claims.approvedCount.toDouble(),
      "Reversed": dashboard.claims.reversedCount.toDouble(),
      "Rejected": dashboard.claims.rejectedCount.toDouble(),
    };*/
    return SingleChildScrollView(
      child: Container(
          color: PGBisonAppTheme.pg_White,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: CustomPaint(
                  painter: DashBoard2Painter(),
                  child: ClipPath(
                    clipper: DashBoard2Clipper(), //my CustomClipper
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.46,
                      decoration: BoxDecoration(
                        color: PGBisonAppTheme.pg_White,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),

                          Wrap(
                            direction: Axis.vertical,
                            spacing: -10,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      child: SfRadialGauge(axes: <RadialAxis>[
                                        RadialAxis(
                                            minimum: 0,
                                            maximum: 360,
                                            startAngle: 270,
                                            endAngle: 340,
                                            showTicks: false,
                                            showLabels: false,
                                            axisLineStyle: AxisLineStyle(
                                              color:
                                                  PGBisonAppTheme.pg_yellow_1,
                                              thickness: 0.2,
                                              cornerStyle: CornerStyle.bothFlat,
                                              thicknessUnit:
                                                  GaugeSizeUnit.factor,
                                            ),
                                            annotations: <GaugeAnnotation>[
                                              GaugeAnnotation(
                                                  widget: Container(
                                                      child: Text('20%',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                PGBisonAppTheme
                                                                    .font_Poppins_SemiBold,
                                                            color:
                                                                PGBisonAppTheme
                                                                    .pg_orange_1,
                                                          ))),
                                                  angle: 0,
                                                  positionFactor: 0.00)
                                            ]),
                                        RadialAxis(
                                          radiusFactor: 0.92,
                                          minimum: 0,
                                          maximum: 360,
                                          startAngle: 340,
                                          endAngle: 120,
                                          showTicks: false,
                                          showLabels: false,
                                          axisLineStyle: AxisLineStyle(
                                            color: PGBisonAppTheme
                                                .pg_green_yellow_4,
                                            thickness: 0.15,
                                            cornerStyle: CornerStyle.bothFlat,
                                            thicknessUnit: GaugeSizeUnit.factor,
                                          ),
                                        ),
                                        RadialAxis(
                                          minimum: 0,
                                          maximum: 360,
                                          radiusFactor: 0.9,
                                          startAngle: 120,
                                          endAngle: 270,
                                          showTicks: false,
                                          showLabels: false,
                                          axisLineStyle: AxisLineStyle(
                                            color: PGBisonAppTheme.pg_orange_1,
                                            thickness: 0.10,
                                            cornerStyle: CornerStyle.bothFlat,
                                            thicknessUnit: GaugeSizeUnit.factor,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Wrap(
                                    direction: Axis.vertical,
                                    spacing: -4,
                                    children: [
                                      Text(
                                        '-260,000',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: PGBisonAppTheme
                                              .font_Poppins_SemiBold,
                                          color: PGBisonAppTheme.pg_orange_1,
                                        ),
                                      ),
                                      Text(
                                        'Totals',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: PGBisonAppTheme
                                              .font_Poppins_SemiBold,
                                          color: PGBisonAppTheme.pg_txt1_col,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 3.2,
                                child: syc.SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  title: syc.ChartTitle(
                                      text: true
                                          ? ''
                                          : 'Tourism - Number of arrivals'),
                                  legend: syc.Legend(isVisible: !true),
                                  isTransposed: true,
                                  primaryXAxis: syc.CategoryAxis(
                                    majorGridLines: syc.MajorGridLines(
                                      width: 0,
                                    ),
                                    majorTickLines: syc.MajorTickLines(size: 0),
                                    axisLine: syc.AxisLine(
                                      color: Colors.transparent,
                                    ),
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      fontFamily:
                                          PGBisonAppTheme.font_Poppins_Regular,
                                      color: PGBisonAppTheme.pg_txt2_col,
                                    ),
                                  ),
                                  primaryYAxis: syc.NumericAxis(
                                      majorGridLines:
                                          syc.MajorGridLines(width: 0),
                                      isVisible: false,
                                      numberFormat: NumberFormat.compact()),
                                  series: _getDefaultBarSeries(),
                                  tooltipBehavior:
                                      syc.TooltipBehavior(enable: true),
                                ),
                              ),
                            ],
                          ),
                          //),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: CustomPaint(
                  painter: DashBoard3Painter(),
                  child: ClipPath(
                    clipper: DashBoard3Clipper(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.40,
                      decoration: BoxDecoration(
                        color: PGBisonAppTheme.pg_White,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        //radiusFactor: 0.85,
                                        minimum: 0,
                                        maximum: 360,
                                        startAngle: 280,
                                        endAngle: 30,
                                        showTicks: false,
                                        showLabels: false,
                                        axisLineStyle: AxisLineStyle(
                                          color:
                                              PGBisonAppTheme.pg_green_yellow_4,
                                          //const Color.fromRGBO(36, 58, 97, 1),
                                          thickness: 0.2,
                                          cornerStyle: CornerStyle.bothCurve,
                                          thicknessUnit: GaugeSizeUnit.factor,
                                        ),
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              widget: Container(
                                                  child: Text('60%',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: PGBisonAppTheme
                                                            .font_Poppins_SemiBold,
                                                        color: PGBisonAppTheme
                                                            .pg_green_yellow_4,
                                                      ))),
                                              angle: 0,
                                              positionFactor: 0.00)
                                        ]),
                                    RadialAxis(
                                      //radiusFactor: 0.85,
                                      minimum: 0,
                                      maximum: 360,
                                      startAngle: 40,
                                      endAngle: 270,
                                      showTicks: false,
                                      showLabels: false,
                                      axisLineStyle: AxisLineStyle(
                                        color: const Color.fromRGBO(
                                            191, 214, 252, 1),
                                        //const Color.fromRGBO(36, 58, 97, 1),
                                        thickness: 0.2,
                                        cornerStyle: CornerStyle.bothCurve,
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  spacing: -4,
                                  children: [
                                    Text(
                                      '-60,000',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: PGBisonAppTheme
                                            .font_Poppins_SemiBold,
                                        color:
                                            PGBisonAppTheme.pg_green_yellow_4,
                                      ),
                                    ),
                                    Text(
                                      'Silver',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: PGBisonAppTheme
                                            .font_Poppins_SemiBold,
                                        color: PGBisonAppTheme.pg_txt1_col,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        minimum: 0,
                                        maximum: 360,
                                        startAngle: 280,
                                        endAngle: 340,
                                        showTicks: false,
                                        showLabels: false,
                                        axisLineStyle: AxisLineStyle(
                                          color: PGBisonAppTheme.pg_yellow_1,
                                          thickness: 0.2,
                                          cornerStyle: CornerStyle.bothCurve,
                                          thicknessUnit: GaugeSizeUnit.factor,
                                        ),
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              widget: Container(
                                                  child: Text('40%',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: PGBisonAppTheme
                                                            .font_Poppins_SemiBold,
                                                        color: PGBisonAppTheme
                                                            .pg_yellow_1,
                                                      ))),
                                              angle: 0,
                                              positionFactor: 0.00)
                                        ]),
                                    RadialAxis(
                                      //radiusFactor: 0.85,
                                      minimum: 0,
                                      maximum: 360,
                                      startAngle: 350,
                                      endAngle: 270,
                                      showTicks: false,
                                      showLabels: false,
                                      axisLineStyle: AxisLineStyle(
                                        color: PGBisonAppTheme.pg_light_blue,
                                        thickness: 0.2,
                                        cornerStyle: CornerStyle.bothCurve,
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  spacing: -4,
                                  children: [
                                    Text(
                                      '-160,000',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: PGBisonAppTheme
                                            .font_Poppins_SemiBold,
                                        color: PGBisonAppTheme.pg_yellow_1,
                                      ),
                                    ),
                                    Text(
                                      'Gold',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: PGBisonAppTheme
                                            .font_Poppins_SemiBold,
                                        color: PGBisonAppTheme.pg_txt1_col,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        //radiusFactor: 0.85,
                                        minimum: 0,
                                        maximum: 360,
                                        startAngle: 280,
                                        endAngle: 340,
                                        showTicks: false,
                                        showLabels: false,
                                        axisLineStyle: AxisLineStyle(
                                          color: PGBisonAppTheme.pg_orange_1,
                                          thickness: 0.2,
                                          cornerStyle: CornerStyle.bothCurve,
                                          thicknessUnit: GaugeSizeUnit.factor,
                                        ),
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              widget: Container(
                                                  child: Text('20%',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: PGBisonAppTheme
                                                            .font_Poppins_SemiBold,
                                                        color: PGBisonAppTheme
                                                            .pg_orange_1,
                                                      ))),
                                              angle: 0,
                                              positionFactor: 0.00)
                                        ]),
                                    RadialAxis(
                                      //radiusFactor: 0.85,
                                      minimum: 0,
                                      maximum: 360,
                                      startAngle: 350,
                                      endAngle: 270,
                                      showTicks: false,
                                      showLabels: false,
                                      axisLineStyle: AxisLineStyle(
                                        color: const Color.fromRGBO(
                                            191, 214, 252, 1),
                                        //const Color.fromRGBO(36, 58, 97, 1),
                                        thickness: 0.2,
                                        cornerStyle: CornerStyle.bothCurve,
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  spacing: -4,
                                  children: [
                                    Text(
                                      '-260,000',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: PGBisonAppTheme
                                            .font_Poppins_SemiBold,
                                        color: PGBisonAppTheme.pg_orange_1,
                                      ),
                                    ),
                                    Text(
                                      'Platinum',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: PGBisonAppTheme
                                            .font_Poppins_SemiBold,
                                        color: PGBisonAppTheme.pg_txt1_col,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 68,
              ),
            ],
          )

          /*Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            //leading: Text(""),//Icon(Icons.trending_up),
                            title: Text(
                              "Referrals",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            //subtitle: Text('6',style: TextStyle(color: Colors.black.withOpacity(0.6))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              dashboard.totalReferrals.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            //leading: Text(""),//Icon(Icons.trending_up),
                            title: Text(
                              "Commissions Earned By Quarter",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            //subtitle: Text('6',style: TextStyle(color: Colors.black.withOpacity(0.6))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "Invoices",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        PieChart(
                          dataMap: dataMap,
                          animationDuration: Duration(microseconds: 500),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          colorList: [
                            Colors.green,
                            Colors.yellow,
                            Colors.orange,
                            Colors.red
                          ],
                          initialAngleInDegree: 0,
                          chartType: ChartType.disc,
                          ringStrokeWidth: 32,
                          centerText: "CLAIMS",
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false),
                        )
                      ],
                    ),
                  ))
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            //leading: Text(""),//Icon(Icons.trending_up),
                            title: Text(
                              "Disputed Invoices",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            //subtitle: Text('6',style: TextStyle(color: Colors.black.withOpacity(0.6))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),*/
          ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          )
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color pointColor;

  /// Holds size of the datapoint
  final num size;

  /// Holds datalabel/text value mapper of the datapoint
  final String text;

  /// Holds open value of the datapoint
  final num open;

  /// Holds close value of the datapoint
  final num close;

  /// Holds low value of the datapoint
  final num low;

  /// Holds high value of the datapoint
  final num high;

  /// Holds open value of the datapoint
  final num volume;
}
