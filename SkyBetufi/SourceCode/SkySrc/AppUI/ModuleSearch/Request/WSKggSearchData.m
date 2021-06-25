//
//  WSKggSearchData.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/9.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "WSKggSearchData.h"
#import "KSasxHTNewsHomeCell.h"
#import "NSNiceHTNewsDetailViewController.h"
#import "YeYeeBJError.h"
#import "BlysaSearchRequest.h"

@interface WSKggSearchData()

@end

@implementation WSKggSearchData

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
    
    KSasxHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsHomeCell"];
    [cell taosetupWithNewsModel:self.newsList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UUaksHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return KSasxHTNewsHomeCell.xHTNewsHomeCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UUaksHTNewsModel *newsModel = self.newsList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    if (self.xClickHander) {
        self.xClickHander(indexPath.row);
    }
//    NSNiceHTNewsDetailViewController *detailVc = [NSNiceHTNewsDetailViewController taoviewController];
//    detailVc.post_id = newsModel.news_id;
    //[self.navigationController pushViewController:detailVc animated:YES];
}

@end
