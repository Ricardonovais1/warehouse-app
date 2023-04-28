Warehouse.create!(name: 'Rio2', 
                  code: 'SDY', 
                  city: 'Rio de Janeiro', 
                  area: 60_000,
                  address: 'Av. do Porto, 1000', 
                  cep: '20000-000', 
                  description: 'Galpão do Rio')
Warehouse.create!(name: 'Maceió2', 
                  code: 'MCY', 
                  city: 'Maceió', 
                  area: 50_000,
                  address: 'Av. Atlântia, 2000', 
                  cep: '80000-000', 
                  description: 'Galpão de Maceió')

x = Supplier.create!(corporate_name: 'Apple Computers', 
                     brand_name: 'Apple', 
                     registration_number: '1749879899919', 
                     full_address: 'Av. Estados Unidos, 1987',
                     city: 'São Paulo', 
                     state: 'SP', 
                     email: 'sac@apple.com')
ProductModel.create!(name:'TV 32', 
                     weight: 8000, 
                     width: 70, 
                     height: 45, 
                     depth: 10, sku: 'TV3234-APPLE-XPTO900', supplier: x)
ProductModel.create!(name:'Soundbar 7.1 Sorround', 
                     weight: 3000, 
                     width: 80, 
                     height: 15, 
                     depth: 20, 
                     sku: 'SOU713-SAMSU-NOIZ777', 
                     supplier: x)