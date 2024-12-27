# app/serializers/user_serializer.rb
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :first_name, :last_name, :user_name, :date_of_birth, :gender, :nationality, :phone_number
end
