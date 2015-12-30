//
//  MessageController.m
//  Bonjour
//
//  Created by YURI_JOU on 15/12/23.
//  Copyright © 2015年 oenius. All rights reserved.
//

#import "MessageController.h"
#import "MAMultiConnectionManager.h"

@interface MessageController()
<
JSQMessagesCollectionViewDataSource,
JSQMessagesCollectionViewDelegateFlowLayout
>

@property(nonatomic, strong)NSMutableArray *messages;
@property (nonatomic, strong) MAMultiConnectionManager *manager;

@end

@implementation MessageController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor redColor];
  self.collectionView.backgroundColor = [UIColor orangeColor];
  
  self.messages = [@[] mutableCopy];
  self.manager = [[MAMultiConnectionManager alloc]initWithIdentifier:@"peanuts"];

  __weak typeof(self) weakSelf = self;
  self.manager.didRecivedMessage = ^(NSString *msg)
  {
    
    JSQMessage *message = [[JSQMessage alloc]initWithSenderId:@"12232" senderDisplayName:@"not me " date:[NSDate date] text:msg];
    [weakSelf.messages addObject:message];
    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf.collectionView reloadData];
      [weakSelf finishReceivingMessageAnimated:YES];
      [weakSelf finishSendingMessageAnimated:YES];
    });
  };
  
  [self.manager start];
}

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
  JSQMessage *message = [[JSQMessage alloc]initWithSenderId:senderId senderDisplayName:senderDisplayName date:[NSDate date] text:text];
  [self.messages addObject:message];
  [self.manager sendMessage:text completion:^(bool success) {
    
  }];
  [self finishSendingMessageAnimated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.messages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
  return cell;
}

- (NSString *)senderDisplayName
{
  return @"这是我";
}

- (NSString *)senderId
{
  return @"291818";
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return self.messages[indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

@end
