FactoryBot.define do
  factory :item do
    name                  { 'Sample Item' }
    description           { 'This is a description' }
    category_id           { 2 }
    condition_id          { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id         { 2 }
    shipping_day_id       { 2 }
    price                 { 1000 }
    association :user

    after(:build) do |item|
      image_path = Rails.root.join('spec/fixtures/files/test_image.png')
      if File.exist?(image_path)
        File.open(image_path, 'rb') do |file|
          item.image.attach(
            io: file,
            filename: 'test_image.png',
            content_type: 'image/png'
          )
        end
      else
        puts "[WARNING] test_image.png not found: #{image_path}"
      end
    end
  end
end
