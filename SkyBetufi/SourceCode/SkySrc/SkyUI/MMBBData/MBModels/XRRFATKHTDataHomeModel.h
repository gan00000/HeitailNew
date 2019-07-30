#import <Foundation/Foundation.h>
@interface XRRFATKHTDataHomeModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *officialImagesrc;
@property (nonatomic, copy) NSString *team_logo;
@property (nonatomic, copy) NSString *html_team_logo;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, assign) CGFloat pts;
- (void)skargimageUrlFixWithWidth:(NSInteger)width;
@end
