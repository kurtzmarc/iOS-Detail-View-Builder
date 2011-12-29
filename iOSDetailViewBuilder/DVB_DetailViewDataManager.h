//
//  DVB_DetailViewDataManager.h
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

@class DVB_DetailViewItem;

@interface DVB_DetailViewDataManager : NSObject

-(NSObject *)getValue:(DVB_DetailViewItem*) item;
-(void)setValue:(NSObject *)value forItem:(DVB_DetailViewItem*) item;

@end
