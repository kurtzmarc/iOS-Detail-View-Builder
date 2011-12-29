//
//  DVB_DetailViewObjectItem.h
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewDataManager.h"

@interface DetailViewObjectDataManager : DetailViewDataManager

@property (nonatomic,strong) NSObject* object;

- (id)initWithObject:(NSObject *) object;

@end
