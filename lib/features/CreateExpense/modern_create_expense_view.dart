import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';

import '../../domain/expense.dart';
import '../../domain/enums.dart';
import '../../domain/result.dart';
import '../../providers/expense_providers.dart';
import '../../utils/colors.dart';
import '../../utils/text.dart';
import '../../utils/const.dart';

/// Modern create expense view using new architecture
class ModernCreateExpenseView extends ConsumerStatefulWidget {
  const ModernCreateExpenseView({super.key});

  @override
  ConsumerState<ModernCreateExpenseView> createState() => _ModernCreateExpenseViewState();
}

class _ModernCreateExpenseViewState extends ConsumerState<ModernCreateExpenseView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  ExpenseType _selectedType = ExpenseType.expense;
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = '..';

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final categoriesAsync = ref.watch(categoriesNotifierProvider);
    final createExpenseAsync = ref.watch(createExpenseNotifierProvider);

    // Listen to create expense result
    ref.listen(createExpenseNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (result) {
          if (result.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Expense created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
          } else if (result.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(
          text: 'Create Expense',
          color: theme.primary,
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: theme.surface,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expense Type Selection
              _buildExpenseTypeSelector(theme),
              Gap(3.h),
              
              // Name and Amount Row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildNameField(theme),
                  ),
                  Gap(2.w),
                  Expanded(
                    child: _buildAmountField(theme),
                  ),
                ],
              ),
              Gap(2.h),
              
              // Category Selection (only for expenses)
              if (_selectedType == ExpenseType.expense) ...[
                _buildCategorySelector(theme, categoriesAsync),
                Gap(2.h),
              ],
              
              // Description Field
              _buildDescriptionField(theme),
              Gap(2.h),
              
              // Date Selection
              _buildDateSelector(theme),
              Gap(4.h),
              
              // Create Button
              _buildCreateButton(theme, createExpenseAsync),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseTypeSelector(ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Transaction Type',
          color: theme.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(1.h),
        Row(
          children: ExpenseType.values.map((type) {
            final isSelected = _selectedType == type;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedType = type),
                child: Container(
                  margin: EdgeInsets.only(right: 2.w),
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: isSelected ? type.color.withOpacity(0.2) : theme.surface,
                    border: Border.all(
                      color: isSelected ? type.color : theme.outline,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Column(
                    children: [
                      Text(
                        type.emoji,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      Gap(0.5.h),
                      TextWidget(
                        text: type.displayName,
                        color: isSelected ? type.color : theme.primary,
                        fontSize: 12.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNameField(ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Title',
          color: theme.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(0.5.h),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Enter title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Title is required';
            }
            if (value.trim().length < 2) {
              return 'Title must be at least 2 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAmountField(ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Amount',
          color: theme.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(0.5.h),
        TextFormField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '0.00',
            prefixText: '₦ ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Amount is required';
            }
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Enter valid amount';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCategorySelector(ColorScheme theme, AsyncValue<Result<List<String>>> categoriesAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Category',
          color: theme.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(0.5.h),
        categoriesAsync.when(
          data: (result) {
            if (result.isSuccess) {
              final categories = result.data!;
              return DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                ),
                items: [
                  const DropdownMenuItem(value: '..', child: Text('Select category')),
                  ...categories.map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  )),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCategory = value);
                  }
                },
                validator: (value) {
                  if (value == null || value == '..') {
                    return 'Please select a category';
                  }
                  return null;
                },
              );
            } else {
              return const Text('Error loading categories');
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ],
    );
  }

  Widget _buildDescriptionField(ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Description',
          color: theme.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(0.5.h),
        TextFormField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter description',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Description is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDateSelector(ColorScheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Date',
          color: theme.primary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        Gap(0.5.h),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(color: theme.outline),
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Row(
              children: [
                LineIcon.calendar(color: theme.primary),
                Gap(2.w),
                TextWidget(
                  text: '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  color: theme.primary,
                  fontSize: 14.sp,
                ),
                const Spacer(),
                LineIcon.chevronDown(color: theme.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton(ColorScheme theme, AsyncValue<Result<Expense>> createExpenseAsync) {
    final isLoading = createExpenseAsync.isLoading;
    
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : _createExpense,
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedType.color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.sp),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : TextWidget(
                text: 'Create ${_selectedType.displayName}',
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  void _createExpense() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final request = CreateExpenseRequest(
      name: _nameController.text.trim(),
      amount: double.parse(_amountController.text),
      type: _selectedType,
      description: _descriptionController.text.trim(),
      dateTime: _selectedDate,
      category: _selectedType == ExpenseType.expense ? _selectedCategory : 'General',
    );

    ref.read(createExpenseNotifierProvider.notifier).createExpense(request);
  }
}
