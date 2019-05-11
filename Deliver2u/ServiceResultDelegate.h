//
//  Header.h
//  xiaokeyou
//
//  Created by BoHuang on 3/3/17.
//  Copyright © 2017 Songu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceResultDelegate <NSObject>

-(void) result:(int) code;

@end
