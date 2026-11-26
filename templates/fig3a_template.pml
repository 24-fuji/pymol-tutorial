# fig3a_template.pml
# 08. 最終課題のテンプレート
# 各問題の「ここにコマンドを書く」の部分を埋めて、Q1〜Q8 のシーンを完成させる。
# 実行: PyMOL のコマンドラインで @fig3a_template.pml (または ターミナルで pymol fig3a_template.pml)

reinitialize
fetch 2a65 2qju
bg_color white

# ===== Q1: Overall structure (全体構造) =====
hide everything
# ここにコマンドを書く

scene Q1, store

# ===== Q2: Show ions (イオンの表示) =====
hide everything
# ここにコマンドを書く

scene Q2, store

# ===== Q3: Show residues (残基の表示) =====
hide everything
# ここにコマンドを書く

scene Q3, store

# ===== Q4: Measure distance (距離の測定) =====
hide everything
# ここにコマンドを書く

scene Q4, store

# ===== Q5: Select neighbors (近くの残基の選択) =====
hide everything
# ここにコマンドを書く

scene Q5, store

# ===== Q6: Align (重ね合わせ) =====
hide everything
# ここにコマンドを書く

scene Q6, store

# ===== Q7: Map B-factor (B-factor の色分け) =====
hide everything
# ここにコマンドを書く

scene Q7, store

# ===== Q8: Electrostatics (静電ポテンシャル) =====
hide everything
# ここにコマンドを書く

scene Q8, store

# ===== 画像の書き出し =====
# 8 つのシーンが完成したら、次の行の先頭の「#」を消して実行する
# scene Q1, animate=0
# png fig3a_q1.png, width=1200, height=1200, dpi=300, ray=1
# scene Q2, animate=0
# png fig3a_q2.png, width=1200, height=1200, dpi=300, ray=1
# scene Q3, animate=0
# png fig3a_q3.png, width=1200, height=1200, dpi=300, ray=1
# scene Q4, animate=0
# png fig3a_q4.png, width=1200, height=1200, dpi=300, ray=1
# scene Q5, animate=0
# png fig3a_q5.png, width=1200, height=1200, dpi=300, ray=1
# scene Q6, animate=0
# png fig3a_q6.png, width=1200, height=1200, dpi=300, ray=1
# scene Q7, animate=0
# png fig3a_q7.png, width=1200, height=1200, dpi=300, ray=1
# scene Q8, animate=0
# png fig3a_q8.png, width=1200, height=1200, dpi=300, ray=1

# ===== セッションの保存 =====
save fig3a.pse
