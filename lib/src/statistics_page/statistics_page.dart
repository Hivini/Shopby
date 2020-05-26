import 'dart:html';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:chartjs/chartjs.dart';
import 'package:Shopby/src/database_handler/database_handler_service.dart';

@Component(
  selector: 'statistics-page',
  templateUrl: 'statistics_page.html',
  styleUrls: [
    '../../app_component.css',
    'package:angular_components/app_layout/layout.scss.css',
  ],
)
class StatisticsPage implements AfterViewInit {
  final DatabaseHandlerService _dbService;

  final rnd = Random();

  final labels = <String>[
    'Products',
    'Users',
    'Chats',
  ];

  @ViewChild('barChart')
  HtmlElement canvas;

  StatisticsPage(this._dbService);

  @override
  void ngAfterViewInit() async {
    var stats = await _dbService.getStatistics();
    var data = LinearChartData(
      labels: labels,
      datasets: <ChartDataSets>[
        ChartDataSets(
          label: 'Total Count',
          backgroundColor: 'rgba(220,150,247,0.8)',
          data: stats,
        ),
      ],
    );

    var config = ChartConfiguration(
      type: 'bar',
      data: data,
      options: ChartOptions(responsive: true),
    );
    var _ = Chart(canvas, config);
  }
}
