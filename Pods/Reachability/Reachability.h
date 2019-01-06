#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif
extern NSString *const kReachabilityChangedNotification;
typedef NS_ENUM(NSInteger, NetworkStatus) {
    NotReachable = 0,
    ReachableViaWiFi = 2,
    ReachableViaWWAN = 1
};
@class Reachability;
typedef void (^NetworkReachable)(Reachability * reachability);
typedef void (^NetworkUnreachable)(Reachability * reachability);
@interface Reachability : NSObject
@property (nonatomic, copy) NetworkReachable    reachableBlock;
@property (nonatomic, copy) NetworkUnreachable  unreachableBlock;
@property (nonatomic, assign) BOOL reachableOnWWAN;
+(Reachability*)reachabilityWithHostname:(NSString*)hostname;
+(Reachability*)reachabilityWithHostName:(NSString*)hostname;
+(Reachability*)reachabilityForInternetConnection;
+(Reachability*)reachabilityWithAddress:(void *)hostAddress;
+(Reachability*)reachabilityForLocalWiFi;
-(Reachability *)initWithReachabilityRef:(SCNetworkReachabilityRef)ref;
-(BOOL)startNotifier;
-(void)stopNotifier;
-(BOOL)isReachable;
-(BOOL)isReachableViaWWAN;
-(BOOL)isReachableViaWiFi;
-(BOOL)isConnectionRequired; 
-(BOOL)connectionRequired; 
-(BOOL)isConnectionOnDemand;
-(BOOL)isInterventionRequired;
-(NetworkStatus)currentReachabilityStatus;
-(SCNetworkReachabilityFlags)reachabilityFlags;
-(NSString*)currentReachabilityString;
-(NSString*)currentReachabilityFlags;
@end
