import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_revision/controllers/apple_controller.dart';
class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AppleController>(
      builder: (_controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Apple Articles'),
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

                    Get.toNamed('anotherpage');
                  }, child: Text('->'))

                ],
              )
            ],
          ),
        );
      }
    );
  }
}
