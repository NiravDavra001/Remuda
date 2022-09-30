//
//  FilterCategoryTableViewCell.swift
//  remuda
//
//  Created by Macmini on 08/06/21.
//


import UIKit

enum FiltertypeEnum{
    case breed(Breed)
    case discipline(Discipline)
}
protocol FilterCategoryTableViewCellDelegate{
    func checkBoxButtonAction(indexPath: IndexPath)
}
class FilterCategoryTableViewCell: UITableViewCell {
    @IBOutlet var leadingConstarint: NSLayoutConstraint!
    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var lblFilterValue: UILabel!
    var indexPath = IndexPath()
    var delegate: FilterCategoryTableViewCellDelegate?
    var cellBreed: Breed?{
        didSet{
            btnCheck.isSelected = cellBreed?.isSelected ?? false
            lblFilterValue.text = cellBreed?.value
        }
    }
    var cellDiscipline: Discipline?{
        didSet{
            btnCheck.isSelected = cellDiscipline?.isSelected ?? false
            lblFilterValue.text = cellDiscipline?.value
        }
    }
    var cellColor: Color?{
        didSet{
            btnCheck.isSelected = cellColor?.isSelected ?? false
            lblFilterValue.text = cellColor?.value
        }
    }
    var cellGender: Gender?{
        didSet{
            btnCheck.isSelected = cellGender?.isSelected ?? false
            lblFilterValue.text = cellGender?.value
        }
    }
    var cellCondition: Condition?{
        didSet{
            btnCheck.isSelected = cellCondition?.isSelected ?? false
            lblFilterValue.text = cellCondition?.value
        }
    }
    var cellTackCondition: TackCondition?{
        didSet{
            btnCheck.isSelected = cellTackCondition?.isSelected ?? false
            lblFilterValue.text = cellTackCondition?.value
        }
    }
    var cellTackSaddles: Saddle?{
        didSet{
            btnCheck.isSelected = cellTackSaddles?.isSelected ?? false
            lblFilterValue.text = cellTackSaddles?.value
        }
    }
    var cellTackType: Type?{
        didSet{
            btnCheck.isSelected = cellTackType?.isSelected ?? false
            lblFilterValue.text = cellTackType?.value
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setUpUI()
    }
    
    func setUpUI(){
        lblFilterValue.font = UIFont(name: FontName.SemiBold.rawValue, size: setFontSizeAsPerDeviceHeight(currentSize: .Size_16))
    }
    
    @IBAction func checkBoxButtonAction(_ sender: UIButton){
        self.btnCheck.isSelected = !(self.btnCheck.isSelected)
        delegate?.checkBoxButtonAction(indexPath: self.indexPath)
    }
}
