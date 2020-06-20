class Size < ActiveHash::Base
  
  # self.data = [
  #   # 洋服のサイズ
  #   { id: 1, size: 'XXS以下', group: '1' },
  #   { id: 2, size: 'XS(SS)', group: '1' },
  #   { id: 3, size: 'S', group: '1' },
  #   { id: 4, size: 'M', group: '1' },
  #   { id: 5, size: 'L', group: '1' },
  #   { id: 6, size: 'XL(LL)', group: '1' },
  #   { id: 7, size: '2XL(3L)', group: '1' },
  #   { id: 8, size: '3XL(4L)', group: '1' },
  #   { id: 9, size: '4XL(5L)以上', group: '1' },
  #   { id: 10, size: 'FREE SIZE', group: '1' },

  #   # レディース靴のサイズ
  #   { id: 11, size: '20cm以下', group: '2' },
  #   { id: 12, size: '20.5cm', group: '2' },
  #   { id: 13, size: '21cm', group: '2' },
  #   { id: 14, size: '21.5cm', group: '2' },
  #   { id: 15, size: '22cm', group: '2' },
  #   { id: 16, size: '22.5cm', group: '2' },
  #   { id: 17, size: '23cm', group: '2' },
  #   { id: 18, size: '23.5cm', group: '2' },
  #   { id: 19, size: '24cm', group: '2' },
  #   { id: 20, size: '24.5cm', group: '2' },
  #   { id: 21, size: '25cm', group: '2' },
  #   { id: 22, size: '25.5cm', group: '2' },
  #   { id: 23, size: '26cm', group: '2' },
  #   { id: 24, size: '26.5cm', group: '2' },
  #   { id: 25, size: '27cm', group: '2' },
  #   { id: 26, size: '27.5cm以上', group: '2' },

  #   # メンズ靴のサイズ
  #   { id: 27, size: '23.5cm以下', group: '3' },
  #   { id: 28, size: '24cm', group: '3' },
  #   { id: 29, size: '24.5cm', group: '3' },
  #   { id: 30, size: '25cm', group: '3' },
  #   { id: 31, size: '25.5cm', group: '3' },
  #   { id: 32, size: '26cm', group: '3' },
  #   { id: 33, size: '26.5cm', group: '3' },
  #   { id: 34, size: '27cm', group: '3' },
  #   { id: 35, size: '27.5cm', group: '3' },
  #   { id: 36, size: '28cm', group: '3' },
  #   { id: 37, size: '28.5cm', group: '3' },
  #   { id: 38, size: '29cm', group: '3' },
  #   { id: 39, size: '29.5cm', group: '3' },
  #   { id: 40, size: '30cm', group: '3' },
  #   { id: 41, size: '30.5cm', group: '3' },
  #   { id: 42, size: '31cm以上', group: '3' },

  #   # スカートのサイズ
  #   { id: 43, size: '60cm以下', group: '4' },
  #   { id: 44, size: '~70cm', group: '4' },
  #   { id: 45, size: '~80cm', group: '4' },
  #   { id: 46, size: '~90cm', group: '4' },
  #   { id: 47, size: '90cm以上', group: '4' },

  #   # キッズ服のサイズ
  #   { id: 48, size: '100cm', group: '5' },
  #   { id: 49, size: '110cm', group: '5' },
  #   { id: 50, size: '120cm', group: '5' },
  #   { id: 51, size: '130cm', group: '5' },
  #   { id: 52, size: '140cm', group: '5' },
  #   { id: 53, size: '150cm', group: '5' },
  #   { id: 54, size: '160cm', group: '5' },

  #   # ベビー・キッズ靴のサイズ
  #   { id: 55, size: '10.5cm以下', group: '6' },
  #   { id: 56, size: '11cm・11.5cm', group: '6' },
  #   { id: 57, size: '12cm・12.5cm', group: '6' },
  #   { id: 58, size: '13cm・13.5cm', group: '6' },
  #   { id: 59, size: '14cm・14.5cm', group: '6' },
  #   { id: 60, size: '15cm・15.5cm', group: '6' },
  #   { id: 61, size: '16cm・16.5cm', group: '6' },
  #   { id: 62, size: '17cm以上', group: '6' },

  #   # ベビー服のサイズ
  #   { id: 63, size: '60cm', group: '7' },
  #   { id: 64, size: '70cm', group: '7' },
  #   { id: 65, size: '80cm', group: '7' },
  #   { id: 66, size: '90cm', group: '7' },
  #   { id: 67, size: '95cm', group: '7' },

  #   # 必須項目のため空のバリューを用意
  #   { id: 99, size: '', group: '' }
  # ]
end