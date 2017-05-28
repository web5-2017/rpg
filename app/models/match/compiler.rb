class Match::Compiler
  HELP_ROOT = "-------------- help\n\\start - para iniciar a partida\n\\set_map [id do mapa] - exemplo: \\set_map 2"
  HELP_USER = "-------------- help"
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
    else
      @session.inserting_in_the_log NOT_FOUND
    end
  end

  def exec_user_code
    case @code[0]
    when '\help'
      @session.inserting_in_the_log HELP_USER
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

  def set_map
    if @code[1] && @session.have_permission_in_map?(@code[1])
      @session.inserting_in_the_log "Mapa atual alterado"
      @session.map_id = @code[1]
    else
      @session.inserting_in_the_log "Esse mapa não existe"
    end
  end

  def battle_start
    @session.inserting_in_the_log "Batalha iniciada"
    @session.create_battle @code[1..(@code.size - 1)]
    @session.battle.next
    @session.inserting_in_the_log "É a vez de #{@session.battle.character_turn.name}"
  end
end
