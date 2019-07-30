#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN
@interface XRRFATKDRSandBoxManager : NSObject
#pragma mark - 磁盘信息获取
+ (void)skarggetDiskSpaceInfoWithBlock:(void(^)(NSError *error, unsigned long long freeSpace, unsigned long long totalSpace))block;
+ (void)skarggetFileSizeWithPath:(NSString*)filePath
                  doneBlock:(void(^)(NSError *error, unsigned long long fileSize))block;
#pragma mark - 沙盒系统文件夹路径，文件管理
+ (NSString *)skarggetDocumentPath;
+ (void)skarggetDirectoryInDocumentWithName:(NSString *)dirName
                             doneBlock:(void(^)(BOOL success, NSError *error, NSString *dirPath))block;
+ (void)skarggetFilePathWithName:(NSString *)fileName
                      inDir:(NSString *)dirName
                  doneBlock:(void(^)(NSError *error, NSString *filePath))block;
+ (NSArray *)skarggetSubpathsAtPath:(NSString *)dirPath;
+ (void)skargmoveFileAtPath:(NSString *)path
                toPath:(NSString *)targetPath
             doneBlock:(void(^)(BOOL success, NSError *error))block;
+ (BOOL)skargisExistsFileAtPath:(NSString *)filePath;
+ (BOOL)skargisExistsFolderAtPath:(NSString *)folderPath;
+ (void)skargdeleteFileAtPath:(NSString *)filePath doneBlock:(void(^)(NSString *filePath, BOOL success, NSError *error))block;
#pragma mark- 获取文件的数据
+ (NSData *)skarggetDataForPath:(NSString *)path;
#pragma mark - 保存图片到手机相册
+ (void)skargsaveToDiskWithImage:(UIImage *)image
              saveDoneBlock:(void(^)(BOOL success, NSError *error))saveDoneBlock;
@end
NS_ASSUME_NONNULL_END
