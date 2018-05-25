# 常微分方程式y'=-yの数値解を求める
# juliaの速度検証プログラム
# 刻み幅hの前進オイラー法で離散化(y[n+1]=y[n]-y[n]*h)
# juliaは関数に入れることで高速になるらしいので関数に入れてる

function main()

    N = 100000000 # プロット数
    h = 0.00000004 # 刻み幅
    y = zeros(N) # 0で初期化

    # 初期値
    # juliaでは配列は1からスタート
    y[1] = 1

    # 数値計算
    @time for n = 1:N-1 # @timeをつけることでfor文の速度を測定
        y[n+1] = (1-h)y[n] # juliaでは*を省略して書ける
    end

    # x, start:step:stop
    # 0からh刻みで(N-1)hまでをxに代入
    x = 0:h:(N-1)h

    # 厳密解 # 結果の比較をするために用意
    # f(x)=xみたいに数学でいう関数っぽい書き方が良いですね
    f(x) = exp.(-x) # 配列に関数を適用するためにドットが必要らしい

    y_exc = f(x)

    # グラフプロットはフロントエンドにPlots, バックエンドにGRがおすすめらしい
    # main関数内に入れたらエラーを吐かれたので，一旦コメント化
    # using Plots
    # gr()
    # plot(x, y_exc, color=:black, linewidth=5, label="Exact", xlabel="x", ylabel="y")
    # plot!(x, y, color=:red, linewidth=2, linestyle=:dash, label="Numerical") # !をつけるとプロットを追加できるらしい
    # savefig("Speed_Test.png")

    # 見映え整形用に12マスのスペースを入れている
    @printf("%12s %12s %12s %12s\n", "n", "Num", "Exact", "Error")
    for n = N-10:N
        @printf("%12d %12.8f %12.8f %12.8e\n", n, y[n], y_exc[n], y[n]-y_exc[n])
    end
end
main()
