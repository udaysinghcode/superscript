
= (fib 
   fn (x)
     if {x is 0}
        0
        if {x is 1}
           1
           {fib({x-1}) + fib({x-2})})
= (fib 
   fn (x)
     if {x is 0}
        0
        if {x is 1}
           1
           +(fib({x-1}) fib({x-2})))

