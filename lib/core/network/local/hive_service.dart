import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/constants/hive_table_constants.dart';
import '../../../features/home/data/model/home_hive_model.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    // Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(HomeHiveModelAdapter());

    await addDummyBook();
  }

  Future<void> addBook(HomeHiveModel book) async {
    var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.bookBox);
    await box.put(book.bookId, book);
  }

  Future<List<HomeHiveModel>> getAllBooks() async {
    var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.bookBox);
    var books = box.values.toList();
    box.close();
    return books;
  }

  // get bookmarked books
  Future<List<HomeHiveModel>> getBookmarkedBooks() async {
    var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.bookBox);
    var books = box.values.toList();
    box.close();
    return books;
  }

  // get user books
  Future<List<HomeHiveModel>> getUserBooks() async {
    var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.bookBox);
    var books = box.values.toList();
    box.close();
    return books;
  }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteFromDisk();
  }

  Future<void> addDummyBook() async {
    var box = await Hive.openBox<HomeHiveModel>(HiveTableConstant.bookBox);
    if (box.isEmpty) {
      final book1 = HomeHiveModel(
        title: 'The Alchemist',
        author: 'Paulo Coelho',
        description:
            'The Alchemist is a novel by Brazilian author Paulo Coelho that was first published in 1988. Originally written in Portuguese, it became a widely translated international bestseller.',
        genre: 'Adventure',
        language: 'English',
        bookCover:
            'https://images-na.ssl-images-amazon.com/images/I/81nzxODnaJL.jpg',
        date: '1988',
        user: {},
        formattedCreatedAt: '1 day ago',
      );

      final book2 = HomeHiveModel(
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        description:
            'The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, the novel depicts narrator Nick Carraway\'s interactions with mysterious millionaire Jay Gatsby and Gatsby\'s obsession to reunite with his former lover, Daisy Buchanan.',
        genre: 'Novel',
        language: 'English',
        bookCover:
            'https://images-na.ssl-images-amazon.com/images/I/81nzxODnaJL.jpg',
        date: '1925',
        user: {},
        formattedCreatedAt: '1 day ago',
      );

      List<HomeHiveModel> books = [book1, book2];

      for (var book in books) {
        await addBook(book);
      }
    }
  }
}
