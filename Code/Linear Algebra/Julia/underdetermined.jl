include("draw_vectors.jl")

A = [3 4 1;
     7 3 2]

b = [-7;
     7]

x = pinv(A)*b




Q,R = qr(A')
U = 5*Q[:,1:2]
xN = 5*Q[:,3]

l = 1.2*norm(A)
set_theme!(theme_black())
fig = Figure(resolution=(1500,1200),fontsize=40)
ax = Axis3(fig[1,1],viewmode=:fit,
           limits=(-l,l,-l,l,-l,l),aspect=:data)
meshscatter!([0],[0],[0],color=:white,shading=false)
vectors!(xN,color=:deeppink)
vectors!(A',color=:yellow)
plane!(U, color=(:cyan,0.6))
vector!(x,color=:orange)
vectors!(x.+xN*[-1 -0.5 0.5 1],color=:cyan)
vectors!([-3xN 3xN],1.2x, color=:white)
fig
