import 'package:flutter/material.dart';

class TermsandContion extends StatelessWidget {
  const TermsandContion({super.key});

  @override
  Widget build(BuildContext context) {
      final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: screenwidth,
        height: screenHight,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/page-1/images/android-large-1.png'),
                  fit: BoxFit.cover)),
          child: ListView(
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
                  const Padding(
                    padding:  EdgeInsets.only(left: 45),
                    child:  Text(
                      'Terms and Contition',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Flex(
                
                direction: Axis.horizontal,
                children: [Expanded(
                  child: Container(
                    height: screenHight*0.9,
                    width: screenwidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white10
                     ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: const [ 
                          Text(
                            """
 Last updated: 27/Feb/2023
                  
  1.Introduction
                  
             Welcome to Play Me App,\n

  These Terms of Service govern your use of our website located at lala.com (together or individually “Service”) operated by Play Me App.\n
   Our Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages.
                  
   Your agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them.
                   If you do not agree with (or cannot comply with) Agreements, then you may not use the Service, but please let us know by emailing at adhinprakash70@gmail.com so we can try to find a solution. These Terms apply to all visitors, users and others who wish to access or use Service.
                  
   2. Communications
                     By using our Service, you agree to subscribe to newsletters, marketing or promotional materials and other information we may send. However, you may opt out of receiving any, or all, of these communications from us by following the unsubscribe link or by emailing at adhinprakash70@gmail.com
                  
   3. Contests, Sweepstakes and Promotions
                    Any contests, sweepstakes or other promotions (collectively, “Promotions”) made available through Service may be governed by rules that are separate from these Terms of Service. If you participate in any Promotions, please review the applicable rules as well as our Privacy Policy. If the rules for a Promotion conflict with these Terms of Service, Promotion rules will apply.
                  
   4. ContentContent found on or through this Service are the property of Play Me Player App or used with permission. You may not distribute, modify, transmit, reuse, download, repost, copy, or use said Content, whether in whole or in part, for commercial purposes or for personal gain, without express advance written permission from us.
                  
  5. Prohibited Uses
      You may use Service only for lawful purposes and in accordance with Terms. You agree not to use Service:
      0.1. In any way that violates any applicable national or international law or regulation.
      0.2. For the purpose of exploiting, harming, or attempting to exploit or harm minors in any way by exposing them to inappropriate content or otherwise.
      0.3. To transmit, or procure the sending of, any advertising or promotional material, including any “junk mail”, “chain letter,” “spam,” or any other similar solicitation.
      0.4. To impersonate or attempt to impersonate Company, a Company employee, another user, or any other person or entity.
      0.5. In any way that infringes upon the rights of others, or in any way is illegal, threatening, fraudulent, or harmful, or in connection with any unlawful, illegal, fraudulent, or harmful purpose or activity.
      0.6. To engage in any other conduct that restricts or inhibits anyone’s use or enjoyment of Service, or which, as determined by us, may harm or offend Company or users of Service or expose them to liability.
      Additionally, you agree not to:
      0.1. Use Service in any manner that could disable, overburden, damage, or impair Service or interfere with any other party’s use of Service, including their ability to engage in real time activities through Service.
      0.2. Use any robot, spider, or other automatic device, process, or means to access Service for any purpose, including monitoring or copying any of the material on Service.
      0.3. Use any manual process to monitor or copy any of the material on Service or for any other unauthorized purpose without our prior written consent.
      0.4. Use any device, software, or routine that interferes with the proper working of Service.
      0.5. Introduce any viruses, trojan horses, worms, logic bombs, or other material which is malicious or technologically harmful.
      0.6. Attempt to gain unauthorized access to, interfere with, damage, or disrupt any parts of Service, the server on which Service is stored, or any server, computer, or database connected to Service.
      0.7. Attack Service via a denial-of-service attack or a distributed denial-of-service attack.
      0.8. Take any action that may damage or falsify Company rating.
      0.9. Otherwise attempt to interfere with the proper working of Service.            
                                
                  6. Analytics
                    We may use third-party Service Providers to monitor and analyze the use of our Service.
                  
                  7. No Use By Minors
                    Service is intended only for access and use by individuals at least eighteen (18) years old. By accessing or using Service, you warrant and represent that you are at least eighteen (18) years of age and with the full authority, right, and capacity to enter into this agreement and abide by all of the terms and conditions of Terms. If you are not at least eighteen (18) years old, you are prohibited from both the access and usage of Service.
                  
                  8. Intellectual Property
                    Service and its original content (excluding Content provided by users), features and functionality are and will remain the exclusive property of simfonie App and its licensors. Service is protected by copyright, trademark, and other laws of  and foreign countries. Our trademarks may not be used in connection with any product or service without the prior written consent of lie App.
                  
                  9. Copyright Policy
                    We respect the intellectual property rights of others. It is our policy to respond to any claim that Content posted on Service infringes on the copyright or other intellectual property rights (“Infringement”) of any person or entity.
                  If you are a copyright owner, or authorized on behalf of one, and you believe that the copyrighted work has been copied in a way that constitutes copyright infringement, please submit your claim via email to adhinprakash70@gmail.com, with the subject line: “Copyright Infringement” and include in your claim a detailed description of the alleged Infringement as detailed below, under “DMCA Notice and Procedure for Copyright Infringement Claims”
                  You may be held accountable for damages (including costs and attorneys’ fees) for misrepresentation or bad-faith claims on the infringement of any Content found on and/or through Service on your copyright.
                   
                  10. Error Reporting and Feedback
                     You may provide us either directly at adhinprakash70@gmail.com or via third party sites and tools with information and feedback concerning errors, suggestions for improvements, ideas, problems, complaints, and other matters related to our Service (“Feedback”). You acknowledge and agree that: (i) you shall not retain, acquire or assert any intellectual property right or other right, title or interest in or to the Feedback; (ii) Company may have development ideas similar to the Feedback; (iii) Feedback does not contain confidential information or proprietary information from you or any third party; and (iv) Company is not under any obligation of confidentiality with respect to the Feedback. In the event the transfer of the ownership to the Feedback is not possible due to applicable mandatory laws, you grant Company and its affiliates an exclusive, transferable, irrevocable, free-of-charge, sub-licensable, unlimited and perpetual right to use (including copy, modify, create derivative works, publish, distribute and commercialize) Feedback in any manner and for any purpose.
                              
                  13. Changes To Service
                     We reserve the right to withdraw or amend our Service, and any service or material we provide via Service, in our sole discretion without notice. We will not be liable if for any reason all or any part of Service is unavailable at any time or for any period. From time to time, we may restrict access to some parts of Service, or the entire Service, to users, including registered users.
                  
                  14. Amendments To Terms
                     We may amend Terms at any time by posting the amended terms on this site. It is your responsibility to review these Terms periodically.
                  Your continued use of the Platform following the posting of revised Terms means that you accept and agree to the changes. You are expected to check this page frequently so you are aware of any changes, as they are binding on you.
                  By continuing to access or use our Service after any revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, you are no longer authorized to use Service.
                  
                  15. Waiver And Severability
                     No waiver by Company of any term or condition set forth in Terms shall be deemed a further or continuing waiver of such term or condition or a waiver of any other term or condition, and any failure of Company to assert a right or provision under Terms shall not constitute a waiver of such right or provision.
                  If any provision of Terms is held by a court or other tribunal of competent jurisdiction to be invalid, illegal or unenforceable for any reason, such provision shall be eliminated or limited to the minimum extent such that the remaining provisions of Terms will continue in full force and effect.
                  
                  16. Acknowledgement
                     BY USING SERVICE OR OTHER SERVICES PROVIDED BY US, YOU ACKNOWLEDGE THAT YOU HAVE READ THESE TERMS OF SERVICE AND AGREE TO BE BOUND BY THEM.
                  
                  17. Contact Us
                      Please send your feedback, comments, requests for technical support by email: adhinprakash70@gmail.com
                  """,
                            style: TextStyle(
                                color: Color.fromARGB(255, 221, 214, 214),
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ]
              )
            ],
          ),
        ),
      )),
    );
  }
}
