//
//  NJKWebViewProgress.m
//
//  Created by Satoshi Aasano on 4/20/13.
//  Copyright (c) 2013 Satoshi Asano. All rights reserved.
//

#import "NJKWebViewProgress.h"

NSString *completeRPCURL = @"webviewprogressproxy:///complete";

const float NJKInitialProgressValue = 0.1f;
const float NJKInteractiveProgressValue = 0.5f;
const float NJKFinalProgressValue = 0.9f;

@implementation NJKWebViewProgress
{
    NSUInteger _loadingCount;
    NSUInteger _maxLoadCount;
    NSURL *_currentURL;
    BOOL _interactive;
}

- (id)init
{
    self = [super init];
    if (self) {
        _maxLoadCount = _loadingCount = 0;
        _interactive = NO;
    }
    return self;
}

- (void)startProgress
{
    if (_progress < NJKInitialProgressValue) {
        [self setProgress:NJKInitialProgressValue];
    }
}

- (void)incrementProgress
{
    float progress = self.progress;
    float maxProgress = _interactive ? NJKFinalProgressValue : NJKInteractiveProgressValue;
    float remainPercent = (float)_loadingCount / (float)_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self setProgress:progress];
}

- (void)completeProgress
{
    [self setProgress:1.0];
}

- (void)setProgress:(float)progress
{
    // progress should be incremental only
    if (progress > _progress || progress == 0) {
        _progress = progress;
        if ([_progressDelegate respondsToSelector:@selector(webViewProgress:updateProgress:)]) {
            [_progressDelegate webViewProgress:self updateProgress:progress];
        }
        if (_progressBlock) {
            _progressBlock(progress);
        }
    }
}

- (void)reset
{
    _maxLoadCount = _loadingCount = 0;
    _interactive = NO;
    [self setProgress:0.0];
}

#pragma mark -
#pragma mark UIWebViewDelegate



#pragma mark - 
#pragma mark Method Forwarding
// for future UIWebViewDelegate impl

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ( [super respondsToSelector:aSelector] )
        return YES;
    
    if ([self.webViewProxyDelegate respondsToSelector:aSelector])
        return YES;
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(!signature) {
        if([_webViewProxyDelegate respondsToSelector:selector]) {
            return [(NSObject *)_webViewProxyDelegate methodSignatureForSelector:selector];
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation*)invocation
{
    if ([_webViewProxyDelegate respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:_webViewProxyDelegate];
    }
}

@end
