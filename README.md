This repo is just minimal case to reproduce an elm runtime error.


JS Console output when you click the button:

    RN.make.beginSeed: Seed 1196435762 1013904223
    randNth.listLength: 3
    randNth.incomingSeed: <internal structure>
    Uncaught TypeError: Cannot read property '_0' of undefined
    @ _mgold$elm_random_pcg$Random_Pcg$peel


NB. The code does a second Debug.log on the seedX variable which is used
subequently, but this Debug.log statement does not print between the original
`RN.make.beginSeed` log statement and the `randNth.incomingSeed` log statement.

Also nothing has changed the seed between the `RN.make.beginSeed` log statement
and the `randNth.incomingSeed` log statement but the first prints the Seed fine
and the second prints `<internal structure>`.
