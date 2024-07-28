import 'dart:convert';

import 'package:api_test_practice/modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;


class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {


  Future<List<UserModal>> fetchData() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return List<UserModal>.from(parsed.map((data) => UserModal.fromJson(data)));
    } else {
      throw Exception('Failed to load data');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("ApiTesting",style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder<List<UserModal>>(
          future: fetchData(),
          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else if(snapshot.hasError){
            return  ScaffoldMessenger(child: SnackBar(content: Text('Error: ${snapshot.error}')));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    final userData = snapshot.data![index];
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(alignment: Alignment.topCenter,child: Text(userData.id.toString(),style: const TextStyle(fontSize: 16,),)),
                            const SizedBox(height: 8,),
                            Text('Name: ${userData.name}', style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Username: ${userData.username}', style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Email: ${userData.email}',
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('Phone: ${userData.phone}', style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            const Text('Address:',
                                style:
                                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('City: ${userData.address.city}', style: const TextStyle(fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text('Zip Code: ${userData.address.zipcode}', style: const TextStyle(fontSize: 16)),
                                  const SizedBox(height: 4),
                                  const Text('Geolocation:',
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Latitude: ${userData.address.geolocation.latitude}',
                                            style: const TextStyle(fontSize: 14)),
                                        const SizedBox(height: 2),
                                        Text('Longitude: ${userData.address.geolocation.longitude}',
                                            style: const TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
          },
      ),
    );
  }
}


/*

 */