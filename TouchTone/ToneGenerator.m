//
//  ToneGenerator.m
//  TouchTone
//
//  Created by Binnur Al-Kazily on 6/5/19.
//  Copyright © 2019 Binnur Al-Kazily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchTone-Bridging-Header.h"


@implementation ToneGenerator : NSObject

- (void)start
{
    printf("Starting tone generation\n");
}

- (void)stop
{
    printf("Stopping tone generation\n");
}

@end


