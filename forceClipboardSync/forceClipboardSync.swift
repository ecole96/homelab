#!/usr/bin/swift

import Foundation
import AppKit

let pasteboard = NSPasteboard.general
var lastChangeCount = pasteboard.changeCount
var lastClipboardData: [[String: Data]]?

func refreshClipboard(with items: [NSPasteboardItem]) {
    var newItems: [NSPasteboardItem] = []

    for item in items {
        let newItem = NSPasteboardItem()
        for type in item.types {
            if let data = item.data(forType: type) {
                newItem.setData(data, forType: type)
            }
        }
        newItems.append(newItem)
    }

    pasteboard.clearContents()
    pasteboard.writeObjects(newItems)
    print("Clipboard refreshed at \(Date())")
}

// Convert pasteboard items to a comparable structure
func clipboardSnapshot(_ items: [NSPasteboardItem]) -> [[String: Data]] {
    return items.map { item in
        var dict: [String: Data] = [:]
        for type in item.types {
            if let data = item.data(forType: type) {
                dict[type.rawValue] = data
            }
        }
        return dict
    }
}

// Timer to poll clipboard every 0.5 seconds
Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
    if pasteboard.changeCount != lastChangeCount {
        lastChangeCount = pasteboard.changeCount
        
        guard let items = pasteboard.pasteboardItems, !items.isEmpty else { return }
        let snapshot = clipboardSnapshot(items)
        
        // Only refresh if clipboard content actually changed
        if lastClipboardData != snapshot {
            lastClipboardData = snapshot
            refreshClipboard(with: items)
        }
    }
}

// Keep the run loop alive indefinitely
RunLoop.main.run()