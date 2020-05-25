class Message {
  num _timestamp;
  String _from;
  String _content;

  Message(this._timestamp, this._from, this._content);

  num getTimeStamp() => _timestamp;

  String getFrom() => _from;

  String getContent() => _content;
}