//
//  MAMultiConnectionManager.m
//  Bonjour
//
//  Created by YURI_JOU on 15/12/30.
//  Copyright © 2015年 oenius. All rights reserved.
//

#import "MAMultiConnectionManager.h"

#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface MAMultiConnectionManager()
<
MCNearbyServiceBrowserDelegate,
MCNearbyServiceAdvertiserDelegate,
MCSessionDelegate
>

@property (nonatomic, strong)MCPeerID *peerId;
@property (nonatomic, strong)MCSession *session;
@property (nonatomic, strong)MCNearbyServiceBrowser *browser;
@property (nonatomic, strong)MCNearbyServiceAdvertiser *advertiser;

@end

@implementation MAMultiConnectionManager

- (instancetype)initWithIdentifier:(NSString *)identifier
{
  
  self = [super init];
  if(self)
  {
    _peerId = [[MCPeerID alloc]initWithDisplayName:[UIDevice currentDevice].name];
    
    _advertiser = [[MCNearbyServiceAdvertiser alloc]initWithPeer:_peerId discoveryInfo:nil serviceType:identifier];
    _advertiser.delegate = self;
    _browser = [[MCNearbyServiceBrowser alloc]initWithPeer:_peerId serviceType:identifier];
    _browser.delegate = self;
    
    _session = [[MCSession alloc]initWithPeer:_peerId securityIdentity:nil encryptionPreference:MCEncryptionRequired];
    _session.delegate = self;
  }
  
  return self;
}

- (void)start
{
  [self.browser startBrowsingForPeers];
  [self.advertiser startAdvertisingPeer];
}

- (void)stop
{
  [self.browser stopBrowsingForPeers];
  [self.advertiser stopAdvertisingPeer];
}

- (void)sendMessage:(NSString *)text completion:(void(^)(bool))completion;
{
  if(self.session.connectedPeers.count > 0)
  {
    NSError *error;
    [self.session sendData:[text dataUsingEncoding:NSUTF8StringEncoding] toPeers:self.session.connectedPeers withMode:MCSessionSendDataReliable error:&error];
    error ? completion(NO) : completion(YES);
  }
  else
  {
    completion(NO);
  }
}

- (void)sendImage:(UIImage *)image completion:(void(^)(CGFloat))completion
{
  if(completion)completion(1);
}

- (void)dealloc
{
  [self stop];
}

#pragma mark - service delegate

- (void)browser:(MCNearbyServiceBrowser *)browser
      foundPeer:(MCPeerID *)peerID
  withDiscoveryInfo:(nullable NSDictionary<NSString *, NSString *> *)info
{
  [browser invitePeer:peerID toSession:self.session withContext:nil timeout:10];
}

// A nearby peer has stopped advertising.
- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{

}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser
    didReceiveInvitationFromPeer:(MCPeerID *)peerID
                      withContext:(nullable NSData *)context
                invitationHandler:(void (^)(BOOL accept, MCSession *session))invitationHandler
{
  invitationHandler(YES,self.session);
}

#pragma mark - session delegate

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state;
{

}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID;
{
  NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
  if(self.didRecivedMessage) self.didRecivedMessage(msg);
}

- (void) session:(MCSession *)session
   didReceiveStream:(NSInputStream *)stream
           withName:(NSString *)streamName
           fromPeer:(MCPeerID *)peerID;
{

}

- (void)                    session:(MCSession *)session
  didStartReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                       withProgress:(NSProgress *)progress;
{

}

- (void)                    session:(MCSession *)session
 didFinishReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                              atURL:(NSURL *)localURL
                          withError:(nullable NSError *)error;
{

}


@end
