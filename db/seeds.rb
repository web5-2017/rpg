# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Skill.create_with(description: "Lança uma bola de fogo que queima o inimigo",
                    modifier: "atk:5,mp:10"
                  ).find_or_create_by(name: 'Ataque de fogo')

Skill.create_with(description: "Lança uma rajada de gelo",
                    modifier: "atk:4,mp:10"
                 ).find_or_create_by(name: 'Ataque de gelo')

Skill.create_with(description: "Golpeia o inimigo com um corte circular",
                    modifier: "atk:8,mp:8"
                 ).find_or_create_by(name: 'Corte circular')

Skill.create_with(description: "Golpeia avançando pra frente e golpenado varias vezes",
                    modifier: "atk:10,mp:17"
                 ).find_or_create_by(name: 'Ataque perfurante')

Particular.create_with(description: "Capacidade de sentir cheiros a distância",
                       additional: 'des:2').find_or_create_by(name: 'Faro aguçado')

Particular.create_with(description: "Bom de papo, tem mais chance de convencer em uma conversa",
                       additional: 'car:2').find_or_create_by(name: 'Carismático')

Particular.create_with(description: "Grande capacidade de resolver quebra-cabeça",
                       additional: 'sab:2').find_or_create_by(name: 'Sabedoria')
