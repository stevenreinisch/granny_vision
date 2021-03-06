//
//  PNPresenceEvent.h
//  pubnub
//
//  Object which is used to describe concrete
//  presence event which arrived from PubNub
//  services.
//
//
//  Created by Sergey Mamontov.
//
//

@import Foundation;
#import "PNStructures.h"


#pragma mark Class forward

@class PNClient;


@interface PNPresenceEvent : NSObject


#pragma mark - Properties

// Stores reference on presence event type
@property (nonatomic, readonly, assign) PNPresenceEventType type;

// Stores reference on presence occurrence
// date
@property (nonatomic, readonly, strong) PNDate *date;

/**
 Stores reference on client for which presence event has been generated.
 */
@property (nonatomic, readonly, strong) PNClient *client;

// Stores reference on number of persons in channel
// on which this event is occurred
@property (nonatomic, readonly, assign) NSUInteger occupancy;

// Stores reference on channel on which this event
// is fired
@property (nonatomic, readonly, assign) PNChannel *channel;

/**
 Stores reference on user identifier which is triggered presence event.

 Deprecated. Will be DISCARDED in 3.6.0.
 */
@property (nonatomic, readonly, copy) NSString *uuid DEPRECATED_MSG_ATTRIBUTE(" Use 'client.identifier' instead.");


#pragma mark - Class methods

/**
 * Will return event object which will describe 
 * what kind of presence event occurred and provide
 * all data from it to the user.
 * If multiple presence events will be found in
 * provided response this method will return array
 * of events.
 */
+ (id)presenceEventForResponse:(id)presenceResponse;

/**
 * Allow to check whether specified object is valid
 * presence event information object or not
 */
+ (BOOL)isPresenceEventObject:(NSDictionary *)event;


#pragma mark - Instance methods

/**
 * Initialize presence event instance from 
 * PubNub service response
 */
- (id)initWithResponse:(id)presenceResponse;

#pragma mark -


@end
