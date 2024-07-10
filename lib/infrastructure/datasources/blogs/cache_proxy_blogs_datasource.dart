import 'package:gymnastic_center/domain/datasources/blogs/blogs_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_proxy.dart';

class CacheProxyBlogDatasource extends BlogsDatasource {
  BlogsDatasource datasource;
  CacheProvider cacheProvider;
  late CacheProxy cacheProxy;

  CacheProxyBlogDatasource(this.datasource, this.cacheProvider) {
    cacheProxy = CacheProxy(cacheProvider);
  }

  String _allBlogsIdentifier(
      {int page = 1,
      int perPage = 10,
      required BlogFilter filter,
      String? trainer,
      String? category}) {
    String pageStr = page.toString();
    String perPageStr = perPage.toString();
    String filterStr = filter.name;
    String trainerStr = trainer ?? 'notrainer';
    String categoryStr = category ?? 'nocategory';
    return '${pageStr}_${perPageStr}_${filterStr}_${trainerStr}_$categoryStr';
  }

  @override
  Future<List<Blog>> getAllBlogs(
      {int page = 1,
      int perPage = 10,
      required BlogFilter filter,
      String? trainer,
      String? category}) async {
    var cacheIdentifier = _allBlogsIdentifier(
        page: page,
        perPage: perPage,
        filter: filter,
        trainer: trainer,
        category: category);
    return await cacheProxy.tryRetrieve<List<Blog>>(
        truthSource: () => datasource.getAllBlogs(
            page: page,
            perPage: perPage,
            filter: filter,
            trainer: trainer,
            category: category),
        collection: 'all_blogs',
        identifier: cacheIdentifier);
  }

  @override
  Future<Blog> getBlogById(String blogId) async {
    return await cacheProxy.tryRetrieve<Blog>(
        truthSource: () => datasource.getBlogById(blogId),
        collection: 'blogs',
        identifier: blogId);
  }
}
