#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSObject (YYModel)
+ (nullable instancetype)yy_modelWithJSON:(id)json;
+ (nullable instancetype)yy_modelWithDictionary:(NSDictionary *)dictionary;
- (BOOL)yy_modelSetWithJSON:(id)json;
- (BOOL)yy_modelSetWithDictionary:(NSDictionary *)dic;
- (nullable id)yy_modelToJSONObject;
- (nullable NSData *)yy_modelToJSONData;
- (nullable NSString *)yy_modelToJSONString;
- (nullable id)yy_modelCopy;
- (void)yy_modelEncodeWithCoder:(NSCoder *)aCoder;
- (id)yy_modelInitWithCoder:(NSCoder *)aDecoder;
- (NSUInteger)yy_modelHash;
- (BOOL)yy_modelIsEqual:(id)model;
- (NSString *)yy_modelDescription;
@end
@interface NSArray (YYModel)
+ (nullable NSArray *)yy_modelArrayWithClass:(Class)cls json:(id)json;
@end
@interface NSDictionary (YYModel)
+ (nullable NSDictionary *)yy_modelDictionaryWithClass:(Class)cls json:(id)json;
@end
@protocol YYModel <NSObject>
@optional
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass;
+ (nullable Class)modelCustomClassForDictionary:(NSDictionary *)dictionary;
+ (nullable NSArray<NSString *> *)modelPropertyBlacklist;
+ (nullable NSArray<NSString *> *)modelPropertyWhitelist;
- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic;
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic;
@end
NS_ASSUME_NONNULL_END
