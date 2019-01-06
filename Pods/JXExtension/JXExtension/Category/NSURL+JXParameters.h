#import <Foundation/Foundation.h>
@interface NSURL (JXParameters)
@property (nonatomic, strong) NSDictionary *parameters;
- (NSString *)jx_parameterForKey:(NSString *)key;
- (id)jx_objectForKeyedSubscript:(id)key NS_AVAILABLE(10_8, 6_0);
@end
