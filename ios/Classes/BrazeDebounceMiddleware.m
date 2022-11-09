//
//  BrazeDebounceMiddleware.m
//  SegmentBrazeDebounce-iOS
//
//  Created by Brandon Sneed on 11/4/19.
//  Copyright © 2019 Brandon Sneed. All rights reserved.
//

#import "BrazeDebounceMiddleware.h"

const NSString *__brazeIntegrationName = @"Appboy";

@interface BrazeDebounceMiddleware()
@property (nonatomic, strong) SEGIdentifyPayload *previousIdentifyPayload;
@end

@implementation BrazeDebounceMiddleware

- (id)init {
    self = [super init];
    self.previousIdentifyPayload = nil;
    return self;
}

- (void)context:(SEGContext * _Nonnull)context next:(SEGMiddlewareNext _Nonnull)next {
    SEGContext *workingContext = context;
    
    SEGIdentifyPayload *identify = nil;
    if ([workingContext.payload isKindOfClass:[SEGIdentifyPayload class]]) {
        identify = (SEGIdentifyPayload *)workingContext.payload;
        if (identify != nil) {
            if ([self shouldSendToBraze:identify]) {
                // we don't need to do anything, it's different content.
            } else {
                // append to integrations such that this will not be sent to braze.
                NSMutableDictionary<NSString *, id> *integrations = [[NSMutableDictionary alloc] init];
                if (identify.integrations != nil) {
                    integrations = [identify.integrations mutableCopy];
                }
                integrations[__brazeIntegrationName] = [NSNumber numberWithBool:NO];
                // provide the list of integrations to a new copy of the payload to pass along.
                workingContext = [workingContext modify:^(id<SEGMutableContext>  _Nonnull ctx) {
                    ctx.payload = [[SEGIdentifyPayload alloc] initWithUserId:identify.userId
                                                                 anonymousId:identify.anonymousId
                                                                      traits:identify.traits
                                                                     context:identify.context
                                                                integrations:integrations];
                }];
            }
        }
    }
    
    self.previousIdentifyPayload = identify;
    next(workingContext);
}

- (BOOL)shouldSendToBraze:(SEGIdentifyPayload *)payload {
    // if userID has changed, send it to braze.
    if (payload.userId != self.previousIdentifyPayload.userId) {
        return true;
    }
    
    // if anonymousID has changed, send it to braze.
    if (payload.anonymousId != self.previousIdentifyPayload.anonymousId) {
        return true;
    }
    
    // if the traits are equal and haven't changed, don't send it to braze.
    if ([self traitsEqual:payload.traits rhs:self.previousIdentifyPayload.traits]) {
        return false;
    }
    
    return true;
}

- (BOOL)traitsEqual:(NSDictionary *)lhs rhs:(NSDictionary *)rhs {
    BOOL result = false;
    if (lhs == nil && rhs == nil) {
        result = true;
    }
    
    if (lhs != nil && rhs != nil) {
        result = [lhs isEqualToDictionary:rhs];
    }
    
    return result;
}

@end