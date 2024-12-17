import 'package:flutter/material.dart';
import 'package:restaubook/pages/Login.dart';
import 'package:restaubook/pages/Signup.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  String _activeButton = "Login"; // Bouton actif par défaut (Login)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/logoBon.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const Spacer(), // Pousse les widgets vers le bas
            // Bouton Login
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _activeButton = "Login";
                  });
                  // Naviguer vers la page Login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: _activeButton == "Login"
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            // Bouton Register
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _activeButton = "Register";
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: _activeButton == "Register"
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Continue  as Anonyme",
                style: TextStyle(),
              ),
            ),
            const SizedBox(height: 20),

            // Petit espace en bas
          ],
        ),
      ),
    );
  }
}
