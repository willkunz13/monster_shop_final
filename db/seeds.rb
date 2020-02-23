# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

# merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

# bike_shop items
tire = bike_shop.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)

# dog_shop items
pull_toy = dog_shop.items.create(name: 'Pull Toy', description: 'Great pull toy!', price: 10, image: 'http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg', inventory: 32)
dog_bone = dog_shop.items.create(name: 'Dog Bone', description: "They'll love it!", price: 21, image: 'https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg', active?: false, inventory: 21)

# user information
merchant = User.create(
  name: 'penelope',
  address: '123 W',
  city: 'a',
  state: 'IN',
  zip: 12345,
  email: 'a',
  password: '1',
  role: 1
)
user = User.create(
  name: 'person',
  address: '123 W',
  city: 'a',
  state: 'IN',
  zip: 12345,
  email: 'b',
  password: '1',
  role: 0
)

admin = User.create(
  name: 'Kevin',
  address: '123 Street Road',
  city: 'City Name',
  state: 'CO',
  zip: 12345,
  email: 'admin@example.com',
  password: 'password1',
  role: 2
)
