//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import <Foundation/Foundation.h>
#import "DVB_DetailViewDataManager.h"

@interface DVB_DetailViewObjectDataManager : DVB_DetailViewDataManager

@property (nonatomic,strong) NSObject* object;

- (id)initWithObject:(NSObject *) object;

@end
