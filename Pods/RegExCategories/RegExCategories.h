#import <Foundation/Foundation.h>
#ifndef DisableObjectiveCRegexCategoriesMacros
#define Rx NSRegularExpression
#endif
#ifndef DisableObjectiveCRegexCategoriesMacros
#define RX(pattern) [[NSRegularExpression alloc] initWithPattern:pattern]
#endif
@interface RxMatch : NSObject
@property (retain) NSString* value;    
@property (assign) NSRange   range;    
@property (retain) NSArray*  groups;   
@property (retain) NSString* original; 
@end
@interface RxMatchGroup : NSObject
@property (retain) NSString* value;
@property (assign) NSRange range;
@end
@interface NSRegularExpression (ObjectiveCRegexCategories)
- (NSRegularExpression*) initWithPattern:(NSString*)pattern;
+ (NSRegularExpression*) rx:(NSString*)pattern;
+ (NSRegularExpression*) rx:(NSString*)pattern ignoreCase:(BOOL)ignoreCase;
+ (NSRegularExpression*) rx:(NSString*)pattern options:(NSRegularExpressionOptions)options;
- (BOOL) isMatch:(NSString*)matchee;
- (int) indexOf:(NSString*)str;
- (NSArray*) split:(NSString*)str;
- (NSString*) replace:(NSString*)string with:(NSString*)replacement;
- (NSString*) replace:(NSString*)string withBlock:(NSString*(^)(NSString* match))replacer;
- (NSString*) replace:(NSString *)string withDetailsBlock:(NSString*(^)(RxMatch* match))replacer;
- (NSArray*) matches:(NSString*)str;
- (NSString*) firstMatch:(NSString*)str;
- (NSArray*) matchesWithDetails:(NSString*)str;
- (RxMatch*) firstMatchWithDetails:(NSString*)str;
@end
@interface NSString (ObjectiveCRegexCategories)
- (NSRegularExpression*) toRx;
- (NSRegularExpression*) toRxIgnoreCase:(BOOL)ignoreCase;
- (NSRegularExpression*) toRxWithOptions:(NSRegularExpressionOptions)options;
- (BOOL) isMatch:(NSRegularExpression*)rx;
- (int) indexOf:(NSRegularExpression*)rx;
- (NSArray*) split:(NSRegularExpression*)rx;
- (NSString*) replace:(NSRegularExpression*)rx with:(NSString*)replacement;
- (NSString*) replace:(NSRegularExpression *)rx withBlock:(NSString*(^)(NSString* match))replacer;
- (NSString*) replace:(NSRegularExpression *)rx withDetailsBlock:(NSString*(^)(RxMatch* match))replacer;
- (NSArray*) matches:(NSRegularExpression*)rx;
- (NSString*) firstMatch:(NSRegularExpression*)rx;
- (NSArray*) matchesWithDetails:(NSRegularExpression*)rx;
- (RxMatch*) firstMatchWithDetails:(NSRegularExpression*)rx;
@end
