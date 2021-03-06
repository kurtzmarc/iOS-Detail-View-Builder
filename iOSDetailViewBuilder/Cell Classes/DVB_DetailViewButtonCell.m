//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewButtonCell.h"
#import "DVB_DetailView.h"

@implementation DVB_DetailViewButtonCell

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder
{
    self = [super initWithLabel:labelString withDataManager:dataManager withKey:key withController:controller withBuilder:builder];
    if (self) {
        //
    }
    return self;
}

- (NSString*)cellIdentifier
{
    return @"BuilderButtonCell";
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    cell.textLabel.text = self.label;
    [super configureCell:cell];
}

- (void) requestEndEditing
{
    // Do nothing...
}

@end
