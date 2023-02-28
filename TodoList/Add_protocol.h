//
//  Add_protocol.h
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import <Foundation/Foundation.h>
#import "Todoitem.h"
NS_ASSUME_NONNULL_BEGIN

@protocol Add_protocol <NSObject>

-(void)add:(Todoitem*) item;

@end

NS_ASSUME_NONNULL_END
