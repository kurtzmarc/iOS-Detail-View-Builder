//
//  DVB_DetailViewSingleValueDataManager.h
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 11/25/12.
//  Copyright 2012 Kurtz Consulting Services LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVB_DetailViewDataManager.h"

@interface DVB_DetailViewSingleValueDataManager : DVB_DetailViewDataManager

@property (nonatomic,strong) NSObject* object;

- (id)initWithInitialValue:(NSObject *) object;

@end
