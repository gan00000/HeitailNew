#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN
@interface UUaksDRSandBoxManager : NSObject
#pragma mark - 磁盘信息获取
+ (void)taogetDiskSpaceInfoWithBlock:(void(^)(NSError *error, unsigned long long freeSpace, unsigned long long totalSpace))block;
+ (void)taogetFileSizeWithPath:(NSString*)filePath
                  doneBlock:(void(^)(NSError *error, unsigned long long fileSize))block;
#pragma mark - 沙盒系统文件夹路径，文件管理
+ (NSString *)taogetDocumentPath;
+ (void)taogetDirectoryInDocumentWithName:(NSString *)dirName
                             doneBlock:(void(^)(BOOL success, NSError *error, NSString *dirPath))block;
+ (void)taogetFilePathWithName:(NSString *)fileName
                      inDir:(NSString *)dirName
                  doneBlock:(void(^)(NSError *error, NSString *filePath))block;
+ (NSArray *)taogetSubpathsAtPath:(NSString *)dirPath;
+ (void)taomoveFileAtPath:(NSString *)path
                toPath:(NSString *)targetPath
             doneBlock:(void(^)(BOOL success, NSError *error))block;
+ (BOOL)taoisExistsFileAtPath:(NSString *)filePath;
+ (BOOL)taoisExistsFolderAtPath:(NSString *)folderPath;
+ (void)taodeleteFileAtPath:(NSString *)filePath doneBlock:(void(^)(NSString *filePath, BOOL success, NSError *error))block;
#pragma mark- 获取文件的数据
+ (NSData *)taogetDataForPath:(NSString *)path;
#pragma mark - 保存图片到手机相册
+ (void)taosaveToDiskWithImage:(UIImage *)image
              saveDoneBlock:(void(^)(BOOL success, NSError *error))saveDoneBlock;
@end
NS_ASSUME_NONNULL_END
