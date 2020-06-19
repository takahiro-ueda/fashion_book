class Brand < ActiveHash::Base
  self.data = [
    
    { id: 1, name: 'UNIQLO(ユニクロ)' },
    { id: 2, name: 'GU(ジーユー)' },
    { id: 3, name: 'CONVERSE(コンバース)' },
    { id: 4, name: 'NIKE(ナイキ)' },
    { id: 5, name: 'ZARA(ザラ)' },
    { id: 6, name: 'WEGO(ウィゴー)' },
    { id: 7, name: 'H&M(エイチ・アンド・エム)' },
    { id: 8, name: 'no brand(ノー・ブランド)' },
    { id: 9, name: 'adidas(アディダス)' },
    { id: 10, name: 'HYSTERIC GLAMOUR(ヒステリックグラマー)' },
    

    # 必須項目のため空のバリューを用意
    { id: 99, name: '', group: '' }
  ]
end