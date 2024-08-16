import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_revision/bindings/apple_binding.dart';
import 'package:getx_revision/controllers/api_controller.dart';
import 'package:getx_revision/presentation/next_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.put(NewsApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitcoin Articles'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return _controller.data.isEmpty &&
                  _controller.errorMessage.value.isNotEmpty
                  ? Center(child: Text(_controller.errorMessage.value))
                  : ListView.builder(
                itemCount: _controller.data.length,
                itemBuilder: (context, index) {
                  final article = _controller.data[index];
                  return  ListTile(
                          title: Text(article.title ?? 'Empty Title'),
                          subtitle:
                              Text(article.description ?? 'Empty Description'));
                },
              );
            }),
          ),
          // Spacer(),
        
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _controller.callApi();
                  },
                  child: Obx(() => _controller.isFetching.value
                      ? CircularProgressIndicator()
                      : Text("Call News API"))),
              TextButton(onPressed: (){

                Get.to(()=>NextPage(),binding: AppleControllerBinding());
              }, child: Text('->'))
            ],
          )
        ],
      ),
    );
  }
}
