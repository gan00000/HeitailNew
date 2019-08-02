#import "SkyBallHetiRedTZAssetModel.h"
#import "SkyBallHetiRedTZImageManager.h"
@implementation SkyBallHetiRedTZAssetModel
+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type{
    SkyBallHetiRedTZAssetModel *model = [[SkyBallHetiRedTZAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}
+ (instancetype)modelWithAsset:(id)asset type:(TZAssetModelMediaType)type timeLength:(NSString *)timeLength {
    SkyBallHetiRedTZAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}
@end
@implementation TZAlbumModel
- (void)setResult:(id)result {
    _result = result;
    BOOL allowPickingImage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tz_allowPickingImage"] isEqualToString:@"1"];
    BOOL allowPickingVideo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tz_allowPickingVideo"] isEqualToString:@"1"];
    [[SkyBallHetiRedTZImageManager manager] getAssetsFromFetchResult:result allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage completion:^(NSArray<SkyBallHetiRedTZAssetModel *> *models) {
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
    for (SkyBallHetiRedTZAssetModel *model in _selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (SkyBallHetiRedTZAssetModel *model in _models) {
        if ([[SkyBallHetiRedTZImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
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
