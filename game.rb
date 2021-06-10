require './match'
require './card'
require './deck'
require './participant'
require './progress'

while true do
  # 初期化
  @match = Match.new(turn: 0)
  emperor = Card.new(name: "皇帝")
  citizen = Card.new(name: "市民")
  @player = Participant.new(name: "ルビジ")
  @enemy_cards = [citizen,citizen,citizen,citizen,emperor]
  @enemy_deck = Deck.new(cards: @enemy_cards)
  @enemy_deck.mix
  @enemy = Participant.new(name: "信濃川", deck: @enemy_deck)
  @player_win = 0
  @enemy_win = 0
  # マジックナンバー
  SELECT_CITIZEN ||= "1"
  SELECT_SLAVE ||= "2"
  SELECT_FAKE ||= "3"

  explain_situation
  explain_rule
  get_ready

  while true do
    match_begin
    if @player_win == 1
      game_clear
    elsif @enemy_win == 1
      game_over
    end
    continue?
    break
  end
end
