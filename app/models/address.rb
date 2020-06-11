class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  
  validates :prefecture_id,:municipality,:address,presence: true
  validates :family_name,:first_name, presence: true,
            format:  {with: /\A[ぁ-んァ-ヶー一-龠]+\z/, message: "全角で入力してください"}   
  validates :family_name_kana, :first_name_kana, presence: true,
            format:  {with: /\A([ァ-ン]|ー)+/, message: "カタカナ以外の文字が入力されています"}   
  validates :zip_code, presence: true,
            format:  {with: /\A\d{7}\Z/, message:"ハイフンなしで７桁の数字を入力してください"}
            
end
