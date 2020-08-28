class Gender < ActiveHash::Base
  self.data = [
    
    { id: 1, name: 'WOMEN' },
    { id: 2, name: 'MEN' },
    { id: 3, name: 'KIDS(lady)' },
    { id: 4, name: 'KIDS(boy)' },
    { id: 5, name: 'BABY' },

  ]
end