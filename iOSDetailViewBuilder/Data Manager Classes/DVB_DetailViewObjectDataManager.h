//
//  DVB_DetailViewObjectItem.h
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVB_DetailViewDataManager.h"

@interface DVB_DetailViewObjectDataManager : DVB_DetailViewDataManager

@property (nonatomic,strong) NSObject* object;

- (id)initWithObject:(NSObject *) object;

@end
