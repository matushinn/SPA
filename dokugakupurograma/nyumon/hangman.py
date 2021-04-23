"""
1,プレイヤー1は、好きな単語を選んで隠しておきます。単語の文字の数だけ、アンダースコア(_)を引きます
2,プレイヤー2は、単語を予想して、1回に一文字回答します。
3,プレイヤー2が回答した文字が、隠してある単語に含まれていたら、プレイヤー1は書いておいた下線のその文字があるべきところに、
その文字を書き込みます。今回のルールでは、一つの単語に同じ文字が2個以上含まれている場合は、回答一回につき一文字だけ表示されます。
プレイヤー2の回答が間違っていた場合、プレイヤー1は釣られた人の絵のパーツを一つ書き込みます。(頭から始める)
4,つられた人の絵が完成する前に、プレイヤー2が隠された単語の文字をすべて当てられたら、プレイヤー2の勝ちです。
絵が完成してしまったら、負けです。

"""
import random

def hangman():
    word_lists = ["Java","Python","Swift","Ruby"]
    random_index = random.randint(0,3)
    word = word_lists[random_index]

    #プレイヤー2がどれだけ間違えたか?
    wrong = 0
    stages = ["              ",
              "________      ",
              "|      |      ",
              "|      0      ",
              "|     /|\     ",
              "|     / \     ",
              "|             "
              ]
    #rlettersはwordの文字列を一文字ずつの要素に分解してリストにしたもの
    rletters = list(word)
    #wordの長さの文だけ_を引く
    board = ["_"] * len(word)
    win = False
    print("ハングマンへようこそ!")

#wrongは1から、stagesは要素0から
    while wrong < len(stages)-1:
        print("\n")
        msg = "一文字を予想してね"
        char = input(msg)
        if char in rletters:
            #indexを使って入力された文字がrlettersの何番目にあるかのインデックスを取得します。
            cind = rletters.index(char)
            board[cind] = char
            #同じ文字列が並んだときの重複を回避する。
            rletters[cind] = "$"
        else:
            #間違えたとき
            wrong += 1
        print("".join(board))
        e = wrong+1
        print("\n".join(stages[0:e]))

        if "_" not in board:
            print("あなたの勝ち")
            print("".join(board))
            win = True
            break

    if not win:
        print("\n".join(stages[0:wrong+1]))
        print("あなたの負け!正解は{}.".format(word))

hangman()


