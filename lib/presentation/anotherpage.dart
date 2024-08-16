import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_revision/controllers/tech_crunch_controller.dart';
import 'package:getx_revision/presentation/home.dart';

class AnotherPage extends StatefulWidget {
  const AnotherPage({super.key});

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TechCrunchController>(
        builder: (_controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tech crunch Articles'),
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
                        return ListTile(
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
                        child: Obx(() =>
                        _controller.isFetching.value
                            ? CircularProgressIndicator()
                            : Text("Call tech API"))),


                    TextButton(onPressed: () {
                      Get.offAll(() => HomePage(),);
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
