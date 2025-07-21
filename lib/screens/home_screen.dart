import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pydaily/models/challenge.dart';
import 'package:pydaily/models/user.dart';
import 'package:pydaily/screens/challenge_screen.dart';
import 'package:pydaily/screens/progress_screen.dart';
import 'package:pydaily/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final User initialUser;

  //Preguntas. SE CAMBIARON A LAS DE FIRESTORE
  /*
  static const List<Challenge> challenges = [
    Challenge(
      id: '1',
      title: 'Hola Mundo',
      question: '¿Cómo se imprime en Python?',
      options: ['print()', 'echo()', 'console.log()'],
      correctAnswerIndex: 0,
      xp: 10,
      explanation: 'Python usa print() para mostrar en consola',
    ),
    Challenge(
      id: '2',
      title: 'Variables',
      question: '¿Cómo se declara una variable?',
      options: ['var x', 'int x', 'x = 5'],
      correctAnswerIndex: 2,
      xp: 10,
      explanation: 'Python no requiere declarar el tipo',
    ),
    Challenge(
      id: '3',
      title: 'Condicionales',
      question: '¿Cuál es la forma correcta de un "if"?',
      options: ['if x > 5:', 'if (x > 5)', 'if x > 5 then'],
      correctAnswerIndex: 0,
      xp: 10,
      explanation: 'En Python se usan dos puntos ":" al final del if',
    ),
    Challenge(
      id: '4',
      title: 'Bucles',
      question: '¿Cuál es un bucle válido en Python?',
      options: ['while x < 5:', 'loop while x < 5', 'repeat until x > 5'],
      correctAnswerIndex: 0,
      xp: 10,
      explanation: 'Python usa while seguido de dos puntos',
    ),
    Challenge(
      id: '5',
      title: 'Listas',
      question: '¿Cómo se crea una lista?',
      options: ['list = (1, 2, 3)', 'list = [1, 2, 3]', 'list = {1, 2, 3}'],
      correctAnswerIndex: 1,
      xp: 10,
      explanation: 'Las listas en Python se definen con corchetes []',
    ),
    Challenge(
      id: '6',
      title: 'Funciones',
      question: '¿Cómo se define una función?',
      options: ['function miFuncion()', 'def miFuncion():', 'func miFuncion()'],
      correctAnswerIndex: 1,
      xp: 10,
      explanation: 'En Python se usa "def" para definir funciones',
    ),
    Challenge(
      id: '7',
      title: 'Cadenas',
      question: '¿Cómo se concatenan cadenas?',
      options: [
        '"Hola" + " Mundo"',
        '"Hola".append(" Mundo")',
        '"Hola".join(" Mundo")'
      ],
      correctAnswerIndex: 0,
      xp: 10,
      explanation: 'La concatenación se hace con + entre cadenas',
    ),
    Challenge(
      id: '8',
      title: 'Comentarios',
      question: '¿Cómo se hace un comentario de una línea?',
      options: ['// Comentario', '# Comentario', '-- Comentario'],
      correctAnswerIndex: 1,
      xp: 10,
      explanation: 'Los comentarios en Python usan "#"',
    ),
    Challenge(
      id: '9',
      title: 'Tipos de datos',
      question: '¿Cuál es un tipo de dato válido en Python?',
      options: ['string', 'text', 'str'],
      correctAnswerIndex: 2,
      xp: 10,
      explanation: 'El tipo correcto para cadenas es "str"',
    ),
    Challenge(
      id: '10',
      title: 'Diccionarios',
      question: '¿Cómo se accede a un valor de un diccionario?',
      options: ['dic.key', 'dic["key"]', 'dic->key'],
      correctAnswerIndex: 1,
      xp: 10,
      explanation: 'Se accede con dic["clave"]',
    ),
    Challenge(
      id: '11',
      title: 'Longitud',
      question: '¿Cómo se obtiene la longitud de una lista?',
      options: ['list.length()', 'length(list)', 'len(list)'],
      correctAnswerIndex: 2,
      xp: 10,
      explanation: 'La función len() devuelve la longitud de listas',
    ),
    Challenge(
      id: '12',
      title: 'Importaciones',
      question: '¿Cómo se importa un módulo?',
      options: ['use math', 'import math', 'include math'],
      correctAnswerIndex: 1,
      xp: 10,
      explanation: 'Se usa "import" para incluir módulos',
    ),
    Challenge(
      id: '13',
      title: 'Módulo Math',
      question: '¿Cómo se obtiene la raíz cuadrada?',
      options: ['math.sqrt(16)', 'sqrt(16)', 'math.root(16)'],
      correctAnswerIndex: 0,
      xp: 10,
      explanation: 'math.sqrt() devuelve la raíz cuadrada',
    ),
    Challenge(
      id: '14',
      title: 'Excepciones',
      question: '¿Cómo se maneja una excepción?',
      options: ['try/catch', 'try: except:', 'try then except'],
      correctAnswerIndex: 1,
      xp: 10,
      explanation: 'Python usa "try" y "except" para manejar errores',
    ),
    Challenge(
      id: '15',
      title: 'Comparación',
      question: '¿Qué operador se usa para igualdad?',
      options: ['=', '==', '==='],
      correctAnswerIndex: 1,
      xp: 10,
      explanation: 'El operador "==" se usa para comparar valores',
    ),
  ];*/

  const HomeScreen({
    super.key,
    required this.initialUser,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User currentUser;

  List<Challenge> preguntasFirestore = [];
  bool cargandoPreguntas = true;

  // //Subir todas las preguntas a Firestore
  // Future<void> subirPreguntasAFirestore() async {
  //   for (final challenge in HomeScreen.challenges) {
  //     await FirebaseFirestore.instance.collection('preguntas').doc(challenge.id).set({
  //       'id': challenge.id,
  //       'title': challenge.title,
  //       'question': challenge.question,
  //       'options': challenge.options,
  //       'correctAnswerIndex': challenge.correctAnswerIndex,
  //       'xp': challenge.xp,
  //       'explanation': challenge.explanation,
  //     });
  //   }
  // }

  // Leer preguntas desde Firestore y convertirlas a Challenge
  Future<List<Challenge>> leerPreguntasDeFirestore() async {
    final snapshot = await FirebaseFirestore.instance.collection('preguntas').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Challenge(
        id: data['id'] ?? doc.id,
        title: data['title'] ?? '',
        question: data['question'] ?? '',
        options: List<String>.from(data['options'] ?? []),
        correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
        xp: data['xp'] ?? 0,
        explanation: data['explanation'] ?? '',
      );
    }).toList();
  }


  @override
  void initState() {
    super.initState();
    currentUser = widget.initialUser;
    cargarPreguntas();
    //subirPreguntasAFirestore();//--------------------------------------DESCOMENTAR SOLO LA PRIMERA VEZ
  }

  Future<void> cargarPreguntas() async {
    final preguntas = await leerPreguntasDeFirestore();
    print('Preguntas cargadas: ${preguntas.length}');
    setState(() {
      preguntasFirestore = preguntas;
      cargandoPreguntas = false;
    });
  }

  void _completeChallenge(Challenge challenge) {
    setState(() {
      final now = DateTime.now();
      int newStreak = currentUser.streak;
      
      // Lógica simplificada para la racha
      if (currentUser.streak == 0) {
        // Si es la primera vez que juega, comenzar con racha 1
        newStreak = 1;
      } else if (!currentUser.playedToday && currentUser.playedYesterday) {
        // Si jugó ayer pero no hoy, incrementar la racha
        newStreak += 1;
      }
      // Si ya jugó hoy, mantener la racha actual

      // Calcular XP total incluyendo el bonus por racha
      final streakBonus = currentUser.streakBonus;
      final newXp = currentUser.xp + challenge.xp + streakBonus;

      currentUser = currentUser.copyWith(
        xp: newXp,
        completedChallenges: [...currentUser.completedChallenges, challenge.id],
        streak: newStreak,
        lastPlayedDate: now,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retos PyDaily - Nivel ${currentUser.calculatedLevel}'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          // Mostrar la racha actual
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange),
                const SizedBox(width: 4),
                Text(
                  '${currentUser.streak} días',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgressScreen(user: currentUser),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Mostrar bonus por racha si existe
          if (currentUser.streak > 0)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.orange.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    'Bonus por racha: +${currentUser.streakBonus} XP',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          // Barra de progreso animada
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 800),
            tween: Tween<double>(begin: 0, end: currentUser.progress),
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.blue[100],
              color: Colors.blue[800],
              minHeight: 8,
            ),
          ),
          // Texto de progreso
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '${currentUser.xp % 100}/100 XP - Nivel ${currentUser.calculatedLevel}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          // Lista de retos
          Expanded(
            child: cargandoPreguntas
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: preguntasFirestore.length,
                    itemBuilder: (context, index) {
                      final challenge = preguntasFirestore[index];
                      final isCompleted = currentUser.completedChallenges.contains(challenge.id);

                      return Card(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        elevation: 2,
                        color: isCompleted ? Colors.green[50] : null,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isCompleted
                                ? Colors.green.withOpacity(0.2)
                                : Colors.blue.withOpacity(0.2),
                            child: isCompleted
                                ? const Icon(Icons.check, size: 16, color: Colors.green)
                                : Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isCompleted ? Colors.green : Colors.blueAccent,
                                    ),
                                  ),
                            radius: 15,
                          ),
                          title: Text(
                            challenge.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isCompleted ? Colors.green[800] : Colors.black,
                            ),
                          ),
                          subtitle: Text(challenge.question),
                          trailing: Icon(
                            isCompleted ? Icons.check_circle : Icons.arrow_forward,
                            color: isCompleted ? Colors.green : Colors.blueAccent,
                          ),
                          onTap: isCompleted
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(challenge.title),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pregunta: ${challenge.question}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Respuesta correcta: ${challenge.options[challenge.correctAnswerIndex]}',
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'Explicación:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(challenge.explanation),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Cerrar'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              : () async {
                                  final isCorrect = await Navigator.push<bool>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChallengeScreen(
                                        challenge: challenge,
                                      ),
                                    ),
                                  );

                                  if (isCorrect == true) {
                                    _completeChallenge(challenge);
                                  }
                                },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
