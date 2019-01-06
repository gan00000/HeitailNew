#import <Foundation/Foundation.h>
#import "NSString+MessageDigest.h"
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (MessageDigestMixcode)
- (void)MD2Mixcode:(NSString *)mixcode;
- (void)MD4Mixcode:(NSString *)mixcode;
- (void)MD5Mixcode:(NSString *)mixcode;
- (void)SHA1Mixcode:(NSString *)mixcode;
- (void)SHA224Mixcode:(NSString *)mixcode;
- (void)SHA256Mixcode:(NSString *)mixcode;
- (void)SHA384Mixcode:(NSString *)mixcode;
- (void)SHA512Mixcode:(NSString *)mixcode;

@end
