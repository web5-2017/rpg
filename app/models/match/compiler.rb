class Match::Compiler
  HELP_ROOT = "-------------- help\n\\start - para iniciar a partida\n\\end - para Terminar a partida\n\\start_battle [ids dos inimigos da batalha] exemplo: \\start_battle 1 4 5 20 - Para dar inicio a uma batalha\n\\end_battle - Para terminar uma batalha\n\\atk [id do alvo] [id do personagem] exemplo: atk 3 2 - Para atacar um personagem\n\\current_dice [tipo do dado] exemplo: \\current_dice 6 - Muda o dado a ser usado nos ataques\n\\send_exp [quantidade de exp] [id(s) dos(s) personagem(s)] exemplo: \\send_exp 8 4 \\send_exp 8 4 3 - Para dar exp para um ou mais personagens\n\\cast_dice [tipo do dado] exemplo: \\cast_dice 6 - Joga um dado (Apenas joga e mostra o valor)\n\\set_skill [id do personagem] [id da habilidade] exemplo: \\set_skill 2 3 - Prepara a habilidade para o ataque"
  HELP_USER = "-------------- help\n\\atk [id do alvo] exemplo: atk 4 - Para atacar um personagem\n\\set_skill [id da skill] exemplo: \\set_skill 2 - Prepara a habilidade para o ataque\n\\cast_dice [tipo do dado] exmplo: \\cast_dice 6 - Joga um dado (Apenas joga e mostra o valor)"
  NOT_FOUND = "Comando desconhecido"
  ERROR_SESSION_NOT_STARTED = "Deve primeiro dar inicio na partida com '\\start'"


  def initialize(session, code, name, is_master)
    @session = session
    @user_name = name
    @text_code = code
    @code = code.split
    @root = is_master
  end

  def run
    @session.inserting_in_the_log "#{@user_name}# - #{@text_code}"

    if @root
      exec_root_code
    else
      exec_user_code
    end
  end

  private

  def exec_root_code
    case @code[0]
    when '\start'
      start
    when '\end'
      end_s
    when '\help'
      @session.inserting_in_the_log HELP_ROOT
    when '\start_battle'
      if @session.opened
        unless @session.battle_string.nil?
          @session.inserting_in_the_log "A batalha ja foi criada"
        else
          battle_start
        end
      else
        @session.inserting_in_the_log ERROR_SESSION_NOT_STARTED
      end
    when '\end_battle'
      unless @session.battle_string.nil?
        @session.battle= nil
        @session.battle_string= nil
        @session.inserting_in_the_log "Batalha finalizada"
      else
        @session.inserting_in_the_log "Nenhuma batalha criada"
      end
    when '\current_dice'
      if @session.opened
        @session.current_dice= Integer(@code[1])
        @session.inserting_in_the_log "Dado mudado para #{@code[1]}"
      else
        @session.inserting_in_the_log ERROR_SESSION_NOT_STARTED
      end
    when '\send_exp'
      send_exp
    else
      exec_for_all
    end
  end

  def exec_user_code
    case @code[0]
    when '\help'
      @session.inserting_in_the_log HELP_USER
    else
      exec_for_all
    end
  end

  def exec_for_all
    case @code[0]
    when '\atk'
      if @session.opened
        unless @session.battle_string.nil?
          exec_atk
        else
          @session.inserting_in_the_log "Você não está em uma batalha"
        end
      else
        @session.inserting_in_the_log ERROR_SESSION_NOT_STARTED
      end
    when '\set_skill'
      if @session.opened
        unless @session.battle_string.nil?
          set_skill
        else
          @session.inserting_in_the_log "Você não está em uma batalha"
        end
      else
        @session.inserting_in_the_log ERROR_SESSION_NOT_STARTED
      end
    when '\cast_dice'
      if @session.opened
        dice = ::Dice.new(Integer(@code[1]))
        @session.inserting_in_the_log "O #{@user_name} jogou o dado e tirou #{dice.cast}"
      else
        @session.inserting_in_the_log ERROR_SESSION_NOT_STARTED
      end
    else
      @session.inserting_in_the_log NOT_FOUND
    end
  end

  def start
    unless @session.opened
      @session.inserting_in_the_log "Partida iniciada"
      @session.opened = true
    else
      @session.inserting_in_the_log "A partida já está iniciada"
    end
  end

  def end_s
    if @session.opened
      @session.inserting_in_the_log "Fim de Partida"
      @session.opened = false
    else
      @session.inserting_in_the_log "A partida está fechada"
    end
  end

  def battle_start
    @session.inserting_in_the_log "Batalha iniciada"
    @session.create_battle @code[1..(@code.size - 1)]
    @session.inserting_in_the_log "É a vez de #{@session.battle.character_turn.name}"
  end

  def exec_atk
    magic = @code.last == "magic" ? true : false
    target = UserCharacter.find @code[1]

    if target.hp <= 0
      @session.inserting_in_the_log "Esse personagem já morreu, por favor escolha outro para atacar"
    elsif @root
       char = UserCharacter.find @code[2]

       if @session.atk(target, magic, char)
         @session.inserting_in_the_log "O #{char.name} atacou o #{target.name}"
         @session.inserting_in_the_log "É a vez de #{@session.battle.character_turn.name}"
         target_is_dead target
       end
    else
      if @session.atk(target, magic)
        @session.inserting_in_the_log "O #{@user_name} atacou o #{target.name}"
        @session.inserting_in_the_log "É a vez de #{@session.battle.character_turn.name}"
        target_is_dead target
      end
    end
  end

  def set_skill
    if @root
       char = UserCharacter.find @code[1]

       if char.set_skill(@code[2])
         @session.inserting_in_the_log "Skill selecionada"
       else
         @session.inserting_in_the_log "Você não tem essa skill ou não tem mana para executala"
       end
    else
      if @session.set_skill(@code[1])
        @session.inserting_in_the_log "Skill selecionada"
      else
        @session.inserting_in_the_log "Você não tem essa skill ou não tem mana para executala"
      end
    end
  end

  def send_exp
    exp = Integer(@code[1])

    for i in 2..(@code.size- 1)
      char = @session.game.chars.find @code[i]
      @session.send_exp(exp, char)
      @session.inserting_in_the_log "#{char.name} recebeu #{exp} de exp"
    end
  end

  def target_is_dead(target)
    if target.hp <= 0
      @session.inserting_in_the_log "O #{target.name} morreu"
    end
  end
end
