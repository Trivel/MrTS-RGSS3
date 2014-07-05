#==============================================================================
# ** Game_Enemy
#------------------------------------------------------------------------------
#  This class handles enemies. It used within the Game_Troop class 
# ($game_troop).
#==============================================================================

class Game_Enemy < Game_Battler
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_reader   :index                    # index in troop
  attr_reader   :enemy_id                 # enemy ID
  attr_reader   :original_name            # original name
  attr_accessor :letter                   # letters to be attached to the name
  attr_accessor :plural                   # multiple appearance flag
  attr_accessor :screen_x                 # battle screen X coordinate
  attr_accessor :screen_y                 # battle screen Y coordinate
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  alias mrts_initialize initialize
  alias mrts_dispose dispose
  alias mrts_update update


  def initialize(index, enemy_id)
    mrts_initialize
    set_aura
  end

  def set_aura
    @aura_number = enemy.note =~ /<Aura\s*:\s*(\d*)>/i ? $1.to_i : nil
    if @aura_number
      @aura_image = Sprite.new
      @aura_image.viewport = self.viewport
      @aura_image.bitmap = self.bitmap
      @aura_image.x = self.x
      @aura_image.y = self.y
    end
  end

  def update_aura
    @aura_image.zoom_x -= 0.02
    @aura_image.opacity -= 0.5    
  end

  def has_aura?
    true if @aura_number
    false
  end

  def dispose
    mrts_dispose
    @aura_image.dispose if @aura_image
  end

  def update
    mrts_update
    update_aura    
  end
end
