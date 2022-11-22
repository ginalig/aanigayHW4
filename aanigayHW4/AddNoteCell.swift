//
//  AddNoteCell.swift
//  aanigayHW4
//
//  Created by Сашка Нигай on 22.11.2022.
//

import Foundation

import UIKit
final class AddNoteCell: UITableViewCell {
    var delegate: AddNoteDelegate?
    static let reuseIdentifier = "AddNoteCell"
    let placeHolder = "Input text:"
    var isPlaceholder = true
    private var textView = UITextView()
    public var addButton = UIButton()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        textView.delegate = self
        textView.text = placeHolder
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = UIColor.lightGray
        textView.backgroundColor = .clear
        textView.setHeight(140)
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)),
                            for: .touchUpInside)
        addButton.isEnabled = false
        addButton.alpha = 0.5
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        delegate?.newNoteAdded(note: ShortNote(text: textView.text))
        textView.text = placeHolder
        textView.textColor = UIColor.lightGray
        addButton.alpha = 0.3
        addButton.isEnabled = false
        isPlaceholder = true
    }
    //func numberOfSections(in tableView: UITableView) -> Int { }
}
extension AddNoteCell: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        if (textView.text.isEmpty || isPlaceholder) {
            addButton.alpha = 0.3
            addButton.isEnabled = false
        } else {
            addButton.alpha = 1
            addButton.isEnabled = true
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
//            addButton.alpha = 0.3
//            addButton.isEnabled = false
            isPlaceholder = false
        }
    }
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //        if textView.text.isEmpty {
    //            textView.text = placeHolder
    //            textView.textColor = UIColor.lightGray
    //            addButton.alpha = 1
    //            addButton.isEnabled = true
    //        }
    //    }
}
