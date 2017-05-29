class Match::Compiler
  HELP_ROOT = "-------------- help\n\\start - para iniciar a partida\n\\battle_start [ids dos inimigos da batalha] exemplo: \\battle_start 1 4 5 20\n\\atk [id do alvo] [id do personagem] exemplo: atk 3 2"
  HELP_USER = "-------------- help\\atk [id do alvo] exemplo: atk 4"
  NOT_FOUND = "Comando desconhecido"
  ERROR_SESSION_NOT_STARTED = "Para iniciar uma batalha, deve primeiro dar inicio na partida com '\\start'"


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
    when '\help'
      @session.inserting_in_the_log HELP_ROOT
    when '\battle_start'
      if @session.opened
        battle_start
      else
        @session.inserting_in_the_log ERROR_SESSION_NOT_STARTED
      end
    when '\current_dice'
      if @session.opened
        @session.current_dice Integer(@code[1])
        @session.inserting_in_the_log "Dado mudado para #{@code[1]}"
      else
        @session.inserting_in_the_log ERROR_SESSION_NOT_STARTED
      end
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
      exec_atk
    when '\set_skill'
      set_skill
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

  def battle_start
    @session.inserting_in_the_log "Batalha iniciada"
    @session.create_battle @code[1..(@code.size - 1)]
    @session.inserting_in_the_log "É a vez de #{@session.battle.character_turn.name}"
  end

  def exec_atk
    target = UserCharacter.find @code[1]

    if target.hp <= 0
      @session.inserting_in_the_log "Esse personagem já morreu, por favor escolha outro para atacar"
    elsif @root
       char = UserCharacter.find @code[2]

       if @session.atk(target, char)
         @session.inserting_in_the_log "O #{char.name} atacou o #{target.name}"
         @session.inserting_in_the_log "É a vez de #{@session.battle.character_turn.name}"
         target_is_dead target
       end
    else
      if @session.atk(target)
        @session.inserting_in_the_log "O #{@user_name} atacou o #{target.name}"
        @session.inserting_in_the_log "É a vez de #{@session.battle.character_turn.name}"
        target_is_dead target
      end
    end
  end

  def set_skill

    if @root
       char = UserCharacter.find @code[1]

       if char.set_skill
         @session.inserting_in_the_log "Skill mudada"
       else
         @session.inserting_in_the_log "Você não tem essa skill"
       end
    else
      if @session.set_skill(@code[1])
        @session.inserting_in_the_log "Skill mudada"
      else
        @session.inserting_in_the_log "Você não tem essa skill"
      end
    end
  end

  def target_is_dead(target)
    if target.hp <= 0
      @session.inserting_in_the_log "O #{target.name} morreu"
    end
  end
end
