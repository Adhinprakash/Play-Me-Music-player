

import 'package:flutter/material.dart';
import 'package:myapp/playlist/playlist.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class Feedbackscreen extends StatelessWidget {
  Feedbackscreen({super.key});

  final nameController = TextEditingController();
  final subjectcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width:screenwidth,
        height: screenHight,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/page-1/images/android-large-1.png'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 192, 184, 184),
                        size: 25,
                      )),
                 const Text(
                    'Feedback',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  children:[ SizedBox(
                    width: screenwidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Form(
                        key: formKey,
                          child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                              icon:  Icon(Icons.account_circle_outlined,size: 30,color: Colors.blue[300],),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              hintText: "Name",
                              filled: true,
                              fillColor: const Color.fromARGB(255, 130, 205, 237)             
                            ),
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return "Enter Name";
                              }else{
                                return null;
                              }
                            },
                          ),
                         const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                                    controller: subjectcontroller,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.subject_rounded,
                                        color:Colors.blue[300],
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      hintText: 'Subject',
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 130, 205, 237),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Subject";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                            height: 8,
                          ),
                            TextFormField(
                                    controller: emailcontroller,
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.email,
                                        color:Colors.blue[300],
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                      hintText: 'Email',
                                      filled: true,
                                      fillColor: const Color.fromARGB(255, 130, 205, 237),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Email";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 8
                                  ),
                                     TextFormField(
                                      
                                    controller: messageController,
                                    style: const TextStyle( fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.message,
                                        color:Colors.blue[300],
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                      hintText: 'Message',
                                      filled: true,
                                      fillColor:const Color.fromARGB(255, 130, 205, 237),
                                    ),
                                    maxLines: 8,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Message";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                const  SizedBox(
                                  height: 5,
                                ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 250),
                                    child: ElevatedButton(onPressed: (){
                                    if (formKey.currentState!.validate()) {
                                      sendmail();
                                            formKey.currentState!.reset();
                                            var mailSended = SnackBar(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              backgroundColor: Colors.blue[300],
                                              behavior: SnackBarBehavior.floating,
                                              content: Text(
                                                'Mail Send',
                                                style: TextStyle(color: Colors.deepPurple[50]),
                                                textAlign: TextAlign.center,
                                              ),
                                              duration: const Duration(seconds: 1),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(mailSended);
                                          }
                                  
                                    }, child: const Text('Send Email')),
                                  ) 
                        ],
                      )),
                    ),
                  ),
                  ]
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
  
  Future sendmail()async{
    final url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId="service_5ib4myv";
    const templateId="template_9bahysv";
    const userId="OWoBSgM9TBnAng5Rt";
    final response=await http.post(url,
    headers: {'origin':'http://localhost' ,'Content-Type':'application/json'},
    body: json.encode({
      "service_id":serviceId,
      "template_id":templateId,
      "user_Id":userId,
      "template_params":{
        "name":nameController.text,
        "subject":subjectcontroller.text,
        "message":messageController.text,
        "user_email": emailcontroller.text,

      }

    })
    );
    return response.statusCode;

    
  }
}
