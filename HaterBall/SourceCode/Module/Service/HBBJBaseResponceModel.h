#import "YYModel.h"
typedef NS_ENUM(NSInteger, BJResponseCode) {
    BJResponseCodeTokenExpired = -1,
    BJResponseCodeAccountKickOut = -2,
    BJResponseCodeError1 = -100,
    BJResponseCodeOK = 0
};
@interface HBBJBaseResponceModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSDictionary *page;
@property (nonatomic, assign) unsigned int total;
- (NSInteger)pagesValueOfPage; 
- (NSInteger)totalValueOfPage; 
@end
