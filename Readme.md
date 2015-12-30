# What the multi connection manager do

This more like a demo on how to use muti connection feature base on iOS 7.

However this repo, will also provide the neccessory interface in chat app.

###How to use

```

    // new manager
    self.manager = [[MAMultiConnectionManager alloc]initWithIdentifier:@"peanuts"];
    
    // handle receive message block
    [self.manager.didRecivedMessage = ^(NSString *msg){
    }];

    // send message
    [self.manager sendMessage:text completion:^(bool success) {
    }];

```
