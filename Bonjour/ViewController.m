//
//  ViewController.m
//  Bonjour
//
//  Created by YURI_JOU on 15/12/23.
//  Copyright © 2015年 oenius. All rights reserved.
//

#import "ViewController.h"
#import "MessageController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface ViewController ()
<
MCNearbyServiceAdvertiserDelegate,
MCSessionDelegate
>

@property(nonatomic, strong)MCSession *session;
@property (nonatomic, strong)MCNearbyServiceAdvertiser *advertiser;
@property (nonatomic, strong) MCPeerID *peerId;


@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  MCPeerID *peerId = [[MCPeerID alloc]initWithDisplayName:[UIDevice currentDevice].name];
  
  self.advertiser = [[MCNearbyServiceAdvertiser alloc]initWithPeer:peerId discoveryInfo:nil serviceType:@"example"];
  self.advertiser.delegate = self;
  [self.advertiser startAdvertisingPeer];
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(50, 50, 100, 80);
  [button setTitle:@"click me" forState:UIControlStateNormal];
  [button setBackgroundColor:[UIColor orangeColor]];
  [button addTarget:self action:@selector(handleClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (MCSession *)session
{
  if(!_session)
  {
    MCPeerID *peerId = [[MCPeerID alloc]initWithDisplayName:[UIDevice currentDevice].name];
    _session = [[MCSession alloc]initWithPeer:peerId securityIdentity:nil encryptionPreference:MCEncryptionRequired];
    _session.delegate = self;
  }
  return _session;
}

- (void)handleClick
{
  if(self.session.connectedPeers.count > 0)
  {
    
    [self.session sendData:[@"lallala" dataUsingEncoding:NSUTF8StringEncoding] toPeers:self.session.connectedPeers withMode:MCSessionSendDataReliable error:nil];
  }
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error
{

}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession * _Nonnull))invitationHandler
{

  invitationHandler(YES,self.session);
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
  
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
  
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
  
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
  NSLog(@"Data__%@",data);
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{

}

- (void) session:(MCSession *)session didReceiveCertificate:(NSArray *)certificate fromPeer:(MCPeerID *)peerID certificateHandler:(void (^)(BOOL accept))certificateHandler
{
  certificateHandler(YES);
}

@end
