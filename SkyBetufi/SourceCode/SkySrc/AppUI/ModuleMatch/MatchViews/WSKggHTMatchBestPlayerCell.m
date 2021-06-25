#import "WSKggHTMatchBestPlayerCell.h"
#import "TuTuosBarChartUtil.h"

@interface WSKggHTMatchBestPlayerCell ()
@property (weak, nonatomic) IBOutlet UILabel *homePtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *homePtsPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homePtsPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebPlaceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *ptsAwayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ptsHomeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rebHomeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rebAwayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *astHomeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *astAwayImageView;

@property (weak, nonatomic) IBOutlet BarChartView *ptsBarChart;
@property (weak, nonatomic) IBOutlet BarChartView *rebBarChart;
@property (weak, nonatomic) IBOutlet BarChartView *astBarChart;

@property (nonatomic,strong)TuTuosBarChartUtil *ptsBarChartUtil;
@property (nonatomic,strong)TuTuosBarChartUtil *rebBarChartUtil;
@property (nonatomic,strong)TuTuosBarChartUtil *astBarChartUtil;


@end
@implementation WSKggHTMatchBestPlayerCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.ptsBarChartUtil = [[TuTuosBarChartUtil alloc] initWithChart:self.ptsBarChart];
    self.rebBarChartUtil = [[TuTuosBarChartUtil alloc] initWithChart:self.rebBarChart];
    self.astBarChartUtil = [[TuTuosBarChartUtil alloc] initWithChart:self.astBarChart];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taosetupWithMatchSummaryModel:(NSNiceHTMatchSummaryModel *)summaryModel {
    self.homePtsLabel.text = summaryModel.home_team_pts_most.pts.length > 0 ? summaryModel.home_team_pts_most.pts : @"0";
    self.homePtsPlayerLabel.text = summaryModel.home_team_pts_most.name.length > 0 ? summaryModel.home_team_pts_most.name : @"";
    self.homePtsPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_pts_most.position.length > 0?summaryModel.home_team_pts_most.position : @""];
    self.homeAstLabel.text = summaryModel.home_team_ast_most.ast.length > 0 ? summaryModel.home_team_ast_most.ast : @"0";
    self.homeAstPlayerLabel.text = summaryModel.home_team_ast_most.name.length > 0 ? summaryModel.home_team_ast_most.name : @"";
    self.homeAstPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_ast_most.position.length > 0 ? summaryModel.home_team_ast_most.position : @""];
    self.homeRebLabel.text = summaryModel.home_team_reb_most.reb.length > 0 ? summaryModel.home_team_reb_most.reb : @"0";
    self.homeRebPlayerLabel.text = summaryModel.home_team_reb_most.name.length > 0 ? summaryModel.home_team_reb_most.name : @"";
    self.homeRebPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_reb_most.position.length > 0 ? summaryModel.home_team_reb_most.position : @""];
    self.awayPtsLabel.text = summaryModel.away_team_pts_most.pts.length > 0 ? summaryModel.away_team_pts_most.pts : @"0";
    self.awayPtsPlayerLabel.text = summaryModel.away_team_pts_most.name.length > 0 ? summaryModel.away_team_pts_most.name : @"";
    self.awayPtsPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_pts_most.position.length > 0 ? summaryModel.away_team_pts_most.position : @""];
    self.awayAstLabel.text = summaryModel.away_team_ast_most.ast.length > 0 ? summaryModel.away_team_ast_most.ast : @"0";
    self.awayAstPlayerLabel.text = summaryModel.away_team_ast_most.name.length > 0 ? summaryModel.away_team_ast_most.name : @"";
    self.awayAstPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_ast_most.position.length > 0 ? summaryModel.away_team_ast_most.position : @""];
    self.awayRebLabel.text = summaryModel.away_team_reb_most.reb.length > 0 ? summaryModel.away_team_reb_most.reb : @"0";
    self.awayRebPlayerLabel.text = summaryModel.away_team_reb_most.name.length > 0 ? summaryModel.away_team_reb_most.name : @"";
    self.awayRebPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_reb_most.position.length ? summaryModel.away_team_reb_most.position : @""];
    
    [self.ptsAwayImageView th_setImageWithURL:summaryModel.away_team_pts_most.officialImagesrc placeholderImage:nil];
    [self.ptsHomeImageView th_setImageWithURL:summaryModel.home_team_pts_most.officialImagesrc placeholderImage:nil];
    
     [self.rebAwayImageView th_setImageWithURL:summaryModel.away_team_reb_most.officialImagesrc placeholderImage:nil];
     [self.rebHomeImageView th_setImageWithURL:summaryModel.home_team_reb_most.officialImagesrc placeholderImage:nil];
    
     [self.astAwayImageView th_setImageWithURL:summaryModel.away_team_ast_most.officialImagesrc placeholderImage:nil];
    [self.astHomeImageView th_setImageWithURL:summaryModel.home_team_ast_most.officialImagesrc placeholderImage:nil];
    
    int homePts = summaryModel.home_team_pts_most.pts.length > 0 ? [summaryModel.home_team_pts_most.pts intValue] : 0;
    int awayPts = summaryModel.away_team_pts_most.pts.length > 0 ? [summaryModel.away_team_pts_most.pts intValue] : 0;
    
    //得分
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    [yVals addObject:[[BarChartDataEntry alloc] initWithX:2 y:awayPts]];
    [yVals addObject:[[BarChartDataEntry alloc] initWithX:4 y:homePts]];
    [self.ptsBarChartUtil setData:yVals maxValue: awayPts > homePts ? awayPts:awayPts];
    
    //篮板
    int homeReb = summaryModel.home_team_reb_most.reb.length > 0 ? [summaryModel.home_team_reb_most.reb intValue] : 0;
    int awayReb = summaryModel.away_team_reb_most.reb.length > 0 ? [summaryModel.away_team_reb_most.reb intValue] : 0;
    NSMutableArray *reb_yVals = [[NSMutableArray alloc] init];
    [reb_yVals addObject:[[BarChartDataEntry alloc] initWithX:2 y:awayReb]];
    [reb_yVals addObject:[[BarChartDataEntry alloc] initWithX:4 y:homeReb]];
    [self.rebBarChartUtil setData:reb_yVals maxValue: awayReb > homeReb ? awayReb:homeReb];
    
    
    int homeAst = summaryModel.home_team_ast_most.ast.length > 0 ? [summaryModel.home_team_ast_most.ast intValue] : 0;
    int awayAst = summaryModel.away_team_ast_most.ast.length > 0 ? [summaryModel.away_team_ast_most.ast intValue] : 0;
    NSMutableArray *ast_yVals = [[NSMutableArray alloc] init];
       [ast_yVals addObject:[[BarChartDataEntry alloc] initWithX:2 y:awayAst]];
       [ast_yVals addObject:[[BarChartDataEntry alloc] initWithX:4 y:homeAst]];
       [self.astBarChartUtil setData:ast_yVals maxValue: awayAst > homeAst ? awayAst:homeAst];
    
}
@end
