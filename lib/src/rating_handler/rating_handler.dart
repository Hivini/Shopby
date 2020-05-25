import 'dart:async';

import 'package:angular/angular.dart';

@Component(
    selector: 'rating-handler',
    templateUrl: 'rating_handler.html',
    styleUrls: [
      'rating_handler.css'
    ],
  directives: [
    coreDirectives,
  ],
)
class RatingHandler implements OnInit {
  static const String _STAR_ON_CHAR = '\u2605';
  static const String _STAR_OFF_CHAR = '\u2606';
  static const String _STAR_ON_CLASS = 'star-on';
  static const String _STAR_OFF_CLASS = 'star-off';

  static final int DEFAULT_MAX = 5;
  final _finished = StreamController<int>();

  @Input()
  String productId;

  @Output()
  Stream<int> get finished => _finished.stream;

  List<int> stars = [];

  @override
  void ngOnInit() {
    var count = DEFAULT_MAX;
    stars = List.generate(count, (i) => i + 1);
  }

  int rating = 5;

  String starClass(int star) => star > rating ? _STAR_OFF_CLASS : _STAR_ON_CLASS;

  String starChar(int star) => star > rating ? _STAR_OFF_CHAR : _STAR_ON_CHAR;

  void handleClick(int star) {
    rating = (star == 1 && rating == 1) ? 0 : star;
  }

  void addToRatings() {
    print(productId);
    print(rating);
    _finished.add(rating);
  }
}