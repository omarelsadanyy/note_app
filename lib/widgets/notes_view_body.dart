import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/widgets/custom_app_bar.dart';
import 'package:note_app/widgets/notes_list_view.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({super.key});

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {

  late CrossFadeState crossFadeState;
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
    super.initState();
    crossFadeState = CrossFadeState.showFirst; 
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: 50),
          AnimatedCrossFade(
            crossFadeState:crossFadeState,
            duration: Duration(milliseconds:300),
            firstCurve: Curves.easeInOut,
            secondCurve: Curves.easeInOut,
            firstChild: CustomAppBar(
              text: 'Notes',
              icon: Icons.search,
              onPressed: () {
                setState(() {
                   crossFadeState= CrossFadeState.showSecond;
                });
              },
            ),
            secondChild: SearchBar(
              
              trailing: [
                IconButton(onPressed: (){
                     setState(() {
                   crossFadeState= CrossFadeState.showFirst;
                   NotesCubit.get(context).searchController.clear();
                   NotesCubit.get(context).searchedNotes=[];
                });
                }, icon: Icon(Icons.close)),
              ],
              controller: NotesCubit.get(context).searchController,
              onChanged: (value) {
                NotesCubit.get(context).searchController.text=value;
                NotesCubit.get(context).searchNotes();
              },
            ),
            
          ),
          Expanded(child: NotesListView())
        ],
      ),
    );
  }
}
