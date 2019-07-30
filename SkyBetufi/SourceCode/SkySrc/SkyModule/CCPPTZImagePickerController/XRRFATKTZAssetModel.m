#import "XRRFATKTZAssetModel.h"
#import "XRRFATKTZImageManager.h"
@implementation XRRFATKTZAssetModel
+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type{
    XRRFATKTZAssetModel *model = [[XRRFATKTZAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}
+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type timeLength:(NSString *)timeLength {
    XRRFATKTZAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}
@end
@implementation TZAlbumModel
- (void)setResult:(id)result {
    _result = result;
    BOOL allowPickingImage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tz_allowPickingImage"] isEqualToString:@"1"];
    BOOL allowPickingVideo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tz_allowPickingVideo"] isEqualToString:@"1"];
    [[XRRFATKTZImageManager manager] getAssetsFromFetchResult:result allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage completion:^(NSArray<XRRFATKTZAssetModel *> *models) {
        _models = models;
        if (_selectedModels) {
            [self checkSelectedModels];
        }
    }];
}
- (void)setSelectedModels:(NSArray *)selectedModels {
    _selectedModels = selectedModels;
    if (_models) {
        [self checkSelectedModels];
    }
}
- (void)checkSelectedModels {
    self.selectedCount = 0;
    NSMutableArray *selectedAssets = [NSMutableArray array];
    for (XRRFATKTZAssetModel *model in _selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (XRRFATKTZAssetModel *model in _models) {
        if ([[XRRFATKTZImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            self.selectedCount ++;
        }
    }
}
- (NSString *)name {
    if (_name) {
        return _name;
    }
    return @"";
}
@end
