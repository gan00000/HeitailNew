#ifndef BJAPIAddress_h
#define BJAPIAddress_h
#import "GlodBuleBJServiceConfigurator.h"
#pragma mark - 比賽
#define API_MATCH_HOME                  @"api/get_game_schedule"
#define API_MATCH_PROGRESS              @"api/get_match_progress"
#define API_MATCH_LIVE_FEED             @"api/get_live_feed"
#define API_MATCH_SUMMARY               @"api/get_match_summary"
#define API_MATCH_LIVE_POST               @"api/get_live_post_from_game"
#define API_MATCH_LIVE_POST_GAME               @"api/get_live_post_from_game"
#define API_MATCH_LIKE_MATCH_TEAM               @"api/like_match_team"
#define API_MATCH_PLAYER_INFO               @"api/get_player_match_summary"
#define API_MATCH_LIVE_FEED_PAGING           @"api/get_live_feed_paging"
#define API_MATCH_GET_SHOOT_POINT           @"api/get_shootpoint"
#define API_MATCH_GET_highlights    @"/api/get_highlights"


#pragma mark - 新聞
#define API_NEWS_HOME                   @"news"
#define API_NEWS_BANNER                 @"?json=get_app_index"
#define API_NEWS_TOP                    @"api/get_top_posts"
#define API_NEWS_CONTENT                @"news/%@.html"
#define API_NEWS_DETAIL                 @"api/get_post"
#define API_NEWS_COMMENTS               @"api/get_post_comments" 
#define API_NEWS_HOT_COMMENT            @"api/get_post_hot_comments" 
#define API_NEWS_ALL_COMMENT            @"api/get_post_all_comments" 
#pragma mark - 影片
#define API_FILM_HOME                   @"highlight"
#pragma mark - 数据
#define API_PLAYER_RANK                 @"api/get_player_rank"
#define API_PLAYER_RANK_ALL             @"api/get_player_rank_all"
#define API_TEAM_RANK                   @"api/get_team_rank"
#define API_TEAM_RANK_ALL               @"api/get_team_rank_all"
#pragma mark - 排行
#define API_RANK_EAST_WEST              @"api/get_east_west_rank"
#define API_RANK_ZONE                   @"api/get_zone_rank"
#pragma mark - 我的
#define API_USER_LOGIN                  @"api/app_login"
#define API_USER_INFO                   @"api/get_profile"
#define API_USER_UPDATE                 @"api/change_profile"
#define API_USER_SAVE_LIST              @"api/get_saved_post" 
#define API_USER_SAVE_ADD               @"api/save_post" 
#define API_USER_UNSAVE                 @"api/delete_saved_post" 
#define API_USER_HISTORY_LIST           @"api/get_history" 
#define API_USER_HISTORY_ADD            @"api/save_history" 
#define API_USER_MY_COMMENT             @"api/get_my_comment" 
#define API_USER_MY_LIKE                @"api/get_my_like" 
#define API_USER_MESSAGE_COUNT          @"api/get_notify_counter" 
#define API_USER_MESSAGE_LIST           @"api/get_my_notify" 
#define API_USER_POST_COMMENT           @"api/save_post_comments" 
#define API_USER_LIKE_ADD               @"api/save_comment_like"

#define API_SEARCH             @"api/get_search_results"
#endif
