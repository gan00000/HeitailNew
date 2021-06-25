#import <Foundation/Foundation.h>
@interface NSString (CCCaseMessageDigest)
- (NSString *)MD2;
- (NSString *)MD4;
- (NSString *)MD5;
- (NSString *)SHA1;
- (NSString *)SHA224;
- (NSString *)SHA256;
- (NSString *)SHA384;
- (NSString *)SHA512;


- (NSString *)urlEncodeString;

-(NSString *)urlDecodeString;


@end
