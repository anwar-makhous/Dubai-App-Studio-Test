class HistoryItem {
  final String name;
  final String number;
  final int amount;

  HistoryItem({required this.name, required this.number, required this.amount});
}

List<HistoryItem> dummyHistoryItems = [
  HistoryItem(name: "Kumar Suresh", number: "+915255219205", amount: 10),
  HistoryItem(name: "Amit Pahandit", number: "+915255219205", amount: 30),
  HistoryItem(name: "Daniel Smith", number: "+915255219205", amount: 75),
  HistoryItem(name: "Amit Pahandit", number: "+915255219205", amount: 100),
  HistoryItem(name: "Kumar Suresh", number: "+915255219205", amount: 5),
  HistoryItem(name: "Amit Pandey ", number: "+915255219205", amount: 20),
  HistoryItem(name: "Amit Pandey ", number: "+915255219205", amount: 20),
  HistoryItem(name: "Amit Pahandit", number: "+915255219205", amount: 75),
  HistoryItem(name: "Daniel Smith", number: "+915255219205", amount: 50),
  HistoryItem(name: "Kumar Suresh", number: "+915255219205", amount: 100),
];
