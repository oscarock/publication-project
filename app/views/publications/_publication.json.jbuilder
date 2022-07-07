json.extract! publication, :id, :title, :description, :price, :city, :address, :phone, :visible, :created_at, :updated_at
json.url publication_url(publication, format: :json)
