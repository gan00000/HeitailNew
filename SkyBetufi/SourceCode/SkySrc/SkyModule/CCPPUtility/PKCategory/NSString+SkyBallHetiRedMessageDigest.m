#import "NSString+SkyBallHetiRedMessageDigest.h"
#import <CommonCrypto/CommonCrypto.h>
typedef unsigned char *(*MessageDigestFuncPtr)(const void *data, CC_LONG len, unsigned char *md);
static NSString *_getMessageDigest(NSString *string, MessageDigestFuncPtr fp, NSUInteger length)
{
    const char *cString = [string UTF8String];
    unsigned char *digest = malloc(sizeof(unsigned char) * length);
    fp(cString, (CC_LONG)strlen(cString), digest);
    NSMutableString *hash = [NSMutableString stringWithCapacity:length * 2];
    for (int i = 0; i < length; ++i) {
        [hash appendFormat:@"%02x", digest[i]];
    }
    free(digest);
    return [hash lowercaseString];
}
@implementation NSString (SkyBallHetiRedMessageDigest)
- (NSString *)MD2
{
    return _getMessageDigest(self, CC_MD2, CC_MD2_DIGEST_LENGTH);
}
- (NSString *)MD4
{
    return _getMessageDigest(self, CC_MD4, CC_MD4_DIGEST_LENGTH);
}
- (NSString *)MD5
{
    return _getMessageDigest(self, CC_MD5, CC_MD5_DIGEST_LENGTH);
}
- (NSString *)SHA1
{
    return _getMessageDigest(self, CC_SHA1, CC_SHA1_DIGEST_LENGTH);
}
- (NSString *)SHA224
{
    return _getMessageDigest(self, CC_SHA224, CC_SHA224_DIGEST_LENGTH);
}
- (NSString *)SHA256
{
    return _getMessageDigest(self, CC_SHA256, CC_SHA256_DIGEST_LENGTH);
}
- (NSString *)SHA384
{
    return _getMessageDigest(self, CC_SHA384, CC_SHA384_DIGEST_LENGTH);
}
- (NSString *)SHA512
{
    return _getMessageDigest(self, CC_SHA256, CC_SHA256_DIGEST_LENGTH);
}

- (NSString *)urlEncodeString
{
    NSString *result =
    (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                          (CFStringRef)self,
                                                                          NULL,
                                                                          (CFStringRef)@";/?:@&=$+{}<>,",
                                                                          kCFStringEncodingUTF8));
    return result;
}

-(NSString *)urlDecodeString
{
    NSString *result = (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                     (__bridge CFStringRef) self,
                                                                                                     CFSTR(""),
                                                                                                     kCFStringEncodingUTF8);
    return result;
}



@end
