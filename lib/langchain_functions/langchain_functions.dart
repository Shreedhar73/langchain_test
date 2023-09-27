import 'dart:io';

import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';

class Methods {
  static const openaiApiKey =
      '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';
  final openai = OpenAI(apiKey: openaiApiKey, temperature: 0.9);

  Future<String> chat(String prmpt) async {
    final promptTemplate = ChatPromptTemplate.fromTemplate(
      ''' Write a summary for following $prmpt''',
    );
    final response = await openai(prmpt);
    return response;
  }

  Future<List<Document>> load(String filePath) async {
    final textLoader = WebBaseLoader(['https://younginnovations.com.np/']);
    final response = await textLoader.load();

    return response;
  }

  Future<String> generateSummary(final List<Document> docs,
      {String prompt = ''}) async {
    const textSplitter = RecursiveCharacterTextSplitter(chunkSize: 5000);
    final List<Document> docsChunks = textSplitter.splitDocuments(docs);

    final questionAnswerChain = StuffDocumentsQAChain(
      llm: openai,
      prompt: PromptTemplate.fromTemplate(''' $prompt ? 
          Write a maximum of 2 lines.
          
           "{context}" '''),
    );

//     final summarizeChain = SummarizeChain.mapReduce(
//       llm: openai,
//       mapPrompt: PromptTemplate.fromTemplate('''
// Write a concise summary of the following text.
// Avoid unnecessary info. Write at 5th-grade level.

// "{context}"

// CONCISE SUMMARY:'''),
//       combinePrompt: PromptTemplate.fromTemplate('''
// Summarize the following text in bullet points using markdown.
// Write a maximum of 5 bullet points.

// "{context}"

// BULLET POINT SUMMARY:'''),
//     );
    // return summarizeChain.run(docsChunks);
    return questionAnswerChain.run([docsChunks.first]);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
