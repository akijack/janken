#じゃんけんメソッド
#
# 引数
#   judge : 勝敗変数 (-1: draw 0:win, 1:lose)
#
# 戻り値
#   nil : ゲーム放棄
#   -1  : 引き分け
#    0  : 勝ち
#    1  : 負け

def janken(judge = nil)

  jankens = ["グー", "チョキ", "パー"]

  #乱数が毎回同じにならないように種を設定
  time = Time.now.strftime("%Y%m%d%H%M%S").to_i
  srand(time)

  #最初だけ「じゃんけん・・・」を表示
  #あいこの時は「あいこで・・・」を表示
  if judge.nil?
    puts "じゃんけん・・・"
  else
    puts "あいこで・・・"
  end

  # プレイヤーの入力待機
  puts "0(グー) 1(チョキ) 2(パー) 3(戦わない): "
  player_hand = gets.to_i

  # 相手の手を設定
  program_hand = rand(3)

  #プレイヤーが３（戦わない）を選択した時、nilを戻してメソッドを終了
  if player_hand == 3
    puts "じゃんけんが放棄されました。"
    return
  end

  #最初だけ「ぽん！」を表示
  #あいこの時は「しょ！」を表示
  if judge.nil?
    puts "ぽん！"
  else
    puts "しょ！"
  end

  # お互いの手を表示
  puts "------------------"
  puts "あなた : #{jankens[player_hand]} を出しました。"
  puts "相手   : #{jankens[program_hand]} を出しました。"
  puts "------------------"

  # 手の比較をする
  case player_hand
  # あなた : グー
  when 0
    # 相手 : グー
    if program_hand == 0
      judge = -1    # あいこ
    # 相手 : チョキ
    elsif program_hand == 1
      judge = 0     # 勝ち
    # 相手 : パー
    else
      judge = 1     # 負け
    end
  # あなた : チョキ
  when 1
    # 相手 : グー
    if program_hand == 0
      judge = 1     # 負け
    # 相手 : チョキ
    elsif program_hand == 1
      judge = -1    # あいこ
    # 相手 : パー
    else
      judge = 0     # 勝ち
    end
  # あなた : パー
  when 2
    # 相手 : グー
    if program_hand == 0
      judge = 0     # 勝ち
    # 相手 : チョキ
    elsif program_hand == 1
      judge = 1     # 負け
    # 相手 : パー
    else
      judge = -1    # あいこ
    end
  end

  #手の比較結果を表示
  if judge < 0
    puts "じゃんけんは引き分けです。"
  elsif judge == 0
    puts "じゃんけんに勝ちました！"
  else
    puts "じゃんけんに負けました・・・"
  end

  # 手の比較結果を戻す
  return judge
end

#あっち向いてホイメソッド
#
# 戻り値
#    0  : 勝ち (同じ方向)
#    1  : 負け (異なる方向)
def attimuitehoi
  
  directions = ["上","右","下","左"]
  
  #乱数が毎回同じにならないように種を設定
  time = Time.now.strftime("%Y%m%d%H%M%S").to_i
  srand(time)
  
  puts "あっち向いて・・・"
  
  #プレイヤーの入力待機
  puts "0(上) 1(右) 2(下) 3(左)"
  player_direction = gets.to_i
  
  #相手の向きを設定
  program_direction = rand(4)
  
  puts "ホイ！"
  
  #お互いに設定した向きを表示
  puts "---------------"
  puts "あなた：#{directions[player_direction]}"
  puts "相手：#{directions[program_direction]}"
  puts "---------------"
  
  #向きを比較
  if player_direction == program_direction
    puts "同じ方向を向きました。"
    judge = 0
  else
    puts "異なる方向を向きました。"
    judge = 1
  end
  
  #向きの比較結果を戻す
  return judge
end

#あっち向いてホイゲームのメイン処理
#じゃんけん結果の初期値を設定
janken_result = nil

#無限ループ
while true
  #じゃんけんメソッドを呼び出し、結果を受け取る
  janken_result = janken(janken_result)
  
  #受け取った結果がnil(放棄)の時
  if janken_result.nil?
    puts "ゲームを終了します。"
    break
  #受け取った結果が-1(あいこ)の時、じゃんけんやり直しのためループ先頭へ
  elsif janken_result < 0
    next
  #受け取った結果が0/1(勝ち/負け)の時、じゃんけんの結果を引き継いであっち向いてホイを実行
  else
    attimuitehoi_result = attimuitehoi
  end
  
  #あっち向いてホイで異なる方向を向いた時、じゃんけんからやり直し
  if attimuitehoi_result != 0
    janken_result = nil
  #あっち向いてホイで同じ方向を向いている、かつ、じゃんけんで勝った時
  elsif janken_result == 0
    puts "あなたの勝ちです！"
    break
  #あっち向いてホイで同じ方向を向いている、かつ、じゃんけんで負けた時
  elsif janken_result == 1
    puts "あなたの負けです・・・"
    break
  end
end
