//
//  NotificationBannerUtils.swift
//  Nomad
//
//  Created by Mohammed Safwat on 26.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import SwiftMessages

class NotificationBannerUtils {
    class func showNotifiationBanner(layout: MessageView.Layout, theme: Theme, iconStyle: IconStyle, title: String, content: String) {
        let view = MessageView.viewFromNib(layout: layout)
        view.configureTheme(theme, iconStyle: iconStyle)
        view.configureContent(title: title, body: content)
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }
}
