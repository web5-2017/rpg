# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Skill.create_with(description: "Lança uma bola de fogo que queima o inimigo",
                  modifier: "atk:2,mp:10"
                  ).find_or_create_by(name: 'Ataque de fogo')

Skill.create_with(description: "Avança no inimigo e o golpeia",
                  modifier: "atk:6,mp:20"
                  ).find_or_create_by(name: 'Ataque direto')

Particular.create_with(description: "Capaz de sentir um cheiro a longas distâncias",
                  additional: 'des:10'
                  ).find_or_create_by(name: 'Faro aguçado')

Particular.create_with(description: "Tem maior chance de convencer os outros",
                   additional: 'car:10'
                  ).find_or_create_by(name: 'Persuasão')
