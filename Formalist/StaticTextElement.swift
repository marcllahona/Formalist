//
//  StaticTextElement.swift
//  Formalist
//
//  Created by Indragie Karunaratne on 2016-04-26.
//  Copyright © 2016 Seed Platform, Inc. All rights reserved.
//

import UIKit

/// An element used to display static text
public final class StaticTextElement: FormElement {
    public typealias ViewConfigurator = UILabel -> Void
    
    private let value: FormValue<String>
    private let viewConfigurator: ViewConfigurator?
    
    /**
     Designated initializer
     
     - parameter value:            The text value to bind to the label
     - parameter viewConfigurator: An optional block used to configure the label
     used to display the text
     
     - returns: An initialized instance of the receiver
     */
    public init(value: FormValue<String>, viewConfigurator: ViewConfigurator? = nil) {
        self.value = value
        self.viewConfigurator = viewConfigurator
    }
    
    /**
     Convenience initializer to initialize using a `String` rather than a
     `FormValue`.
     
     - parameter text:             The text to display in the label
     - parameter viewConfigurator: An optional block used to configure the label
     used to display the text
     
     - returns: An initialized instance of the receiver
     */
    public convenience init(text: String, viewConfigurator: ViewConfigurator? = nil) {
        self.init(value: FormValue(text), viewConfigurator: viewConfigurator)
    }
    
    public func render() -> UIView {
        let label = UILabel(frame: CGRectZero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        label.text = value.value
        value.addObserver { [weak label] in
            label?.text = $0
        }
        viewConfigurator?(label)
        return label
    }
}
