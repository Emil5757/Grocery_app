import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/support_content_model.dart';
import '../widgets/design_label.dart';
import '../widgets/help_search_field.dart';
import '../widgets/support_scaffold.dart';
import '../widgets/support_tile.dart';

/// "Help": greeting, search, Top Questions and Topics. Typing filters both
/// lists; any row opens the FAQ.
class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> _filter(List<String> items) {
    final q = _query.trim().toLowerCase();
    return q.isEmpty ? items : items.where((s) => s.toLowerCase().contains(q)).toList();
  }

  /// Section title (centred 38 px into a `titleSlot`-tall band) and its
  /// 54 px rows.
  List<Widget> _section(String title, List<String> rows, double titleSlot) => [
        DesignLabel(
          text: title,
          style: AppTextStyles.body16Bold,
          height: titleSlot,
          centerY: 38.3,
        ),
        for (final row in rows)
          SupportTile(
            title: row,
            height: SupportTile.helpHeight,
            onTap: () => Go.to(context, Pager.faq),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    final questions = _filter(HelpContent.topQuestions);
    final topics = _filter(HelpContent.topics);

    return SupportScaffold(
      title: AppTexts.help,
      children: [
        DesignLabel(
          text: AppTexts.howCanWeHelp,
          style: AppTextStyles.body16Bold,
          height: 80,
          centerY: 38,
        ),
        HelpSearchField(
          controller: _searchController,
          onChanged: (v) => setState(() => _query = v),
        ),
        if (questions.isNotEmpty) ..._section(AppTexts.topQuestions, questions, 45),
        if (topics.isNotEmpty) ..._section(AppTexts.topics, topics, 50),
        if (questions.isEmpty && topics.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Text(
              AppTexts.noHelpResults,
              textAlign: TextAlign.center,
              style: AppTextStyles.paragraph16Muted,
            ),
          ),
      ],
    );
  }
}
