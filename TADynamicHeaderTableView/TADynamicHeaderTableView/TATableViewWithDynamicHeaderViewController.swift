//
//  TATableViewWithDynamicHeaderViewController.swift
//  TADynamicHeaderTableView
//
//  Created by The New Macbook on 9/17/18.
//  Copyright © 2018 FPT. All rights reserved.
//

import UIKit

class TATableViewWithDynamicHeaderViewController: UIViewController {

    // MARK: Outlet
    private var taContentTableView: UITableView!
    private var taHeaderHeightConstraint: NSLayoutConstraint!
    
    // MARK: Propertise
    private var maxHeaderHeight: CGFloat = 88
    private var minHeaderHeight: CGFloat = 44
    private var previousScrollOffset: CGFloat = 0.0
    
    // MARK: Life Cycle
    
    // MARK: Method
    func setupWithHeaderHeight(maxHeight: Int, minHeight: Int, contentTable: UITableView, headerHeightConstraint: NSLayoutConstraint) {
        
        self.taContentTableView = contentTable
//        self.tbContent.dataSource = self
        self.taContentTableView.delegate = self
        self.taHeaderHeightConstraint = headerHeightConstraint
        
        // ...
        self.maxHeaderHeight = CGFloat(maxHeight)
        self.minHeaderHeight = CGFloat(minHeight)
        
        self.taHeaderHeightConstraint.constant = self.maxHeaderHeight
    }
    
    // MARK: Action
}

extension TATableViewWithDynamicHeaderViewController:  UITableViewDelegate {
    
    // ...
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        // ...
        
        if canAnimateHeader(scrollView) {
            var newHeight = self.taHeaderHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.taHeaderHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, self.taHeaderHeightConstraint.constant + abs(scrollDiff))
            }
            
            if newHeight != self.taHeaderHeightConstraint.constant {
                self.taHeaderHeightConstraint.constant = newHeight
                self.setScrollPosition(position: self.previousScrollOffset)
            }
        }
        // ...
        
        self.previousScrollOffset = scrollView.contentOffset.y
    }
    
    // ...
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }
    
    // ...
    func scrollViewDidStopScrolling() {
        let rage = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (rage / 2)
        
        if self.taHeaderHeightConstraint.constant > midPoint {
            // expand header
            self.expandHeader()
        } else {
            // collapse header
            self.collapseHeader()
        }
    }
    
    // ...
    func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.taHeaderHeightConstraint.constant = self.minHeaderHeight
            self.view.layoutIfNeeded()
        }
    }
    
    // ...
    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.taHeaderHeightConstraint.constant = self.maxHeaderHeight
            self.view.layoutIfNeeded()
        }
    }
    
    // ...
    private func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        
        // calculate the size of the scrollview when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + self.taHeaderHeightConstraint.constant - minHeaderHeight
        
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    // ...
    private func setScrollPosition(position: CGFloat) {
        
        self.taContentTableView.contentOffset = CGPoint(x: self.taContentTableView.contentOffset.x, y: position)
    }
    
    // ...
//    func updateHeader() {
//        let range = self.maxHeaderHeight - self.minHeaderHeight
//        let openAmount = self.headerHeightConstraint.constant - self.minHeaderHeight
//        let percentage = openAmount / range
//
//
//
//
//    }
}
