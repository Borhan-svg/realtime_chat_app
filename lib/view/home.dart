import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';
import 'signup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String message = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 50),
          child: Column(
            children: [
              Center(
                child: Image.asset('assets/image/smile.png' , color: Colors.indigo,),
              ),
              const SizedBox(height: 10,),
              const Center(
                child: Text('Welcome !' , style: TextStyle(color: Colors.indigo , fontWeight: FontWeight.w900 , fontSize: 30),),
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  'Start your very first legendary conversations with your lovers. ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(Login());
                      },
                      child: const Text('Log in', style: TextStyle(color: Colors.indigo),),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(const Signup());
                      },
                      child: const Text('Sign up' , style: TextStyle(color: Colors.indigo),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
