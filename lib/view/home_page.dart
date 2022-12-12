import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../model/task_model.dart';

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
                return Dismissible(
                  key: Key(_allTasks[index].id),
                  child: ListTile(
                    title: Text(_allTasks[index].taskDetail),
                    subtitle: Text(_allTasks[index].createdAt.toString()),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _allTasks.removeAt(index);
                    });
                  },
                );
              },
              itemCount: _allTasks.length,
            )
          : const Center(
              child: Text(
                  "Gösterilecek herhangi bir görev bulunmamaktadır.\nBir görev ekleyerek başlayabilirsin !"),
            ),
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
                }

                print("3den kucuk" + value);
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
