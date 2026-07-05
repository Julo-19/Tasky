class Task {
  final int? id;
  final String title;
  final String content;
  final String priority;
  final String color;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Task({
    this.id,
    required this.title,
    required this.content,
    required this.priority,
    required this.color,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      priority: json['priority'],
      color: json['color'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'priority': priority,
      'color': color,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}