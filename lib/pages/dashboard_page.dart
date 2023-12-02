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

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    max = await repository.getOlderUser();
    avg = await repository.getAvgAgeUser();
    min = await repository.getNewestUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).padding.top, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                colorList: const [Colors.redAccent, Colors.greenAccent],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      children: [
                        Text("Maior idade"),
                        Text("$max"),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      children: [
                        Text("media de idades"),
                        Text("${avg}"),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      children: [
                        Text("Menor idade"),
                        Text("$min"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Center(
              child: Card(
                margin: EdgeInsets.all(16),
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.person),
                        Text("Marcelo"),
                        Text("4")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Ver todos os usuários"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const UsersPage())),
            ),
            ListTile(
              leading: Icon(Icons.task),
              title: Text("Ver todos as tarefas"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
