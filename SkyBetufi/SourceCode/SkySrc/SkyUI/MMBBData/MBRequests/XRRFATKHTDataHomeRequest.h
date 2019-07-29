//
//  XRRFATKHTDataHomeRequest.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTDataHomeInfoModel.h"

@interface XRRFATKHTDataHomeRequest : NSObject

+ (void)skargrequestWithType:(NSInteger)type successBlock:(void(^)(XRRFATKHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock;



@end
