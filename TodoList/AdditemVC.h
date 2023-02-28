//
//  AdditemVC.h
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Add_protocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface AdditemVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *item_name;
@property (weak, nonatomic) IBOutlet UITextField *item_desc;

@property (weak, nonatomic) IBOutlet UISegmentedControl *item_priority;

@property id<Add_protocol> p;
@end

NS_ASSUME_NONNULL_END
