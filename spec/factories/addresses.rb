FactoryGirl.define do

  factory :address do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    name FFaker::Address.street_name
    city 'Dnepr'
    zip 49000
    phone '+380632863823'
    country_id { create(:country).id }
  end

  factory :shipping_address, parent: :address do
    address_type :shipping
  end

  factory :billing_address, parent: :address do
    address_type :billing
  end
end