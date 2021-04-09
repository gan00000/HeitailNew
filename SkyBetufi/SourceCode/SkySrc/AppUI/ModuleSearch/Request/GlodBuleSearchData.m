//
//  GlodBuleSearchData.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "GlodBuleSearchData.h"
#import "GlodBuleHTNewsHomeCell.h"
#import "GlodBuleHTNewsDetailViewController.h"
#import "GlodBuleBJError.h"
#import "GlodBuleSearchRequest.h"

@interface GlodBuleSearchData()

@end

@implementation GlodBuleSearchData

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.newsList) {
        return 0;
    }
    return self.newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath.section:%ld  indexPath.row:%ld", indexPath.section, indexPath.row);
    
    GlodBuleHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTNewsHomeCell"];
    [cell taosetupWithNewsModel:self.newsList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    GlodBuleHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return GlodBuleHTNewsHomeCell.xHTNewsHomeCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    GlodBuleHTNewsModel *newsModel = self.newsList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    if (self.xClickHander) {
        self.xClickHander(indexPath.row);
    }
//    GlodBuleHTNewsDetailViewController *detailVc = [GlodBuleHTNewsDetailViewController taoviewController];
//    detailVc.post_id = newsModel.news_id;
    //[self.navigationController pushViewController:detailVc animated:YES];
}

@end
