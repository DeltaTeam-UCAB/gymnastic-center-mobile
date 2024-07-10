import 'package:gymnastic_center/domain/datasources/blogs/blogs_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_proxy.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/hive_blog_proxy.dart';

class HiveCacheProxyBlogDatasource extends BlogsDatasource {
  BlogsDatasource datasource;
  HiveCacheProvider cacheProvider;
  late CacheProxy cacheProxy;

  HiveCacheProxyBlogDatasource(this.datasource, this.cacheProvider) {
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
    return (await cacheProxy.tryRetrieve<List<HiveBlog>>(
            truthSource: () async {
              return (await datasource.getAllBlogs(
                      page: page,
                      perPage: perPage,
                      filter: filter,
                      trainer: trainer,
                      category: category))
                  .map((e) => HiveBlog.fromProxiedType(e))
                  .toList();
            },
            collection: 'all_blogs',
            identifier: cacheIdentifier))
        .map((e) => e.toProxiedType())
        .toList();
  }

  @override
  Future<Blog> getBlogById(String blogId) async {
    return (await cacheProxy.tryRetrieve<HiveBlog>(
            truthSource: () async {
              var data = await datasource.getBlogById(blogId);
              return HiveBlog.fromProxiedType(data);
            },
            collection: 'blogs',
            identifier: blogId))
        .toProxiedType();
  }
}
