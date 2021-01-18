#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN
@interface GlodBuleDRSandBoxManager : NSObject
#pragma mark - 磁盘信息获取
+ (void)waterSkygetDiskSpaceInfoWithBlock:(void(^)(NSError *error, unsigned long long freeSpace, unsigned long long totalSpace))block;
+ (void)waterSkygetFileSizeWithPath:(NSString*)filePath
                  doneBlock:(void(^)(NSError *error, unsigned long long fileSize))block;
#pragma mark - 沙盒系统文件夹路径，文件管理
+ (NSString *)waterSkygetDocumentPath;
+ (void)waterSkygetDirectoryInDocumentWithName:(NSString *)dirName
                             doneBlock:(void(^)(BOOL success, NSError *error, NSString *dirPath))block;
+ (void)waterSkygetFilePathWithName:(NSString *)fileName
                      inDir:(NSString *)dirName
                  doneBlock:(void(^)(NSError *error, NSString *filePath))block;
+ (NSArray *)waterSkygetSubpathsAtPath:(NSString *)dirPath;
+ (void)waterSkymoveFileAtPath:(NSString *)path
                toPath:(NSString *)targetPath
             doneBlock:(void(^)(BOOL success, NSError *error))block;
+ (BOOL)waterSkyisExistsFileAtPath:(NSString *)filePath;
+ (BOOL)waterSkyisExistsFolderAtPath:(NSString *)folderPath;
+ (void)waterSkydeleteFileAtPath:(NSString *)filePath doneBlock:(void(^)(NSString *filePath, BOOL success, NSError *error))block;
#pragma mark- 获取文件的数据
+ (NSData *)waterSkygetDataForPath:(NSString *)path;
#pragma mark - 保存图片到手机相册
+ (void)waterSkysaveToDiskWithImage:(UIImage *)image
              saveDoneBlock:(void(^)(BOOL success, NSError *error))saveDoneBlock;
@end
NS_ASSUME_NONNULL_END
