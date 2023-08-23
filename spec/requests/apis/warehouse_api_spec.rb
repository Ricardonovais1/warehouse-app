require 'rails_helper'

describe 'Warehouse API' do 
  context 'GET /api/v1/warehouses/1' do
    it 'sucesso' do 
      # Arrange 
      warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                    address: 'Av. Atlântia, 2000', cep: '80000-000', 
                                    description: 'Galpão de Maceió')

      # Act
      get "/api/v1/warehouses/#{warehouse.id}"
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq 'Galpão Maceió'
      expect(json_response["code"]).to eq 'MCZ'
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'falso se warehouse não foi encontrado' do 
      # Arrange 

      # Act 
      get "/api/v1/warehouses/99999999"

      # Assert 
      expect(response.status). to eq 404
    end
  end

  context 'GET /api/v1/warehouses' do 
    it 'sucesso e ordenado por nome em ordem alfabética' do 
      # Arrange 
      warehouse_1 = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                    address: 'Av. Atlântia, 2000', cep: '80000-000', 
                                    description: 'Galpão de Maceió')
      warehouse_2 =  Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Av. do Porto, 1000', cep: '20000-000', 
                                    description: 'Galpão do Rio')
      # Act 
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200 
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq "Galpão Maceió"
      expect(json_response[0]["code"]).to eq "MCZ"
      expect(json_response[1]["name"]).to eq "Rio"
      expect(json_response[1]["code"]).to eq "SDU"
    end

    it 'retornar vazio se não houver galpão' do 
      # Arrange 

      # Act 
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

    it 'e raise erro interno' do 
      # Arrange 
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      warehouse_1 = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                      address: 'Av. Atlântia, 2000', cep: '80000-000', 
                                      description: 'Galpão de Maceió')
      warehouse_2 =  Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                      address: 'Av. do Porto, 1000', cep: '20000-000', 
                                      description: 'Galpão do Rio')
      # Act 
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 500 
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'com sucesso' do 
      warehouse_hash = { warehouse: { name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                      address: 'Av. do Porto, 1000', cep: '20000-000', 
                                      description: 'Galpão do Rio' }
                       } 

      post '/api/v1/warehouses', params: warehouse_hash

      expect(response.status).to eq 201
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq 'Rio'
      expect(json_response["code"]).to eq 'SDU'
      expect(json_response["city"]).to eq 'Rio de Janeiro'
      expect(json_response["area"]).to eq 60000
      expect(json_response["address"]).to eq 'Av. do Porto, 1000'
      expect(json_response["cep"]).to eq '20000-000'
      expect(json_response["description"]).to eq 'Galpão do Rio'
    end

    it 'Falha se parâmetros não forem completos' do
      # Arrange 
      # Payload:
      warehouse_params = { warehouse: { name: 'Aeroporto de Curitiba', code: 'CWB' }}

      # Act 
      post '/api/v1/warehouses', params: warehouse_params

      # Assert
      expect(response).to have_http_status(412)
      expect(response.body).not_to include 'Nome não pode ficar em branco'
      expect(response.body).not_to include 'Código não pode ficar em branco'
      expect(response.body).to include 'Cidade não pode ficar em branco'
      expect(response.body).to include 'Área não pode ficar em branco'
      expect(response.body).to include 'Endereço não pode ficar em branco'
      expect(response.body).to include 'CEP não pode ficar em branco'
      expect(response.body).to include 'Descrição não pode ficar em branco'
    end

    it 'falha se houver um erro interno' do 
      #mock => Rspec respondendo com um erro proposital para fins de teste:
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_hash = { warehouse: { name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                      address: 'Av. do Porto, 1000', cep: '20000-000', 
                                      description: 'Galpão do Rio' }
                        } 

      post '/api/v1/warehouses', params: warehouse_hash

      expect(response.status).to eq 500
    end
  end

  context 'PATCH /api/v1/warehouses/1' do 
    it 'edita o nome do galpão com sucesso' do 
      # Arrange 
      warehouse_original = { warehouse: {name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                        address: 'Av. do Porto, 1000', cep: '20000-000', 
                                        description: 'Galpão do Rio'} 
                            }
      post '/api/v1/warehouses', params: warehouse_original

      original_warehouse_id = JSON.parse(response.body)["id"]

      # Act 
      patch "/api/v1/warehouses/#{original_warehouse_id}", params: { warehouse: { name: 'Galpão Rio'} }

      # Assert
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq "Galpão Rio" 
    end

    it 'falha quando ocorre uma edição com valor em branco' do 
      # Arrange 
      warehouse_original = { warehouse: {name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                        address: 'Av. do Porto, 1000', cep: '20000-000', 
                                        description: 'Galpão do Rio'} 
                            }
      post '/api/v1/warehouses', params: warehouse_original
      original_warehouse_id = JSON.parse(response.body)["id"]

      # Act 
      patch "/api/v1/warehouses/#{original_warehouse_id}", params: { warehouse: { name: '' } }

      # Assert
      expect(response.status).to eq 412
      expect(response.body).to include 'Nome não pode ficar em branco'
      expect(response.body).not_to include 'Código não pode ficar em branco'
      expect(response.body).not_to include 'Cidade não pode ficar em branco'
      expect(response.body).not_to include 'Área não pode ficar em branco'
      expect(response.body).not_to include 'Endereço não pode ficar em branco'
      expect(response.body).not_to include 'CEP não pode ficar em branco'
      expect(response.body).not_to include 'Descrição não pode ficar em branco'
    end

    it 'falha se houver um erro interno' do 
      # Arrange 
      # allow_any_instance_of(Warehouse).to receive(:update).and_raise(ActiveRecord::ActiveRecordError)
      warehouse = instance_double(Warehouse)
      allow(Warehouse).to receive(:find).and_return(warehouse)
      allow(warehouse).to receive(:update).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_original = { warehouse: {name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                          address: 'Av. do Porto, 1000', cep: '20000-000', 
                                          description: 'Galpão do Rio'} 
                            }
      post '/api/v1/warehouses', params: warehouse_original
      original_warehouse_id = JSON.parse(response.body)["id"]

      # Act 
      patch "/api/v1/warehouses/#{original_warehouse_id}", params: { warehouse: { name: 'Galpão Rio'} }

      # Assert
      expect(response.status).to eq 500
    end
  end

  context 'DELETE /api/v1/warehouses/1' do
    it 'usuário deleta galpão com sucesso' do 
      # Arrange
      warehouse_original = { warehouse: {name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                              address: 'Av. do Porto, 1000', cep: '20000-000', 
                                              description: 'Galpão do Rio'} 
                            }
      post '/api/v1/warehouses', params: warehouse_original
      original_warehouse_id = JSON.parse(response.body)["id"]

      # Act 
      delete "/api/v1/warehouses/#{original_warehouse_id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.body).to include 'Registro excluído com sucesso'
    end

    it 'falha com erro do servidor' do 
      # Arrange
      warehouse = instance_double(Warehouse)
      allow(Warehouse).to receive(:find).and_return(warehouse)
      allow(warehouse).to receive(:destroy).and_raise(ActiveRecord::ActiveRecordError)

      warehouse_original = { warehouse: {name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                              address: 'Av. do Porto, 1000', cep: '20000-000', 
                                              description: 'Galpão do Rio'} 
                            }
      post '/api/v1/warehouses', params: warehouse_original

      original_warehouse_id = JSON.parse(response.body)["id"]

      # Act 
      delete "/api/v1/warehouses/#{original_warehouse_id}"

      # Assert
      expect(response.status).to eq 500
    end
  end
end