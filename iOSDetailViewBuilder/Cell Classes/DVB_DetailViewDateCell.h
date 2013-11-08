//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewItem.h"
#import <UIKit/UIKit.h>

@class DVB_DetailViewDataManager, DVB_DetailViewBuilder;

@interface DVB_DetailViewDateCell : DVB_DetailViewItem<UIActionSheetDelegate, UIPopoverControllerDelegate>{
    int _contentOffsetY;
}

@property (nonatomic, strong) UIPopoverController* popoverController;
@property (nonatomic, strong) UIActionSheet* actionSheet;
@property (nonatomic, strong) UIDatePicker* datePicker;

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder;

-(IBAction)datePickerDoneClick;

@end
