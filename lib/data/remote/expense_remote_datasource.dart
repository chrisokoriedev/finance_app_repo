import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/expense.dart';
import '../../domain/result.dart';
import '../../domain/enums.dart';
import '../../utils/string_app.dart';

/// Remote data source for expense operations using Firestore
abstract class ExpenseRemoteDataSource {
  Future<Result<List<Expense>>> getExpenses({
    ExpenseFilter? filter,
    int? limit,
    DocumentSnapshot? startAfter,
  });
  
  Future<Result<Expense>> getExpenseById(String id);
  
  Future<Result<Expense>> createExpense(CreateExpenseRequest request);
  
  Future<Result<Expense>> updateExpense(String id, UpdateExpenseRequest request);
  
  Future<Result<void>> deleteExpense(String id);
  
  Future<Result<List<String>>> getCategories();
  
  Future<Result<String>> addCategory(String category);
}

/// Implementation of remote data source using Firestore
class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ExpenseRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _firestore = firestore,
       _auth = auth;

  String get _userId => _auth.currentUser?.uid ?? '';

  CollectionReference<Map<String, dynamic>> get _expensesCollection =>
      _firestore
          .collection(AppString.expense)
          .doc(_userId)
          .collection(AppString.userExpense);

  CollectionReference<Map<String, dynamic>> get _categoriesCollection =>
      _firestore
          .collection(AppString.expenseSubList)
          .doc(_userId)
          .collection(AppString.expenseSubList);

  @override
  Future<Result<List<Expense>>> getExpenses({
    ExpenseFilter? filter,
    int? limit,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _expensesCollection;

      // Apply filters
      if (filter != null) {
        // Type filter
        if (filter.types != null && filter.types!.isNotEmpty) {
          query = query.where('expenseType', whereIn: 
              filter.types!.map((type) => type.value).toList());
        }

        // Date range filter
        if (filter.startDate != null) {
          query = query.where('dateTime', isGreaterThanOrEqualTo: 
              Timestamp.fromDate(filter.startDate!));
        }
        if (filter.endDate != null) {
          query = query.where('dateTime', isLessThanOrEqualTo: 
              Timestamp.fromDate(filter.endDate!));
        }

        // Amount range filter
        if (filter.minAmount != null) {
          query = query.where('amount', isGreaterThanOrEqualTo: filter.minAmount!);
        }
        if (filter.maxAmount != null) {
          query = query.where('amount', isLessThanOrEqualTo: filter.maxAmount!);
        }

        // Category filter
        if (filter.categories != null && filter.categories!.isNotEmpty) {
          query = query.where('expenseSubList', whereIn: filter.categories!);
        }

        // Recurring filter
        if (filter.isRecurring != null) {
          query = query.where('isRecurring', isEqualTo: filter.isRecurring!);
        }
      }

      // Order by date (newest first)
      query = query.orderBy('dateTime', descending: true);

      // Apply pagination
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      if (limit != null && limit > 0) {
        query = query.limit(limit);
      }

      final querySnapshot = await query.get();
      final expenses = <Expense>[];

      for (final doc in querySnapshot.docs) {
        try {
          final data = doc.data();
          data['id'] = doc.id; // Add document ID
          
          // Convert old format to new format if needed
          if (data.containsKey('expenseType') && data['expenseType'] is String) {
            data['type'] = ExpenseType.fromString(data['expenseType']).name;
          }
          
          final expense = Expense.fromJson(data);
          expenses.add(expense);
        } catch (e) {
          print('Error parsing expense document ${doc.id}: $e');
          // Continue with other documents
        }
      }

      // Apply client-side filters that can't be done in Firestore
      if (filter != null) {
        expenses.removeWhere((expense) {
          // Search query filter
          if (filter.searchQuery != null) {
            final query = filter.searchQuery!.toLowerCase();
            if (!expense.name.toLowerCase().contains(query) &&
                !expense.description.toLowerCase().contains(query)) {
              return true;
            }
          }

          // Tags filter
          if (filter.tags != null && expense.tags != null) {
            if (!expense.tags!.toLowerCase().contains(filter.tags!.toLowerCase())) {
              return true;
            }
          }

          return false;
        });
      }

      return Result.success(expenses);
    } catch (e) {
      return Result.failure('Failed to get expenses: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> getExpenseById(String id) async {
    try {
      final doc = await _expensesCollection.doc(id).get();
      
      if (!doc.exists) {
        return Result.failure('Expense not found');
      }

      final data = doc.data()!;
      data['id'] = doc.id;
      
      // Convert old format to new format if needed
      if (data.containsKey('expenseType') && data['expenseType'] is String) {
        data['type'] = ExpenseType.fromString(data['expenseType']).name;
      }
      
      final expense = Expense.fromJson(data);
      return Result.success(expense);
    } catch (e) {
      return Result.failure('Failed to get expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> createExpense(CreateExpenseRequest request) async {
    try {
      final docRef = _expensesCollection.doc();
      
      final data = {
        'id': docRef.id,
        'name': request.name,
        'amount': request.amount,
        'type': request.type.name,
        'expenseType': request.type.value, // Keep for backward compatibility
        'description': request.description,
        'dateTime': Timestamp.fromDate(request.dateTime),
        'category': request.category,
        'expenseSubList': request.category, // Keep for backward compatibility
        'isRecurring': request.isRecurring,
        'recurringPattern': request.recurringPattern,
        'tags': request.tags,
        'receiptUrl': request.receiptUrl,
        'latitude': request.latitude,
        'longitude': request.longitude,
        'location': request.location,
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };

      await docRef.set(data);
      
      final expense = Expense.fromJson(data);
      return Result.success(expense);
    } catch (e) {
      return Result.failure('Failed to create expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<Expense>> updateExpense(String id, UpdateExpenseRequest request) async {
    try {
      final docRef = _expensesCollection.doc(id);
      final doc = await docRef.get();
      
      if (!doc.exists) {
        return Result.failure('Expense not found');
      }

      final existingData = doc.data()!;
      final updateData = <String, dynamic>{
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };

      // Only update fields that are provided
      if (request.name != null) updateData['name'] = request.name;
      if (request.amount != null) updateData['amount'] = request.amount;
      if (request.type != null) {
        updateData['type'] = request.type!.name;
        updateData['expenseType'] = request.type!.value; // Keep for backward compatibility
      }
      if (request.description != null) updateData['description'] = request.description;
      if (request.dateTime != null) updateData['dateTime'] = Timestamp.fromDate(request.dateTime!);
      if (request.category != null) {
        updateData['category'] = request.category;
        updateData['expenseSubList'] = request.category; // Keep for backward compatibility
      }
      if (request.isRecurring != null) updateData['isRecurring'] = request.isRecurring;
      if (request.recurringPattern != null) updateData['recurringPattern'] = request.recurringPattern;
      if (request.tags != null) updateData['tags'] = request.tags;
      if (request.receiptUrl != null) updateData['receiptUrl'] = request.receiptUrl;
      if (request.latitude != null) updateData['latitude'] = request.latitude;
      if (request.longitude != null) updateData['longitude'] = request.longitude;
      if (request.location != null) updateData['location'] = request.location;

      await docRef.update(updateData);
      
      // Get updated document
      final updatedDoc = await docRef.get();
      final updatedData = updatedDoc.data()!;
      updatedData['id'] = updatedDoc.id;
      
      final expense = Expense.fromJson(updatedData);
      return Result.success(expense);
    } catch (e) {
      return Result.failure('Failed to update expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> deleteExpense(String id) async {
    try {
      await _expensesCollection.doc(id).delete();
      return Result.success(null);
    } catch (e) {
      return Result.failure('Failed to delete expense: ${e.toString()}');
    }
  }

  @override
  Future<Result<List<String>>> getCategories() async {
    try {
      final querySnapshot = await _categoriesCollection.get();
      final categories = <String>[];

      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        if (data.containsKey(AppString.expenseSubList)) {
          categories.add(data[AppString.expenseSubList]);
        }
      }

      return Result.success(categories);
    } catch (e) {
      return Result.failure('Failed to get categories: ${e.toString()}');
    }
  }

  @override
  Future<Result<String>> addCategory(String category) async {
    try {
      final docRef = _categoriesCollection.doc();
      await docRef.set({
        AppString.expenseSubList: category,
        'createdAt': Timestamp.fromDate(DateTime.now()),
      });
      
      return Result.success(category);
    } catch (e) {
      return Result.failure('Failed to add category: ${e.toString()}');
    }
  }
}
