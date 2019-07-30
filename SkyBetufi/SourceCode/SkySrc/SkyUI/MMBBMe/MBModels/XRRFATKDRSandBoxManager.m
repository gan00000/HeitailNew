#import "XRRFATKDRSandBoxManager.h"
@implementation XRRFATKDRSandBoxManager
#pragma mark - 磁盘信息获取
+ (void)skarggetDiskSpaceInfoWithBlock:(void(^)(NSError *error, unsigned long long freeSpace, unsigned long long totalSpace))block {
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error:&error];
    if (!error && dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        block(nil, [freeFileSystemSizeInBytes longLongValue], [fileSystemSizeInBytes longLongValue]);
    } else {
        block(error, 0, 0);
    }
}
+ (void)skarggetFileSizeWithPath:(NSString*)filePath
                  doneBlock:(void(^)(NSError *error, unsigned long long fileSize))block {
    if (!filePath) {
        NSError *error = [NSError errorWithDomain:@"filePath 不可为空"
                                             code:-1
                                         userInfo:nil];
        block(error, 0);
        return;
    }
    NSFileManager* manager = [NSFileManager defaultManager];
    NSError *error;
    if ([manager fileExistsAtPath:filePath]) {
        unsigned long long fileSize = [[manager attributesOfItemAtPath:filePath error:&error] fileSize];
        if (error) {
            block(error, 0);
        } else {
            block(nil, fileSize);
        }
    } else {
        error = [NSError errorWithDomain:[NSString stringWithFormat:@"不存在文件 : %@", filePath]
                                    code:-1
                                userInfo:nil];
        block(error, 0);
    }
}
#pragma mark - 沙盒系统文件夹路径，文件管理
+ (NSString *)skarggetDocumentPath {
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [Paths objectAtIndex:0];
}
+ (void)skarggetDirectoryInDocumentWithName:(NSString *)dirName
                             doneBlock:(void(^)(BOOL success, NSError *error, NSString *dirPath))block {
    if (!dirName) {
        NSError *error = [NSError errorWithDomain:@"dirName 不可为空"
                                             code:-1
                                         userInfo:nil];
        block(NO, error, nil);
        return;
    }
    NSString *document = [self skarggetDocumentPath];
    NSString *dirPath = dirName;
    NSError *error = nil;
    if ([dirName rangeOfString:document].length == 0) {
        dirPath = [document stringByAppendingPathComponent:dirName];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    if (!(isDirExist && isDir)) {
        if (![fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
            block(NO, error, nil);
            return;
        }
    }
    block(YES, nil, dirPath);
}
+ (void)skarggetFilePathWithName:(NSString *)fileName
                      inDir:(NSString *)dirName
                  doneBlock:(void(^)(NSError *error, NSString *filePath))block {
    [self skarggetDirectoryInDocumentWithName:dirName doneBlock:^(BOOL success, NSError *error, NSString *dirPath) {
        if (!success) {
            block(error, nil);
        } else {
            block(nil, [dirPath stringByAppendingPathComponent:fileName]);
        }
    }];
}
+ (NSArray *)skarggetSubpathsAtPath:(NSString *)dirPath {
    return [[NSFileManager defaultManager] subpathsAtPath:dirPath];
}
+ (void)skargmoveFileAtPath:(NSString *)path
                toPath:(NSString *)targetPath
             doneBlock:(void(^)(BOOL success, NSError *error))block {
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSError *error;
    if([fileManage moveItemAtPath:path toPath:targetPath error:&error]) {
        block(YES, nil);
    } else {
        block(NO, error);
    }
}
+ (BOOL)skargisExistsFileAtPath:(NSString *)filePath {
    BOOL isDir;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir];
    return isExists && !isDir;
}
+ (BOOL)skargisExistsFolderAtPath:(NSString *)folderPath {
    BOOL isDir;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:folderPath isDirectory:&isDir];
    return isExists && isDir;
}
+ (void)skargdeleteFileAtPath:(NSString *)filePath doneBlock:(void(^)(NSString *filePath, BOOL success, NSError *error))block {
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:filePath]) {
        NSError *error;
        if ([manager removeItemAtPath:filePath error:&error]) {
            block(filePath, YES, nil);
        } else {
            block(filePath, NO, error);
        }
    }
}
#pragma mark- 获取文件的数据
+ (NSData *)skarggetDataForPath:(NSString *)path {
    return [[NSFileManager defaultManager] contentsAtPath:path];
}
#pragma mark - 保存图片到手机相册
+ (void)skargsaveToDiskWithImage:(UIImage *)image
              saveDoneBlock:(void(^)(BOOL success, NSError *error))saveDoneBlock {
    PHPhotoLibrary *lib = [PHPhotoLibrary sharedPhotoLibrary];
    [lib performChanges:^{
        PHAssetCollectionChangeRequest *collectionRequest;
        PHAssetCollection *assetCollection = [self getCurrentPhotoCollectionWithTitle:@"时光序"];
        if (assetCollection) { 
            collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else { 
            collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"时光序"];
        }
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
        [collectionRequest addAssets:@[placeholder]];
    } completionHandler:saveDoneBlock];
}
+ (PHAssetCollection *)getCurrentPhotoCollectionWithTitle:(NSString *)collectionName {
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle containsString:collectionName]) {
            return assetCollection;
        }
    }
    return nil;
}
@end
