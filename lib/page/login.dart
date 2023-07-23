import 'package:app_nongye/controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              validator: (value) =>
                                  value!.isEmpty ? '用户名不能为空' : null,
                              decoration: const InputDecoration(
                                labelText: "用户名",
                                hintText: "请输入用户名",
                              ),
                              onChanged: (value) =>
                                  controller.username.value = value,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              validator: (value) =>
                                  value!.isEmpty ? '密码不能为空' : null,
                              decoration: const InputDecoration(
                                labelText: "密码",
                                hintText: "请输入密码",
                              ),
                              onChanged: (value) =>
                                  controller.password.value = value,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.login();
                                }
                              },
                              child: const Text("登录"),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
