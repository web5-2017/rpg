# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Skill.create! name: 'Ataque de fogo', description: "Lança uma bola de fogo que queima o inimigo"
Skill.create! name: 'Ataque direto', description: "Avança no inimigo e o golpeia"

Particular.create! name: 'Faro aguçado', description: "Capaz de sentir um cheiro a longas distâncias"
Particular.create! name: 'Persuasão', description: "Tem maior chance de convencer os outros"
