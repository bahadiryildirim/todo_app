import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app/view/widgets/task_widget.dart';
import '../../model/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<TaskModel> _allTasks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allTasks = <TaskModel>[];
    _allTasks.add(TaskModel.create(
        taskDetail: "Deneme Görev bu", createdAt: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _showAddTaskBottomSheet(context);
          },
          child: const Text(
            "Bugün neler yapacaksın?",
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle:
            false, //IOS de başlıklar otomatik olarak ortalanır. Burada bu özelliği kapattık.
        actions: [
          //buradaki yerleştirilenler soldan sağa doğru yerleştirilir.
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _showAddTaskBottomSheet(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return dismissableTaskView(index);
              },
              itemCount: _allTasks.length,
            )
          : const Center(
              child: Text(
                  "Gösterilecek herhangi bir görev bulunmamaktadır.\nBir görev ekleyerek başlayabilirsin !"),
            ),
    );
  }

  Dismissible dismissableTaskView(int index) {
    return Dismissible(
      background: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.red,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 11,
              ),
              const Text(
                "Bu görev silinmek üzere...",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      key: Key(_allTasks[index].id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          setState(() {
            _allTasks.removeAt(index);
          });
        }
      },
      child: TaskWidget(task: _allTasks[index]),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom), //klavye açıldığında onun hemen üst kısmını temsil eder.,
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              onSubmitted: (value) {
                Navigator.of(context).pop();
                if (value.length > 3) {
                  print("3den Buyuk: " + value);
                  DatePicker.showTimePicker(
                    context,
                    showSecondsColumn: false,
                    onConfirm: (time) {
                      var newAddedTask =
                          TaskModel.create(taskDetail: value, createdAt: time);
                      setState(() {
                        _allTasks.add(newAddedTask);
                      });
                    },
                  );
                  print("3den kucuk" + value);
                } else {}
              },
              style: const TextStyle(fontSize: 22),
              decoration: const InputDecoration(
                  hintText: "Görev Nedir?", border: InputBorder.none),
            ),
          ),
        );
      },
    );
  }
}
