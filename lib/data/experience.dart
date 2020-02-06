
class Experience {
  String job;
  String company;
  DateTime from;
  DateTime to;
  String description;

  Experience({this.job, this.company, this.from, this.to, this.description});

  Experience.fromMap(Map<String, dynamic> exp)
      : job = exp["job"],
        company = exp["company"],
        from = DateTime.parse(exp["from"]),
        to = DateTime.parse(exp["from"]),
        description = exp["description"];

  Map<String, dynamic> toJson() => {
    'job': job,
    'company': company,
    'from': from.toString(),
    'to': to.toString(),
    'description': description,
  };
}