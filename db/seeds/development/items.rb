pnames = ["マルゲリータ", "クワトロフォルマッジ", "マヨコーンピザ", "ビスマルク","ジェノベーゼ"]
explains = ["Pizzaonの定番マルゲリータ、この一枚で今日をちょっぴり良い日に!", "蜂蜜をかけてお召
    し上がりください。","邪道とは言われながらもはまってしまう禁断の組み合わせ！","半熟卵が美味しい!",
    "香ばしいバジルの香りがあなたを包み込みます。"]
0.upto(4) do |idx|
    @item = Item.create(
        name: pnames[idx],
        price: 1000,
        category: 1,
        explanation: explains[idx],
    )
    @item.create_stock(number: 10)
end

dnames = ["コーラ", "サイダー", "カルピス"]
0.upto(2) do |drink|
    @item = Item.create(
        name: dnames[drink],
        price: 200,
        category: 2,
        explanation: "ドリンクです。"
    )
    @item.create_stock(number: 10)
end