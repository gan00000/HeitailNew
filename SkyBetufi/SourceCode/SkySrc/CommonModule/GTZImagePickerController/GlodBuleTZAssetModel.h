#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    TZAssetModelMediaTypePhoto = 0,
    TZAssetModelMediaTypeLivePhoto,
    TZAssetModelMediaTypePhotoGif,
    TZAssetModelMediaTypeVideo,
    TZAssetModelMediaTypeAudio
} TZAssetModelMediaType;
@class PHAsset;
@interface GlodBuleTZAssetModel : NSObject
@property (nonatomic, strong) id asset;             
@property (nonatomic, assign) BOOL isSelected;      
@property (nonatomic, assign) TZAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;
+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type timeLength:(NSString *)timeLength;
@end
@class PHFetchResult;
@interface TZAlbumModel : NSObject
@property (nonatomic, strong) NSString *name;        
@property (nonatomic, assign) NSInteger count;       
@property (nonatomic, strong) id result;             
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSArray *selectedModels;
@property (nonatomic, assign) NSUInteger selectedCount;
@property (nonatomic, assign) BOOL isCameraRoll;
@end
