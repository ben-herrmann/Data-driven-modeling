include("draw_vectors.jl")

A = [3 4 1;
     7 3 2]

Q,R = qr(A')
x = 5*Q[:,3]

l = 1.2*norm(A)
set_theme!(theme_black())
fig = Figure(resolution=(1500,1200),fontsize=40)
ax = Axis3(fig[1,1],viewmode=:fit,
           limits=(-l,l,-l,l,-l,l),aspect=:data)
meshscatter!([0],[0],[0],color=:white,shading=false)
vectors!(A',color=:yellow)
plane!(A', color=(:cyan,0.6))
vectors!(x,color=:deeppink)
fig
