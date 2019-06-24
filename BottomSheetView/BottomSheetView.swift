//
//  BottomSheetView.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/23.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import UIKit

enum SheetLevel{
    case top
    case middle
    case bottom
    
    var frame: CGRect {
        switch self {
        case .top:
            return CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100)
        case .middle:
            return CGRect.init(x: 0, y: UIScreen.main.bounds.height-300, width: UIScreen.main.bounds.width, height: 300)
        case .bottom:
            return CGRect.init(x: 0, y: UIScreen.main.bounds.height-120, width: UIScreen.main.bounds.width, height: 120)
        }
    }
}

protocol BottomSheetViewDelegate {
    func updateDataSource(offerings: [Offering])
}

final class BottomSheetView: UIView {
    var panGestureRecognizer: UIPanGestureRecognizer!
    var customDelegate: BottomSheetViewDelegate?
    private var tableView: UITableView? {
        didSet {
            tableView?.isScrollEnabled = false
        }
    }
    
    var sheetLevel: SheetLevel? = .bottom { // NOTION: ここの初期値とstoryboardで設定したheight constを一致させる（コードで書くかあ...w）
        didSet {
            guard let sheetLevel = sheetLevel else { return }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: { [weak self] in
                self?.frame = sheetLevel.frame
            })
        }
    }
    
    var offerings: [Offering] = [] {
        didSet {
            customDelegate?.updateDataSource(offerings: offerings)
            sheetLevel = .middle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        panGestureRecognizer = .init(target: self, action: #selector(handlePanGesture(sender:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
    }
    
    func inject(tableView: UITableView) {
        self.tableView = tableView
    }
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self) // 移動量を取得
        let velocity = sender.velocity(in: self)
        let y = frame.minY
        
        switch sender.state {
        case .changed:
            if SheetLevel.bottom.frame.minY >= y + translation.y && SheetLevel.top.frame.minY <= y + translation.y {
                frame = .init(x: 0, y: y + translation.y, width: frame.width, height: frame.height-translation.y) // 移動量をフレームにsetする
                sender.setTranslation(.zero, in: self) // 移動量をリセットする
            }
        case .ended:
            if velocity.y >= 0 { // SWIPE DOWN
                if sheetLevel == .top {
                    sheetLevel = .middle
                } else if sheetLevel == .middle {
                    sheetLevel = .bottom
                }
            } else {  // SWIPE UP
                if sheetLevel == .bottom {
                    sheetLevel = .middle
                } else if sheetLevel == .middle {
                    sheetLevel = .top
                }
            }
            self.tableView?.isScrollEnabled = true
        default:
            break
        }
    }
}

extension BottomSheetView: UIGestureRecognizerDelegate {
    /// scrollViewをスクロールできるようにするか否や判断するための処理
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let tableView = tableView, let gesture = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        let direction = gesture.velocity(in: self).y
        if frame.height < SheetLevel.top.frame.height || (frame == SheetLevel.top.frame && tableView.contentOffset.y == 0 && direction > 0 ) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
        return false
    }
}

