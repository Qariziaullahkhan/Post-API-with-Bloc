import 'package:decode_session22_post_api/blocs/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController titleC = TextEditingController();
  TextEditingController bodyC = TextEditingController();

  @override
  void dispose() {
    titleC.dispose();
    bodyC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          'Submit Post',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: bodyC,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(220, 40),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                String title = titleC.text.trim();
                String body = bodyC.text.trim();

                context
                    .read<PostBloc>()
                    .add(SubmitPostEvent(postTitle: title, postBody: body));
              },
              child: const Text('Submit Post'),
            ),
            const Gap(16),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostSubmittingState) {
                  return const CircularProgressIndicator();
                }

                if (state is PostSubmitErrorState) {
                  return Text(state.errorMessage);
                }

                if (state is PostSubmittedState) {
                  return Card(
                    child: Column(
                      children: [
                        Text(state.postModel.title!),
                        Text(state.postModel.body!),
                        Text('ID: ${state.postModel.id!}'),
                        Text('User ID: ${state.postModel.userId!}'),
                      ],
                    ),
                  );
                }

                return const FlutterLogo();
              },
            ),
          ],
        ),
      ),
    );
  }
}
