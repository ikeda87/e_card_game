# 改行表現
def new_line
  puts "-"*110
end

# 現在ターンと残りデッキ状況を表示する文章
def current_turn
  new_line
  puts <<~text
  第#{@match.turn}ターンです。
  #{@enemy.name}のカードは、"皇帝"が1枚"市民"が#{5-@match.turn}枚です。
  #{@player.name}の番です、次の選択肢の中から行動を決めてください。
  1:"市民"のカードを出す　2:"奴隷"のカードを出す
  ※※※半角数字で入力してください※※※
  text
  new_line
end

# 既読待ち機能
def read_wait
  sleep 2
end

# ドキドキ感演出機能
def palpitate
  sleep 3
end

# カードを一枚使う
def use_card
  @current_enemy_card = @enemy_cards.first
  @enemy_cards.shift # 使用済みカードを除外する
end

# ざわざわ
def zawazawa
  puts <<~text
  　　　　　　　　　　　　＼＿丶丶　 |
  　　　　　　　　　　　　￣＼　　 ￣|／⌒|
  　　　　　　　　　　　　⊂二　 　  /|　 J　．．．．．．

  　＼＿丶丶　 |
  　￣＼　　 ￣|／⌒|
  　⊂二　 　  /|　 J　．．．．．．
  text
end

# 勝利フラグ
def win_flag
  @player_win += 1
end

# 敗北フラグ
def lose_flag
  @enemy_win += 1
end

# 現状説明文章
def explain_situation
  new_line
  puts <<~text
  貴方の名前は#{@player.name}。
  #{@player.name}は今夢の中にいます、とても悪い夢です。
  #{@player.name}の目の前には#{@enemy.name}がいて、#{@enemy.name}とeカードで勝負しなければなりません。
  eカードで#{@enemy.name}に勝てば#{@player.name}は1億ベリカ貰えますが、負ければ#{@player.name}は地下強制労働1050年を課せられます。
  とても理不尽ですが、誰かに助けを求める事はできません。
  text
  new_line
  puts <<~text
  #{@enemy.name}「金は命より重い。」
  #{@player.name}「自分を救うのは…自分だけ…！」
  text
  read_wait
end

# ゲーム説明文章
def explain_rule
  new_line
  puts <<~text
  eカードのルールを説明します。
  登場するカードは3種類のみ、"皇帝"・"市民"・"奴隷"です。
  #{@enemy.name}のカードは"皇帝"が1枚"市民"が4枚、#{@player.name}のカードは"市民"が4枚"奴隷"が1枚です。
  カードの種類によらず全てのカードの裏面は同じ模様であり、裏面からどの種類のカードかを判断する事はできません。
  ゲームはターン制で、1ターン毎にお互い1枚ずつカードを出して戦います。
  1度使用したカードをもう1度使う事はできません。
  カードの勝敗は次の通りです。
  "皇帝"は"市民"に勝ち、"市民"は"奴隷"に勝ち、"奴隷"は"皇帝"に勝ちます。
  ただし"市民"と"市民"は引き分けになります。
  全てのカードを出し終えた時、勝った回数の多かった方がゲームの勝者となります。
  text
  new_line
end

# ゲーム説明文章の復唱確認
def get_ready
  while true do
    puts "#{@enemy.name}「#{@player.name}くん、準備はいいか？」[y/n]"
    new_line
    ready = gets.chomp
    if ready == "y"
      puts <<~text
      #{@enemy.name}「ならば始めよう。」
      #{@player.name}「すべてを捩じ伏せ……オレは勝つ……！」
      text
      break
    elsif ready == "n"
      puts "#{@enemy.name}「もう一度ルール確認だな。」"
      explain_rule
    else
      puts "正しい値を入力してください。"
      new_line
    end
  end
end

# ゲーム開始
def match_begin
  while true do
    new_line
    @match.turn_pass
    puts "#{@enemy.name}「このカードで勝負しよう。」"
    while true do
      current_turn
      player_action = gets.chomp
      if player_action == SELECT_CITIZEN
        puts <<~text
        #{@player.name}は"市民"のカードを出した！
        text
        new_line
        zawazawa
        new_line
        palpitate
        use_card
        if @current_enemy_card.name == "市民"
          puts <<~text
          #{@player.name}のカードは"市民"です。
          #{@enemy.name}のカードは"#{@current_enemy_card.name}"です。
          この勝負は引き分けです！
          text
          read_wait
          new_line
          if @match.turn == 4
            puts <<~text
            4連続で"市民"vs"市民"のため、#{@player.name}の勝利です。
            text
            win_flag
            return
          else
            puts <<~text
            #{@enemy.name}「ふふふ、続けようじゃないか。」
            #{@player.name}「まだ終っちゃいない！」
            text
            break
          end
        else
          puts <<~text
          #{@player.name}のカードは"市民"です。
          #{@enemy.name}のカードは"#{@current_enemy_card.name}"です。
          この勝負は#{@enemy.name}の勝利です！
          text
          lose_flag
          read_wait
          return
        end
      elsif player_action == SELECT_SLAVE
        puts <<~text
        #{@player.name}は"奴隷"のカードを出した！
        text
        new_line
        zawazawa
        new_line
        palpitate
        use_card
        if @current_enemy_card.name == "皇帝"
          puts <<~text
          #{@player.name}のカードは"奴隷"です。
          #{@enemy.name}のカードは"#{@current_enemy_card.name}"です。
          この勝負は#{@player.name}の勝利です！
          text
          win_flag
          read_wait
          return
        else
          puts <<~text
          #{@player.name}のカードは"奴隷"です。
          #{@enemy.name}のカードは"#{@current_enemy_card.name}"です。
          この勝負は#{@enemy.name}の勝利です！
          text
          lose_flag
          read_wait
          return
        end
      elsif player_action == SELECT_FAKE
        puts "#{@player.name}「この圧倒的不利な状況をどうする、ただただ運否天賦で勝負していいのか？」"
        read_wait
        puts "#{@player.name}「イカサマをするしかねぇ！」"
        new_line
        read_wait
        puts "#{@player.name}は#{@enemy.name}の心を読んだ！！"
        read_wait
        puts "#{@enemy.name}はカードを"
        @enemy_cards.each do |card|
          puts card.name
        end
        puts "この順番で出してくる！"
      else
        puts "正しい値を入力してください。" 
      end
    end
  end
end

# ゲームクリア文章
def game_clear
  new_line
  puts <<~text
  #{@enemy.name}「そんなバカな・・・。」
  #{@player.name}「自分の頭で考え…勝つべくして勝つ…。」
  text
end

# ゲームオーバー文章
def game_over
  new_line
  puts <<~text
  #{@enemy.name}「ハハハ、他愛もない。」
  #{@player.name}「と゛お゛し゛て゛た゛よ゛お゛お゛お゛！」
  text
end

# コンティニュー文章
def continue?
  new_line
  puts "もう一度挑戦する？[y]"
  continue = gets.chomp
  if continue != "y"
    exit
  end
end