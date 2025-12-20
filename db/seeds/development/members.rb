Member.create(
    name: "Taro",
    point:  0,
    role:  3 ,
    password: "asagao!",
    password_confirmation: "asagao!"
)

0.upto(4) do |idx|
    Member.create(
        name: idx,
        point:  0,
        role:  (idx % 2) + 1 ,
        password: "asagao!",
        password_confirmation: "asagao!"
    )
end