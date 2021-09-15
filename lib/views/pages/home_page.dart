import 'package:bag_of_words/bloc/auth/auth_bloc.dart';
import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:bag_of_words/bloc/home/addword/add_word_bloc.dart';
import 'package:bag_of_words/bloc/home/addword/add_word_event.dart';
import 'package:bag_of_words/bloc/home/addword/add_work_state.dart';
import 'package:bag_of_words/bloc/home/day_revision_summary_bloc.dart';
import 'package:bag_of_words/bloc/home/day_revision_summary_event.dart';
import 'package:bag_of_words/bloc/home/day_revision_summary_state.dart';
import 'package:bag_of_words/bloc/home/learned_defs_bloc.dart';
import 'package:bag_of_words/bloc/home/learned_defs_event.dart';
import 'package:bag_of_words/bloc/home/learned_defs_state.dart';
import 'package:bag_of_words/data/providers/day_revision_cloud_provider.dart';
import 'package:bag_of_words/data/providers/defs_cloud_provider.dart';
import 'package:bag_of_words/data/repos/auth/auth_repo.dart';
import 'package:bag_of_words/data/repos/day_revision_repo.dart';
import 'package:bag_of_words/data/repos/defs_repo.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/views/pages/login_page.dart';
import 'package:bag_of_words/views/refhost/learned_defs_ref_host.dart';
import 'package:bag_of_words/views/reps/day_revision_stat_rep.dart';
import 'package:bag_of_words/views/widgets/text_entry_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(builder: (_) => HomePage());

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthRepo>().getAuthenticatedUser();

    final DayRevisionRepo dayRevRepo = DayRevisionRepo(
      user: user,
      cloudProvider: DayRevisionCloudProvider(),
    );

    final LearnedDefsBloc defsBloc = LearnedDefsBloc(
      DefsRepo(
        user: user,
        cloudProvider: DefsCloudProvider(),
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<DayRevisionSummaryBloc>(
          create: (_) => DayRevisionSummaryBloc(dayRevRepo),
        ),
        BlocProvider<LearnedDefsBloc>(
          create: (_) => defsBloc,
        ),
        BlocProvider<AddWordBloc>(
          create: (_) => AddWordBloc(dayRevRepo, defsBloc),
        ),
      ],
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DayRevisionSummaryBloc>().add(DayRevisionSummaryFetchEvent());
    context.read<LearnedDefsBloc>().add(LearnedDefsFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Widget actionBarLoadingWidget =
        BlocConsumer<AddWordBloc, AddWordState>(
      builder: (context, state) {
        if (state.status == AddWordStatus.ADDING) {
          return Center(
            child: Container(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(strokeWidth: 2.0),
            ),
          );
        }
        return Container();
      },
      listener: (context, state) {
        if (state.status == AddWordStatus.SUCCESS) {
          context
              .read<DayRevisionSummaryBloc>()
              .add(DayRevisionSummaryFetchEvent());
        }
      },
    );

    return Scaffold(
      backgroundColor: AppColor.darkBg,
      appBar: AppBar(
        title: Text(AppString.appName),
        elevation: 0,
        actions: [
          actionBarLoadingWidget,
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {
              // TODO: Implement logout option with bottom sheet
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status != AuthStatus.AUTHENTICATED) {
            Navigator.pushAndRemoveUntil(
              context,
              LoginPage.route(),
              (route) => false,
            );
          }
        },
        child: HomeScreenBody(),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  void _onAddNewWord(BuildContext context, String word) {
    if (word.trim().isEmpty) {
      // TODO: Empty word addition not allowed
      return;
    }

    if (word.split(' ').length > 1) {
      // TODO: Multiple word search not allowed
      return;
    }

    context.read<AddWordBloc>().add(AddWordAddEvent(word: word));
  }

  @override
  Widget build(BuildContext context) {
    final Widget dayRevWidget =
        BlocBuilder<DayRevisionSummaryBloc, DayRevisionSummaryState>(
      builder: (context, state) {
        return DayRevisionStatRep(
          todaysDayStat: state.todaysDayStat,
          yestDayStat: state.yestDayStat,
        );
      },
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: BlocBuilder<LearnedDefsBloc, LearnedDefsState>(
              builder: (context, state) {
                if (state.defs.isNotEmpty) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        dayRevWidget,
                        LearnedDefsRefHost(state: state),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    dayRevWidget,
                    Expanded(child: LearnedDefsRefHost(state: state)),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextEntryWidget(
              onClickedAdd: (word) => _onAddNewWord(context, word),
            ),
          ),
        ],
      ),
    );
  }
}
