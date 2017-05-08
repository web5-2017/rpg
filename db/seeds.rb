# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Skill.create_with(description: "Lança uma bola de fogo que queima o inimigo",
                  modifier: 20
                  ).find_or_create_by(name: 'Ataque de fogo')

Skill.create_with(description: "Avança no inimigo e o golpeia",
                  modifier: 40
                  ).find_or_create_by(name: 'Ataque direto')

Particular.create_with(description: "Capaz de sentir um cheiro a longas distâncias",
                  additional: 'des:10'
                  ).find_or_create_by(name: 'Faro aguçado')

Particular.create_with(description: "Tem maior chance de convencer os outros",
                   additional: 'car:10'
                  ).find_or_create_by(name: 'Persuasão')

Effect.create_with(description: "Deixa o alvo sobre efeito de sangramento, perdendo 20 de hp por rodada",
                    value: -5,
                    duration: 3
                  ).find_or_create_by(name: 'Sangramento')

Effect.create_with(description: "Restaura o hp em 50",
                    value: 50,
                    duration: 1
                  ).find_or_create_by(name: 'Cura')
