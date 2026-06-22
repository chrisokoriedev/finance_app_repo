import 'package:expense_app/features/CreateExpense/create_expense_view.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/utils/setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:gap/gap.dart';

class ExpenseSubTypeComponent extends ConsumerWidget {
  const ExpenseSubTypeComponent({
    super.key,
    required this.chooseSubExpense,
    required this.expenseSubListType,
  });

  final String chooseSubExpense;
  final List expenseSubListType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    final displayValue = chooseSubExpense == '..' ? 'Select expense category' : chooseSubExpense;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: CategorySelectionSheet(
              currentSelection: chooseSubExpense,
              categories: expenseSubListType.cast<String>(),
              onSelected: (val) {
                ref.read(expenseSubItemTypeProvider.notifier).state = val;
              },
            ),
          ),
        );
      },
      child: NeuWell(
        radius: 15,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: displayValue,
              color: chooseSubExpense == '..' ? neu.textSecondary : neu.textPrimary,
              fontSize: 14.sp,
              fontWeight: chooseSubExpense == '..' ? FontWeight.normal : FontWeight.w500,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: neu.textSecondary,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySelectionSheet extends StatefulWidget {
  final String currentSelection;
  final List<String> categories;
  final ValueChanged<String> onSelected;

  const CategorySelectionSheet({
    super.key,
    required this.currentSelection,
    required this.categories,
    required this.onSelected,
  });

  @override
  State<CategorySelectionSheet> createState() => _CategorySelectionSheetState();
}

class _CategorySelectionSheetState extends State<CategorySelectionSheet> {
  String searchPattern = '';

  @override
  Widget build(BuildContext context) {
    final neu = context.neu;
    final filteredCategories = widget.categories
        .where((cat) => cat != '..' && cat.toLowerCase().contains(searchPattern.toLowerCase()))
        .toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: neu.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: neu.primary, width: 3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Select Category',
                color: neu.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                icon: Icon(Icons.close, color: neu.textSecondary, size: 18.sp),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          Gap(1.h),
          // Search Field
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            decoration: BoxDecoration(
              color: neu.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: neu.inset,
            ),
            child: TextFormField(
              onChanged: (val) => setState(() => searchPattern = val),
              style: TextStyle(color: neu.textPrimary, fontSize: 14.sp),
              cursorColor: neu.primary,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                hintStyle: TextStyle(color: neu.textSecondary, fontSize: 13.5.sp),
                prefixIcon: Icon(Icons.search, color: neu.textSecondary, size: 18.sp),
                border: InputBorder.none,
                isCollapsed: false,
                contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
              ),
            ),
          ),
          Gap(2.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 40.h),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final cat = filteredCategories[index];
                final isSelected = cat == widget.currentSelection;
                final catIcon = getCategoryIcon(cat, 'Expense');
                return CustomButton(
                  icons: catIcon,
                  title: cat,
                  color: isSelected ? neu.primary : null,
                  margin: 10,
                  showLastWidget: true,
                  lastWidget: isSelected
                      ? Icon(Icons.check_circle, color: neu.primary, size: 16.sp)
                      : const SizedBox.shrink(),
                  press: () {
                    widget.onSelected(cat);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
