names = ["one","two","three","four","five"]

0.upto(4) do |idx|
    Member.create(
        name: names[idx],
        point:  0,
        role:  (idx % 2) + 1 ,
        password: "asagao!",
        password_confirmation: "asagao!"
    )
end