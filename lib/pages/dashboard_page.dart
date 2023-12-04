import 'package:app_users/pages/tasks_page.dart';
import 'package:app_users/pages/users_page.dart';
import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  SqliteRepository repository = SqliteRepositoryImpl();

  String max = "";
  String avg = "";
  String min = "";
  Map<String, double> data = <String, double>{
    'Incompletas': 0.6,
    'Completas': 0.4
  };
  List<Map<String, int>> lengthUserTasksList = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    max = await repository.getOlderUser();
    avg = await repository.getAvgAgeUser();
    min = await repository.getNewestUser();
    lengthUserTasksList = await repository.getLengthUserTasks();
    data = await repository.getCountTasksCompletedAndIncompleted();
    repository.getUsersWithTask();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).padding.top, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tarefas",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: PieChart(
                dataMap: data,
                animationDuration: const Duration(milliseconds: 800),
                //chartType: ChartType.ring,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                ),
                colorList: const [Colors.greenAccent, Colors.redAccent],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      children: [
                        const Text("Maior idade"),
                        Text(max == "null"? "0" : max),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      children: [
                        const Text("media de idades"),
                        Text(avg == "null"? "0" : avg),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      children: [
                        const Text("Menor idade"),
                        Text(min == "null"? "0" : min),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            /*Center(
              child: Card(
                margin: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.person),
                        Text(
                            "${lengthUserTasksList.isEmpty ? 0 : lengthUserTasksList[0].keys.single}"),
                        Text(
                            "${lengthUserTasksList.isEmpty ? 0 : lengthUserTasksList[0].values.single}")
                      ],
                    ),
                  ),
                ),
              ),
            ),*/
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Ver todos os usuários"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const UsersPage())),
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text("Ver todos as tarefas"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const TasksPage())),
            ),
          ],
        ),
      ),
    );
  }
}
