//
//  SearchData.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "SearchData.h"
#import "SkyBallHetiRedHTNewsHomeCell.h"
#import "SkyBallHetiRedHTNewsDetailViewController.h"
#import "SkyBallHetiRedBJError.h"
#import "SearchRequest.h"

@interface SearchData()

@end

@implementation SearchData

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
    
    SkyBallHetiRedHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTNewsHomeCell"];
    [cell waterSkysetupWithNewsModel:self.newsList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    SkyBallHetiRedHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    SkyBallHetiRedHTNewsModel *newsModel = self.newsList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    if (self.xClickHander) {
        self.xClickHander(indexPath.row);
    }
//    SkyBallHetiRedHTNewsDetailViewController *detailVc = [SkyBallHetiRedHTNewsDetailViewController waterSkyviewController];
//    detailVc.post_id = newsModel.news_id;
    //[self.navigationController pushViewController:detailVc animated:YES];
}

@end
