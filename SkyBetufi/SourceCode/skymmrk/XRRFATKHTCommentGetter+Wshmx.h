#import <Foundation/Foundation.h>
#import "XRRFATKHTCommentModel.h"
#import "XRRFATKHTCommentGetter.h"
#import "XRRFATKHTNewsAdditionRequest.h"

@interface XRRFATKHTCommentGetter (Wshmx)
+ (BOOL)initWithPostIdWshmx:(NSInteger)Wshmx;
+ (BOOL)skargresetWshmx:(NSInteger)Wshmx;
+ (BOOL)skargdoRequestWithCompleteBlockWshmx:(NSInteger)Wshmx;
+ (BOOL)loadHotCommentsWithCompleteBlockWshmx:(NSInteger)Wshmx;
+ (BOOL)loadNormalCommentsWithCompleteBlockWshmx:(NSInteger)Wshmx;
+ (BOOL)countHeightForCommentsWshmx:(NSInteger)Wshmx;

@end
