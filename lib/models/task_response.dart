class TaskResponse {
  int? iD;
  List<TaskList>? taskList;

  TaskResponse({this.iD, this.taskList});

  TaskResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    if (json['task_list'] != null) {
      taskList = <TaskList>[];
      json['task_list'].forEach((v) {
        taskList!.add(new TaskList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    if (this.taskList != null) {
      data['task_list'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskList {
  String? id;
  String? taskDescription;
  String? taskUrl;
  String? isDailyTask;
  String? rewardCoin;

  TaskList(
      {this.id,
      this.taskDescription,
      this.taskUrl,
      this.isDailyTask,
      this.rewardCoin});

  TaskList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskDescription = json['task_description'];
    taskUrl = json['task_url'];
    isDailyTask = json['is_daily_task'];
    rewardCoin = json['reward_coin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task_description'] = this.taskDescription;
    data['task_url'] = this.taskUrl;
    data['is_daily_task'] = this.isDailyTask;
    data['reward_coin'] = this.rewardCoin;
    return data;
  }
}
